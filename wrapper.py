#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import json
import io

def get_r_lock():
    with open('/home/eero/.config/i3/rotatelock') as fp:
        if fp.readlines()[0].strip() is '1':
            return "🔒"
        else:
            return "🔓"

def get_b_lock_color():
    with open('/home/eero/.config/i3/brightnesslock') as fp:
        if fp.readlines()[0].strip() is '1':
            return "#00FF00"
        else:
            return "#FF0000"

def get_s_lock():
    with open('/home/eero/.config/i3/screenlock') as fp:
        if fp.readlines()[0].strip() is '0':
            return "☕";
        else:
            return ""

def get_debit():
    f = open('/home/eero/.config/i3status/debit', 'r')
    return f.read();

def print_line(message):
    """ Non-buffered printing to stdout. """
    sys.stdout.write(message + '\n')
    sys.stdout.flush()

def read_line():
    """ Interrupted respecting reader for stdin. """
    # try reading a line, removing any extra whitespace
    try:
        line = sys.stdin.readline().strip()
        # i3status sends EOF, or an empty line
        if not line:
            sys.exit(3)
        return line
    # exit on ctrl-c
    except KeyboardInterrupt:
        sys.exit()

if __name__ == '__main__':
    # Skip the first line which contains the version header.
    print_line(read_line())

    # The second line contains the start of the infinite array.
    print_line(read_line())

    while True:
        line, prefix = read_line(), ''
        # ignore comma at start of lines
        if line.startswith(','):
            line, prefix = line[1:], ','

        j = json.loads(line)
        # insert information into the start of the json, but could be anywhere
        # CHANGE THIS LINE TO INSERT SOMETHING ELSE
        j.append({'full_text' : '%s' %get_s_lock() , 'name' : 'sLock'})
        j.append({'full_text' : '💡' , 'name' : 'bLock' , 'color' : '%s' % get_b_lock_color()})
        j.append({'full_text' : '%s' % get_r_lock() , 'name' : 'rLock'})
        j.insert(0, {'full_text' : '%s' % get_debit() , 'name' : 'debit', 'color' : '#00FF00'})
        # and echo back new encoded json
        print_line(prefix+json.dumps(j))
