#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from __future__ import division
from itertools import izip
import matplotlib.pyplot as plt
from scipy import *
from scipy import optimize
import math
import urllib2
import os

# ---- TADY SE UPRAVUJE ----

# 1. jaké shoty chcete zpracovávat?
shot_numbers = "14681 14683 14685 14709 14710 14711 14712"

# 2. jaká jsou minima a maxima intervalu casu, ve kterych chcete pocitat (v poradi shotu)?
mins          = "0.0225 0.02475 0.02445 0.0225 0.0225 0.0225 0.0225" 
maxs          = "0.0230 0.02525 0.02495 0.0230 0.0230 0.0230 0.0230"

# 3. jaké je maximum napětí, na kterém se fitují V-A charakteristiky?
maxU          = -30

# ---- KONEC UPRAVOVANI ----

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
    
    # dost mozna vubec nepotrbuju output    

fo = open('output/T_merge__output.txt', "wb")
fo.write(output2);
fo.close()

print("\n----\nTemperatures calculated and files merged!\n----\n")
        
# 3. merge VA 
# ---------------------------
k=0
if not os.path.exists('graphs'):
    os.makedirs('graphs')
for shot_number in shot_numbers:
    folder = 'files'
    file_1 = folder+'/rake_probe_3_'+str(shot_number)+'.txt'
    file_2 = folder+'/rake_probe_1_'+str(shot_number)+'.txt'
    output_name = 'output/VA_merge_'+str(shot_number)+'.txt'
    
    output = '#t[ms]      U[V]      I[A]\n'
    
    t = []
    U = []
    I = []
    
    for line1, line2 in izip(open(file_1), open(file_2)):
        t_ = line1.split()[0]
        t.append(t_)
        u = line1.split()[1]
        U.append(float(u)*100)
        i = line2.split()[1]
        I.append(float(i)/22)
        output += t_ + "	" + u + "	" + i + "\n"
    
    # Open a file
    fo = open(output_name, "wb")
    fo.write(output)
    fo.close()
    #print("File "+output_name+" sucessfully saved!")
    
    
    # Finished outputting file for GNUplot, time to pyplot ourselves
    max_s = int(float(maxs[k])*10**6)
    min_s = int(float(mins[k])*10**6)

    # Fit the first set
    fitfunc = lambda p, x: p[0]*(1-exp((x-p[1])/p[2]))  # Target function
    errfunc = lambda p, x, y: fitfunc(p, x) - y  # Distance to the target function
    p0 = [0.011, -53.2, 16] # Initial guess for the parameters
    
    subUt = U[min_s:max_s]
    subU = [subUt[i] for i in range(0, len(subUt)) if subUt[i] <= maxU]
    subIt = I[min_s:max_s]
    subI = [subIt[i] for i in range(0, len(subUt)) if subUt[i] <= maxU]
    
    p1,cov,infodict,mesg,ier = optimize.leastsq(errfunc, p0[:], args=(subU, subI), full_output=True)
    
    #plt.clf()
    plt.figure(k+1)
    plt.legend(["V-A char. pro #"+shot_number, "fit   C="+str(p1[2])])
    print("V-A char. T (fit) for shot #"+shot_number+" is ("+"{:5.2f}".format(p1[2])+" +- ??)")
    
    #print p1
    
    line1 = plt.plot(subUt, subIt, linestyle='--', linewidth=0.1, antialiased=True)
    line2 = plt.plot(subUt, fitfunc(p1, subUt), linewidth=0.1, antialiased=True)
    plt.setp(line1, color='y', linewidth=1.0)
    plt.setp(line2, color='g', linewidth=1.0)
    plt.ylabel('I [A]')
    plt.xlabel('U [V]')
    plt.savefig('graphs/VA_merge_'+str(shot_number)+'.png')
    
    #plt.show()    
    
    k+=1
    
    #max_s = int(float(maxs[k])*10**6)
    
print("\n----\nVA files merged!\n----\n")