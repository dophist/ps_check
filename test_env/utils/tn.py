#!/usr/bin/python3
import sys
for l in sys.stdin.readlines():
    l = l.strip()
    cols = l.split(maxsplit=1)
    text = ''
    key = cols[0]
    if (len(cols)) == 2:
        text = cols[1]
    text = text.replace('<COMMA>', ' ')
    text = text.replace('<PERIOD>', ' ')
    text = text.upper()
    sys.stdout.write(key + ' ' + text + '\n')

