# -*- coding: utf-8 -*-
import sys
import os
sys.path.append('../../_meta')
from prapy import graf
from numpy import log as ln
from numpy import log10 as log
import numpy as np
g = graf("tex")

data_location = "C:\BTSync\Skola\FJFI_2014_ZS\\vak\ulohy\\05_turbo\plt\data\\ascii\\"
d0 = g.loadtxt(name=data_location+"vypek.asc", skiprows=3, numcols=12)
d1 = g.loadtxt(name=data_location+"vypek001.asc", skiprows=3, numcols=12)
d2 = g.loadtxt(name=data_location+"vypek002.asc", skiprows=3, numcols=12)
d3 = g.loadtxt(name=data_location+"vypek003.asc", skiprows=3, numcols=12)


for i in [0,2,4,6,8,10]:
    d1[:,i] += 609      #d0.max(axis=0)[i]
    d2[:,i] += 21*60+20 #d1.max(axis=0)[i]
    d3[:,i] += 22*60+21 #...

d = np.vstack((d0,d1,d2,d3))

#He_min = d.min(axis=1)[3]
#for i in [1,3,5,7,9,11]:
#    d[:,i] -= He_min
    
e=np.split(d, 6, axis=1)

x = []
y = []
for pole in e:
    pole = pole[pole[:,1] != 0.0]
    a, b = g.unpack(pole)
    x.append(a)
    y.append(b)

fitting = False
if (fitting):
    def func(x,a,b):
        return a*x+b

    x_fit, y_fit = x, y

    ps, pe, fitlabel= g.fit(func, x_fit, ln(y_fit))

    y_fit = ps[0]*x+ps[1]

g.clf()

names = ["H", "He", "$\mathrm{H_2O}$", "O", "OH", "N/CO"]
for i in range(0,len(e)):
    g.semilogy(x[i],y[i], "+", label=names[i])#,'-', label=u"Naměřené hodnoty", ms=10)
if (fitting): g.plot(x,y_fit, label=fitlabel)

#g.ylim(-0.5e-7,4.5e-7)
#g.xlim(0,20)

g.cosmetics(labels=["$t$ [s]", "$p_s$ [Pa]"])

g.save(name='02_vypek')
g.show()
