#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from __future__ import division
from itertools import izip
import math
import sys
import urllib2
import os

flag_redownload = False

def download(base, shot_number, data_name):
    if not os.path.exists('files'):
        os.makedirs('files')
    if not os.path.exists('output'):
        os.makedirs('output')
    
    url = base+"/"+shot_number+"/"+data_name
    
    file_address = "files/"+data_name+"_"+shot_number+".txt"
    
    if ( (not os.path.isfile(file_address)) or flag_redownload):
        file_name = url.split('/')[-1]
        u = urllib2.urlopen(url)
        f = open(file_address, 'wb')
        meta = u.info()
        file_size = int(meta.getheaders("Content-Length")[0])
    
        print "Downloading: %s (%s Bytes)" % (file_name, file_size)
        
        file_size_dl = 0
        block_sz = 8192
        while True:
            buffer = u.read(block_sz)
            if not buffer:
                break
        
            file_size_dl += len(buffer)
            f.write(buffer)
            status = r"[%3.2f%%]  " % (file_size_dl * 100. / file_size)
            status = status + chr(8)*(len(status)+1)
            print status,
        f.close()
        print "\n"
    else:
        print "File "+data_name+"_"+shot_number+".txt already exists. Not downloading."    
    

# 1. stazeni datovych souboru    
# ---------------------------

# nazvy souboru, ktere chci stahnout
data_names = ['loop_voltage',
              'plasma_current', 
              'rake_probe_1', 
              'rake_probe_2', 
              'rake_probe_3']

# seznam cisel shotu, ktere me zajimaji   
shot_numbers = "14681 14683 14685 14709 14710 14711 14712"
mins          = "0.0225 0.02475 0.02445 0.0225 0.0225 0.0225 0.0225"
maxs          = "0.0230 0.02525 0.02495 0.0230 0.0230 0.0230 0.0230"

shot_numbers = shot_numbers.split(" ")
mins = mins.split(" ")
maxs = maxs.split(" ")   

base = "http://golem.fjfi.cvut.cz/utils/data/"
for shot_number in shot_numbers:
    for data_name in data_names:
        download(base, shot_number, data_name)
        
print("\n----\nAll data files are available, let's get to work!\n----\n")
        
# 2. vypocet T   
# ---------------------------

output2 = '#T computed from loop_voltage and plasma_current\n'

for i in range(0,len(shot_numbers)):
    folder = 'files'
    file_1 = folder+'/loop_voltage_'+shot_numbers[i]+'.txt'
    file_2 = folder+'/plasma_current_'+shot_numbers[i]+'.txt'
    output_name = 'output/T_merge_'+shot_numbers[i]+'.txt'
    
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

    T = sum(Tsum) / len(Tsum)
    Tsum2 = [(x-T)*(x-T) for x in Tsum]
    T_err = math.sqrt(sum(Tsum2)/(len(Tsum2)-1))
    print("Avg T for shot #"+shot_numbers[i]+" is ("+"{:5.2f}".format(T)+" +- "+"{:4.2f}".format(T_err)+")")
    output2 += "Avg T for shot #"+shot_numbers[i]+" is ("+"{:5.2f}".format(T)+" +- "+"{:4.2f}".format(T_err)+")\n"

    # Open a file
    fo = open(output_name, "wb")
    fo.write(output);
    fo.close()

fo = open('output/T_merge__output.txt', "wb")
fo.write(output2);
fo.close()

print("\n----\nTemperatures calculated and files merged!\n----\n")
        
# 3. merge VA 
# ---------------------------

for shot_number in shot_numbers:
    folder = 'files'
    file_1 = folder+'/rake_probe_3_'+str(shot_number)+'.txt'
    file_2 = folder+'/rake_probe_1_'+str(shot_number)+'.txt'
    output_name = 'output/VA_merge_'+str(shot_number)+'.txt'
    
    output = '#t[ms]      U[V]      I[A]\n'
    
    for line1, line2 in izip(open(file_1), open(file_2)):
        output += line1.split()[0] + "	" + line1.split()[1] + "	" + line2.split()[1] + "\n"
    
    # Open a file
    fo = open(output_name, "wb")
    fo.write(output)
    fo.close()
    print("File "+output_name+" sucessfully saved!")

print("\n----\nVA files merged!\n----\n")