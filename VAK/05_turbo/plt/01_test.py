# -*- coding: utf-8 -*-
import sys
import os
sys.path.append('../../_meta')
from prapy import graf
from numpy import log as ln
from numpy import log10 as log

g = graf("tex")

data_location = "C:\BTSync\Skola\FJFI_2014_ZS\\vak\ulohy\\05_turbo\plt\data\\ascii\\"
d = g.loadtxt(name=data_location+"test.asc", skiprows=3)

x, y = g.unpack(d)

fitting = False
if (fitting):
    def func(x,a,b):
        return a*x+b

    x_fit, y_fit = x, y#g.slice_dom(d, 0, 250)

    ps, pe, fitlabel= g.fit(func, x_fit, ln(y_fit))

    y_fit = ps[0]*x+ps[1]

g.clf()
g.plot(x,y,'-', color="blue", label=u"Naměřené hodnoty", ms=10)
if (fitting): g.plot(x,y_fit, label=fitlabel)

g.ylim(-0.5e-7,4.5e-7)
#g.xlim(0,20)

g.cosmetics(labels=["$M$ [kg/mol]", "$n$ [-]"])

g.save(name='01_test')
g.show()
