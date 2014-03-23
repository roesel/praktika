#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from itertools import izip
import sys

probe_number = sys.argv[1]
shots = ['14681', '14683', '14685']

file_1 = 'rake_probe_'+str(probe_number)+'_'+shots[0]+'.txt'
file_2 = 'rake_probe_'+str(probe_number)+'_'+shots[1]+'.txt'
file_3 = 'rake_probe_'+str(probe_number)+'_'+shots[2]+'.txt'

output_name = '135_merge_'+str(probe_number)+'.txt'

output = '#t[ms]    '+shots[0]+'    '+shots[1]+'    '+shots[2]

for line1, line2, line3 in izip(open(file_1), open(file_2), open(file_3)):
    output += line1.split()[0] + "	" + line1.split()[1] + "	" + line2.split()[1] + "	" + line3.split()[1] + "\n"

print(output)

# Open a file
print("\n")
fo = open(output_name, "wb")
fo.write(output);
fo.close()
print("File "+output_name+" sucessfully saved!")
