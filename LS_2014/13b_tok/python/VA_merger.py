#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from itertools import izip
import sys

shot_number = sys.argv[1]

file_1 = 'rake_probe_3_'+str(shot_number)+'.txt'
file_2 = 'rake_probe_1_'+str(shot_number)+'.txt'
output_name = 'VA_merge_'+str(shot_number)+'.txt'

output = '#t[ms]      U[V]      I[A]\n'

for line1, line2 in izip(open(file_1), open(file_2)):
    output += line1.split()[0] + "	" + line1.split()[1] + "	" + line2.split()[1] + "\n"

print(output)

# Open a file
print("\n")
fo = open(output_name, "wb")
fo.write(output);
fo.close()
print("File "+output_name+" sucessfully saved!")
