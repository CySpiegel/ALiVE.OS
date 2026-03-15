#!/usr/bin/env python3
"""Convert ALiVE hash wrapper calls to native HashMap commands in SQF files."""
import re
import sys


def find_open_bracket(text, close_pos):
    """Find matching '[' for ']' at close_pos. Returns position or -1."""
    depth = 1
    pos = close_pos - 1
    while pos >= 0:
        if text[pos] == ']':
            depth += 1
        elif text[pos] == '[':
            depth -= 1
            if depth == 0:
                return pos
        pos -= 1
    return -1


def split_args(s):
    """Split comma-separated args respecting nested brackets and strings."""
    args = []
    depth = 0
    current = ''
    in_dq = False
    in_sq = False
    i = 0
    while i < len(s):
        c = s[i]
        if c == '"' and not in_sq:
            if in_dq:
                # Handle escaped double-quote "" in SQF format strings
                if i + 1 < len(s) and s[i + 1] == '"':
                    current += '""'
                    i += 2
                    continue
                in_dq = False
            else:
                in_dq = True
        elif c == "'" and not in_dq:
            in_sq = not in_sq
        if not in_dq and not in_sq:
            if c in '([{':
                depth += 1
            elif c in ')]}':
                depth -= 1
            elif c == ',' and depth == 0:
                args.append(current)
                current = ''
                i += 1
                continue
        current += c
        i += 1
    if current.strip():
        args.append(current)
    return args


def is_on_comment_line(text, pos):
    """Check if pos is on a line starting with //."""
    line_start = text.rfind('\n', 0, pos)
    line_start = 0 if line_start == -1 else line_start + 1
    return text[line_start:pos].lstrip().startswith('//')


def convert_file(filepath):
    with open(filepath, 'r') as f:
        text = f.read()

    pat = re.compile(r'call\s+\w+_fnc_(hash(?:Get|Set|Rem|Create))\b', re.IGNORECASE)
    changes = 0
    skipped = 0
    search_pos = 0

    for _ in range(800):
        m = pat.search(text, search_pos)
        if not m:
            break

        func = m.group(1).lower()
        call_end = m.end()

        # Skip commented lines
        if is_on_comment_line(text, m.start()):
            search_pos = call_end
            skipped += 1
            continue

        # hashCreate: [] call xxx_fnc_hashCreate -> createHashMap
        if func == 'hashcreate':
            before = text[:m.start()].rstrip()
            if before.endswith('[]'):
                start = len(before) - 2
                text = text[:start] + 'createHashMap' + text[call_end:]
                search_pos = start + len('createHashMap')
                changes += 1
            else:
                search_pos = call_end
                skipped += 1
            continue

        # Find ']' immediately before 'call'
        before = text[:m.start()]
        stripped = before.rstrip()
        if not stripped.endswith(']'):
            search_pos = call_end
            skipped += 1
            continue

        close_pos = len(stripped) - 1
        open_pos = find_open_bracket(text, close_pos)
        if open_pos < 0:
            search_pos = call_end
            skipped += 1
            continue

        args_str = text[open_pos + 1:close_pos]
        args = split_args(args_str)

        repl = None
        if func == 'hashget':
            if len(args) >= 3:
                repl = '{} getOrDefault [{}, {}]'.format(
                    args[0].strip(), args[1].strip(), args[2].strip())
            elif len(args) == 2:
                repl = '{} get {}'.format(args[0].strip(), args[1].strip())
        elif func == 'hashset':
            if len(args) >= 3:
                repl = '{} set [{}, {}]'.format(
                    args[0].strip(), args[1].strip(), args[2].strip())
        elif func == 'hashrem':
            if len(args) >= 2:
                repl = '{} deleteAt {}'.format(args[0].strip(), args[1].strip())

        if repl:
            text = text[:open_pos] + repl + text[call_end:]
            search_pos = open_pos
            changes += 1
        else:
            search_pos = call_end
            skipped += 1
            print(f"  SKIPPED: {func} with {len(args)} args at pos {m.start()}: {text[max(0,open_pos-10):call_end+10]}", file=sys.stderr)

    with open(filepath, 'w') as f:
        f.write(text)

    print(f"Converted {changes} calls, skipped {skipped} (comments/unparseable) in {filepath}")
    return changes


if __name__ == '__main__':
    total = 0
    for f in sys.argv[1:]:
        total += convert_file(f)
    print(f"Total: {total} conversions")
