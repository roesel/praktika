# -*- coding: utf-8 -*-
import sys
import os
sys.path.append('../../_meta')
from prapy import graf
from numpy import log as ln
from numpy import log10 as log

g = graf("tex")

d = g.loadtxt(name="04_lnp.txt")

x, y = g.unpack(d)

fitting = False
if (fitting):
    def func(x,a,b):
        return a*x+b

    x_fit, y_fit = x, y#g.slice_dom(d, 0, 250)

    ps, pe, fitlabel= g.fit(func, x_fit, ln(y_fit))

    y_fit = ps[0]*x+ps[1]

g.clf()
g.plot(x/60,ln(y),'o', color="blue", label=u"Naměřené hodnoty", ms=7)
if (fitting): g.plot(x,y_fit, label=fitlabel)

#g.ylim(800,1550)
#g.xlim(0,5)

g.cosmetics(labels=["$t$ [min]", "$\ln p$ [Pa]"])

g.save(name="04_lnp")
g.show()
