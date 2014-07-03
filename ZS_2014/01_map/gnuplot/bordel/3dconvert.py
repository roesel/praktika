#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from itertools import izip
import sys

soubor = sys.argv[1]
sirka = int(sys.argv[2])

output_name = soubor+'_out.txt'

output = '#radek\t#sloupec\t#hodnota\n'

radek = -1
for line1 in open(soubor+".txt"):
    radek += 1
    for sloupec in range (0,sirka):
        output += str(radek)+"\t"+str(sloupec)+"\t"+line1.split()[sloupec]+"\n"

print(output)

# Open a file
print("\n")
fo = open(output_name, "wb")
fo.write(output);
fo.close()
print("File "+output_name+" sucessfully saved!")
