#!/usr/bin/env python3

import argparse
import enum
import re


# The following regexp match the typical markers of refrain and couplet:
re_refrain = re.compile(r'(R(efrain)?|C(horus)?)( |[-./] ?)', re.IGNORECASE)
re_couplet = re.compile(r'\d+( |[-./] ?)')
re_txt_ext = re.compile(r'\.te?xt$')


def match_rest(regexp, s):
    """Match the start of string s against the given regexp:
    * if it matches, return the non-matching part;
    * it it does not matches, return None."""
    if (m := regexp.match(s)) is not None:
        return s[m.end():]
    else:
        return None


class State(enum.Enum):
    """A state indicates in what context we are while parsing a song."""
    LIMBO   = 0 # Not in the refrain or in a couplet
    REFRAIN = 1 # In the refrain
    COUPLET = 2 # In a couplet


def parse_song(lines, re_refrain, re_couplet):
    # At the beginning of the song, we are not in the refrain or in a couplet.
    state = State.LIMBO
    # This variable will be used to record the longest line seen so far.
    longest = ''
    for line in lines:
        line = line.rstrip()
        if state == State.LIMBO:
            # We are not in the refrain or in a couplet. Depending on what we find:
            if (rest := match_rest(re_refrain, line)) is not None:
                # when a refrain start marker is found, enter the refrain.
                yield '\\begin{refrain}\n'
                state = State.REFRAIN
                line = rest
                yield '  {}'.format(line)
            elif (rest := match_rest(re_couplet, line)) is not None:
                # when a couplet start marker is found, enter a couplet.
                yield '\\begin{couplet}\n'
                state = State.COUPLET
                line = rest
                yield '  {}'.format(line)
            elif line != '':
                # when a non-empty line is found, also enter a couplet as all.
                yield '\\begin{couplet}\n'
                state = State.COUPLET
                yield '  {}'.format(line)
        elif state == State.REFRAIN:
            # We are in the refrain. Depending on what we find:
            if line != '':
                # when a non-empty line is found, stay in the refrain.
                yield ' \\\\\n  {}'.format(line)
            else:
                # when an empty line is found, leave the refrain.
                yield '\n\\end{refrain}\n\n'
                state = State.LIMBO
        elif state == State.COUPLET:
            # We are in a couplet. Depending on what we find:
            if line != '':
                # when a non-empty line is found, stay in the couplet.
                yield ' \\\\\n  {}'.format(line)
            else:
                # when an empty line is found, leave the couplet.
                yield '\n\\end{couplet}\n\n'
                state = State.LIMBO
        # No matter what we found, we have a song line, possibly empty, that we
        # have to check to see if it could not be the new longest line seen so far.
        if len(line) > len(longest):
            longest = line
    # The song text file is now finished. We may still be in the refrain or in a
    # couplet, that we have to close.
    if state == State.REFRAIN:
        yield '\n\\end{refrain}\n\n'
    elif state == State.COUPLET:
        yield '\n\\end{couplet}\n\n'
    # Now print the longest line of the entire song.
    yield '\\longest{{{}}}\n'.format(longest)


def main(args=None):
    parser = argparse.ArgumentParser(description="Convert song text to LaTeX songproj markup")
    parser.add_argument("--refrain", '-r', type=re.compile, default=re_refrain, metavar="REGEXP",
            help="specify the refrain marker (regexp, default to \"{}\")".format(re_refrain.pattern))
    parser.add_argument("--couplet", '-c', type=re.compile, default=re_couplet, metavar="REGEXP",
            help="specify the couplet marker (regexp, default \"{}\")".format(re_couplet.pattern))
    parser.add_argument("infile", help="input song text file", type=argparse.FileType('r'))
    parser.add_argument("outfile", help="output LaTeX file", type=argparse.FileType('w'), nargs='?')
    args = parser.parse_args(args)
    if args.outfile is None:
        try:
            args.outfile = open(re_txt_ext.sub('', args.infile.name) + '.tex', 'w')
        except AttributeError:
            parser.error("the following argument is required: outfile")
    for line in parse_song(args.infile, args.refrain, args.couplet):
        args.outfile.write(line)

if __name__ == "__main__":
    main()
