"""Structural features of each unpacked zip, read as text (nothing is run).

    python3 -I features.py <folder-of-zips> <out.tsv>

One row per immediate subfolder. The row says what the zip is made of (its
class, package set, zip-local class and style files, whether it holds a sample
document) so that near-duplicates can be dropped and the rest chosen to be as
different as possible.
"""
import json, os, re, sys

COMMENT = re.compile(r'(?<!\\)%.*$', re.M)
DOCCLASS = re.compile(r'\\documentclass\s*(?:\[([^\]]*)\])?\s*\{([^}]+)\}')
USEPKG = re.compile(r'\\(?:usepackage|RequirePackage|RequirePackageWithOptions)\s*(?:\[[^\]]*\])?\s*\{([^}]*)\}')
LOADCLASS = re.compile(r'\\(?:LoadClass|LoadClassWithOptions)\s*(?:\[[^\]]*\])?\s*\{([^}]+)\}')
HINTS = {
    'xelualatex': r'\{(fontspec|unicode-math|luacode|luatextra|polyglossia|xeCJK|ctex|luatexja|xunicode)\}|\\directlua',
    'tikz': r'\{(tikz|pgf|pgfplots|tikz-cd|tikzposter|tikzpagenodes)\}',
    'minted': r'\{minted\}',
    'beamer': r'\\documentclass[^{]*\{beamer\}',
    'bibtex': r'\\bibliography\{|\\bibliographystyle',
    'biblatex': r'\{biblatex\}',
    'makefile': r'^(?:all|pdf)\s*:',
}


def read(path, limit=400_000):
    try:
        with open(path, 'rb') as f:
            return f.read(limit).decode('utf8', 'replace')
    except OSError:
        return ''


def features(folder):
    files, total = [], 0
    for dirpath, _, names in os.walk(folder):
        for n in names:
            p = os.path.join(dirpath, n)
            try:
                size = os.path.getsize(p)
            except OSError:
                continue
            files.append((os.path.relpath(p, folder), size))
            total += size
    by_ext = lambda e: [f for f, _ in files if f.lower().endswith(e)]  # noqa: E731
    tex, cls, sty = by_ext('.tex'), by_ext('.cls'), by_ext('.sty')
    dtx = by_ext('.dtx') + by_ext('.ins')
    samples = []
    for f in tex:
        text = COMMENT.sub('', read(os.path.join(folder, f)))
        m = DOCCLASS.search(text)
        if m and r'\begin{document}' in text:
            samples.append((f, m.group(1) or '', m.group(2).strip(), len(text)))
    # The sample the analysis starts from: shallow first, then a conventional name, then the longest.
    named = re.compile(r'(^|/)(main|template|example|sample|paper|thesis|cv|resume|poster|slides|article|report|letter|document|manuscript|skeleton)[^/]*\.tex$', re.I)
    samples.sort(key=lambda s: (s[0].count('/'), 0 if named.search(s[0]) else 1, -s[3]))
    main = samples[0] if samples else None
    pkgs, locals_ = set(), {}
    # A package or class that ships as .dtx/.ins has no .cls/.sty yet; its code is in the .dtx (the
    # unprefixed lines), and its \Provides line names what it defines.
    scan = [os.path.join(folder, s[0]) for s in samples[:3]] + [os.path.join(folder, f) for f in cls + sty + dtx]
    provided = set()
    for f in dtx:
        for m in re.finditer(r'\\Provides(?:Class|Package)\s*\{([^}]+)\}', read(os.path.join(folder, f))):
            provided.add(m.group(1).strip())
    texts = []
    for p in scan:
        text = COMMENT.sub('', read(p))
        texts.append(text)
        for m in USEPKG.finditer(text):
            pkgs.update(x.strip() for x in m.group(1).split(',') if x.strip())
        for m in LOADCLASS.finditer(text):
            pkgs.add('class:' + m.group(1).strip())
    local_names = {os.path.splitext(os.path.basename(f))[0] for f in cls + sty}
    blob = '\n'.join(texts)
    hints = [k for k, rx in HINTS.items() if re.search(rx, blob, re.M)]
    cls_lines = sum(read(os.path.join(folder, f)).count('\n') for f in cls + sty)
    return {
        'n_files': len(files), 'bytes': total, 'n_tex': len(tex), 'n_cls': len(cls), 'n_sty': len(sty),
        'n_dtx': len(by_ext('.dtx')), 'n_bst': len(by_ext('.bst')),
        'has_sample': bool(samples), 'n_samples': len(samples),
        'main': main[0] if main else '', 'docclass': main[2] if main else '', 'options': main[1] if main else '',
        'local_class': ';'.join(sorted({os.path.splitext(os.path.basename(f))[0] for f in cls} | provided)),
        'local_sty': ';'.join(sorted(os.path.splitext(os.path.basename(f))[0] for f in sty))[:300],
        'pkgs': ';'.join(sorted(p for p in pkgs if p not in local_names)),
        'pkgs_local': ';'.join(sorted(p for p in pkgs if p in local_names)),
        'hints': ','.join(hints), 'cls_sty_lines': cls_lines,
    }


def main():
    root, out = sys.argv[1], sys.argv[2]
    rows = []
    for name in sorted(os.listdir(root)):
        folder = os.path.join(root, name)
        if os.path.isdir(folder) and not name.endswith('.part'):
            rows.append({'folder': name, **features(folder)})
    fields = list(rows[0].keys()) if rows else ['folder']
    with open(out, 'w', encoding='utf8') as f:
        f.write('\t'.join(fields) + '\n')
        for r in rows:
            f.write('\t'.join(str(r[k]).replace('\t', ' ').replace('\n', ' ') for k in fields) + '\n')
    print('features', len(rows))


if __name__ == '__main__':
    main()
