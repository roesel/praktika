# -*- coding: utf-8 -*-
import sys
sys.path.append('../../_meta')
from prapy import graf
from numpy import log as ln
from numpy import log10 as log

g = graf("tex")

d = g.loadtxt()
d2 = g.loadtxt(name="02_kryokryo.txt")

x, y = g.unpack(d)
x1, y1 = g.unpack(d2)

fitting = False
if (fitting):
    def func(x,a,b):
        return a*x+b

    x_fit, y_fit = x, y#g.slice_dom(d, 0, 250)
        
    ps, pe, fitlabel= g.fit(func, x_fit, ln(y_fit))

    y_fit = ps[0]*x+ps[1]

g.clf()
g.semilogy(x/60,y,'s', color="blue", label=u"rotačně-kryosorpční čerpání", ms=10)
g.semilogy(x1/60, y1, 'o', color="red", label=u"kryosorpčně-kryosorpční čerpání", ms=10)
if (fitting): g.plot(x,y_fit, label=fitlabel)

g.ylim(0.001,100000)
#g.xlim(0,20)

g.cosmetics(labels=["$t$ [min]", "$p$ [Pa]"])

g.save()
g.show()
