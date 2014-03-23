#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from __future__ import division
from itertools import izip
import math
import sys

shots = "14681 14683 14685 14709 14710 14711 14712"
mins  = "0.0225 0.02475 0.02445 0.0225 0.0225 0.0225 0.0225"
maxs  = "0.0230 0.02525 0.02495 0.0230 0.0230 0.0230 0.0230"

# kaja
#mins  = "0.0225 0.02475 0.02445 0.02275 0.02275 0.02275 0.02275"
#maxs  = "0.0230 0.02525 0.02495 0.02325 0.02325 0.02325 0.02325"


shots = shots.split(" ")
mins = mins.split(" ")
maxs = maxs.split(" ")

output2 = '#T computed from loop_voltage and plasma_current\n'

for i in range(0,len(shots)):

    file_1 = 'loop_voltage_'+shots[i]+'.txt'
    file_2 = 'plasma_current_'+shots[i]+'.txt'
    output_name = 'T_merge_'+shots[i]+'.txt'

    output = '#t[ms]      Uloop[V]      Iplasma[A]    overT[eV]\n'
    Tsum = []

    for line1, line2 in izip(open(file_1), open(file_2)):
        t = float(line1.split()[0])
        Uloop = float(line1.split()[1])
        Ip = float(line2.split()[1])
        Zeff = 2.5
        k = 0.214
        try:
            T = k*math.pow((Zeff*Ip/Uloop), 2/3)
        except:
            T = 0;

        if t>float(mins[i]) and t<float(maxs[i]):
            Tsum.append(T);
        output += "    ".join([str(t), str(Uloop), str(Ip), str(T)]) + "\n"

    #print("len(Tsum) is "+str(len(Tsum)))
    #print("\n")
    T = sum(Tsum) / len(Tsum)
    Tsum2 = [(x-T)*(x-T) for x in Tsum]
    T_err = math.sqrt(sum(Tsum2)/(len(Tsum2)-1))
    print("Avg T for shot #"+shots[i]+" is ("+"{:5.3f}".format(T)+" +- "+"{:4.3f}".format(T_err)+")")
    output2 += "Avg T for shot #"+shots[i]+" is $("+"{:5.1f}".format(T)+" \pm "+"{:4.1f}".format(T_err)+")$\n"

    # Open a file
    fo = open(output_name, "wb")
    fo.write(output);
    fo.close()
    #print("File "+output_name+" sucessfully saved!")

fo = open('T_merge__output.txt', "wb")
fo.write(output2);
fo.close()
