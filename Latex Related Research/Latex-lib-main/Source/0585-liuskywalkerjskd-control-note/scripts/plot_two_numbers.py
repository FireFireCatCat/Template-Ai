"""Generate figures for the 'Two Numbers: e and pi' section (EN + ZH)."""

import numpy as np
import matplotlib.pyplot as plt
import matplotlib.gridspec as gridspec

# ── Localised strings ────────────────────────────────────────
STRINGS = {
    'en': {
        'unit_circle': 'Unit Circle',
        'one_period': r'One Full Period = $2\pi$',
        'growth': 'growth',
        'constant': 'constant',
        'decay': 'decay',
        'fast_decay': 'fast decay',
        'exp_title': r'Exponential $e^{at}$: sign of $a$ decides everything',
        'stable': r'Stable ($a<0$)',
        'unstable': r'Unstable ($a>0$)',
        'amplitude': 'Amplitude',
        'envelope_label': r'Envelope $e^{\sigma t}$',
        'response_label': r'Response $e^{\sigma t}\cos(\omega t)$',
        'damped_title': r'$e$ controls the envelope, $\pi$ controls the frequency',
        'decay_rate': r'$e$ (decay rate)',
    },
    'zh': {
        'unit_circle': '单位圆',
        'one_period': r'一个完整周期 = $2\pi$',
        'growth': '增长',
        'constant': '不变',
        'decay': '衰减',
        'fast_decay': '快速衰减',
        'exp_title': r'指数函数 $e^{at}$：$a$ 的正负决定一切',
        'stable': r'稳定 ($a<0$)',
        'unstable': r'不稳定 ($a>0$)',
        'amplitude': '幅值',
        'envelope_label': r'包络线 $e^{\sigma t}$',
        'response_label': r'响应 $e^{\sigma t}\cos(\omega t)$',
        'damped_title': r'$e$ 控制包络，$\pi$ 控制频率',
        'decay_rate': r'$e$（衰减速率）',
    },
}


def _rc(lang):
    """Return rcParams dict for the given language."""
    base = {
        'font.size': 11,
        'mathtext.fontset': 'cm',
        'axes.linewidth': 0.8,
        'lines.linewidth': 1.5,
        'figure.dpi': 150,
        'savefig.bbox': 'tight',
        'savefig.pad_inches': 0.1,
    }
    if lang == 'zh':
        base['font.family'] = 'sans-serif'
        base['font.sans-serif'] = ['Noto Sans SC', 'DejaVu Sans']
        base['axes.unicode_minus'] = False
    else:
        base['font.family'] = 'serif'
    return base


# ── Figure 1: Unit circle → sinusoid  (pi) ──────────────────
def fig_circle_sinusoid(outpath, lang='en'):
    S = STRINGS[lang]
    plt.rcParams.update(_rc(lang))

    fig = plt.figure(figsize=(8, 3.2))
    gs = gridspec.GridSpec(1, 2, width_ratios=[1, 2.2], wspace=0.35)

    theta = np.linspace(0, 2 * np.pi, 300)
    t_wave = np.linspace(0, 2 * np.pi, 300)

    # -- left: unit circle --
    ax1 = fig.add_subplot(gs[0])
    ax1.set_aspect('equal')
    ax1.plot(np.cos(theta), np.sin(theta), 'k', lw=1.2)

    angle = np.pi / 3
    px, py = np.cos(angle), np.sin(angle)
    ax1.plot([0, px], [0, py], 'C3', lw=1.8)
    ax1.plot(px, py, 'C3o', ms=6, zorder=5)

    ax1.plot([px, px], [0, py], 'C0--', lw=1, alpha=0.7)
    ax1.plot([0, px], [py, py], 'C1--', lw=1, alpha=0.7)

    arc_t = np.linspace(0, angle, 40)
    ax1.plot(0.25 * np.cos(arc_t), 0.25 * np.sin(arc_t), 'k', lw=0.8)
    ax1.text(0.32, 0.15, r'$t$', fontsize=11)

    ax1.text(px + 0.08, py / 2, r'$\sin t$', fontsize=10, color='C0')
    ax1.text(px / 2, -0.18, r'$\cos t$', fontsize=10, color='C1', ha='center')

    ax1.set_xlim(-1.35, 1.35)
    ax1.set_ylim(-1.35, 1.35)
    ax1.axhline(0, color='k', lw=0.4)
    ax1.axvline(0, color='k', lw=0.4)
    ax1.set_xticks([-1, 1])
    ax1.set_yticks([-1, 1])
    ax1.set_title(S['unit_circle'], fontsize=12)

    # -- right: sinusoid --
    ax2 = fig.add_subplot(gs[1])
    ax2.plot(t_wave, np.cos(t_wave), 'C1', label=r'$\cos t$')
    ax2.plot(t_wave, np.sin(t_wave), 'C0', label=r'$\sin t$')

    ax2.axhline(0, color='k', lw=0.4)
    ax2.set_xlim(0, 2 * np.pi)
    ax2.set_ylim(-1.3, 1.3)
    ax2.set_xticks([0, np.pi / 2, np.pi, 3 * np.pi / 2, 2 * np.pi])
    ax2.set_xticklabels([r'$0$', r'$\frac{\pi}{2}$', r'$\pi$',
                         r'$\frac{3\pi}{2}$', r'$2\pi$'])
    ax2.set_yticks([-1, 0, 1])
    ax2.set_xlabel(r'$t$')
    ax2.set_title(S['one_period'], fontsize=12)
    ax2.legend(loc='upper right', fontsize=10, framealpha=0.9)
    ax2.axvline(angle, color='C3', ls=':', lw=1, alpha=0.6)

    fig.savefig(outpath)
    plt.close(fig)
    print(f'  saved {outpath}')


# ── Figure 2: Exponential growth / decay  (e) ───────────────
def fig_exponential(outpath, lang='en'):
    S = STRINGS[lang]
    plt.rcParams.update(_rc(lang))

    fig, ax = plt.subplots(figsize=(5.5, 3.5))
    t = np.linspace(0, 5, 300)

    for a, key, color, ls in [
        ( 0.5, 'growth',     'C3', '-'),
        ( 0.0, 'constant',   'k',  '--'),
        (-0.5, 'decay',      'C0', '-'),
        (-1.0, 'fast_decay', 'C0', ':'),
    ]:
        label = f'$a = {a:+.1f}$ ({S[key]})'
        ax.plot(t, np.exp(a * t), color=color, ls=ls, lw=1.6, label=label)

    ax.set_xlabel(r'$t$')
    ax.set_ylabel(r'$e^{at}$')
    ax.set_title(S['exp_title'], fontsize=12)
    ax.set_xlim(0, 5)
    ax.set_ylim(0, 4)
    ax.legend(fontsize=9, loc='upper left', framealpha=0.9)
    ax.axhline(1, color='grey', lw=0.4, ls='-')

    ax.annotate(S['stable'], xy=(4, np.exp(-0.5 * 4)), fontsize=9,
                color='C0', va='top')
    ax.annotate(S['unstable'], xy=(3.2, np.exp(0.5 * 3.2)), fontsize=9,
                color='C3', va='bottom')

    fig.tight_layout()
    fig.savefig(outpath)
    plt.close(fig)
    print(f'  saved {outpath}')


# ── Figure 3: Damped oscillation  (e + pi together) ─────────
def fig_damped_oscillation(outpath, lang='en'):
    S = STRINGS[lang]
    plt.rcParams.update(_rc(lang))

    fig, ax = plt.subplots(figsize=(6, 3.5))
    t = np.linspace(0, 8, 500)

    sigma = -0.4
    omega = 2 * np.pi * 0.8

    envelope = np.exp(sigma * t)
    oscillation = np.cos(omega * t)
    response = envelope * oscillation

    ax.fill_between(t, -envelope, envelope, color='C3', alpha=0.08)
    ax.plot(t, envelope, 'C3--', lw=1.2, label=S['envelope_label'])
    ax.plot(t, -envelope, 'C3--', lw=1.2)
    ax.plot(t, response, 'C0', lw=1.8, label=S['response_label'])

    ax.axhline(0, color='k', lw=0.4)
    ax.set_xlabel(r'$t$')
    ax.set_ylabel(S['amplitude'])
    ax.set_xlim(0, 8)
    ax.set_ylim(-1.15, 1.15)
    ax.set_title(S['damped_title'], fontsize=12)
    ax.legend(fontsize=9, loc='upper right', framealpha=0.9)

    ax.annotate(S['decay_rate'],
                xy=(2.5, np.exp(sigma * 2.5)),
                xytext=(3.5, 0.9),
                fontsize=9, color='C3',
                arrowprops=dict(arrowstyle='->', color='C3', lw=1))
    period = 2 * np.pi / omega
    t1, t2 = 0.0, period
    y_arr = -0.95
    ax.annotate('', xy=(t1, y_arr), xytext=(t2, y_arr),
                arrowprops=dict(arrowstyle='<->', color='C0', lw=1.2))
    ax.text((t1 + t2) / 2, y_arr - 0.12,
            r'$T = \frac{2\pi}{\omega}$', fontsize=10,
            color='C0', ha='center')

    fig.tight_layout()
    fig.savefig(outpath)
    plt.close(fig)
    print(f'  saved {outpath}')


# ── Main ─────────────────────────────────────────────────────
if __name__ == '__main__':
    print('Generating figures for "Two Numbers" section...')

    # English
    fig_circle_sinusoid('figures/circle_sinusoid.pdf', lang='en')
    fig_exponential('figures/exponential_growth_decay.pdf', lang='en')
    fig_damped_oscillation('figures/damped_oscillation.pdf', lang='en')

    # Chinese
    fig_circle_sinusoid('figures_zh/circle_sinusoid.pdf', lang='zh')
    fig_exponential('figures_zh/exponential_growth_decay.pdf', lang='zh')
    fig_damped_oscillation('figures_zh/damped_oscillation.pdf', lang='zh')

    print('Done.')
