# -*- coding: utf-8 -*-
import os
import numpy as np
from numpy import log as ln
from numpy import log10 as log
from matplotlib import rc
rc('font', family='Verdana')
rc('figure', figsize=(1.6180*7,7))
import matplotlib.pyplot as plt
from scipy.optimize import curve_fit
import math

def cf(string):
    ret = float(string.replace(",", "."))
    return ret

def round_by_err(x, x_err):
    x_err = round(x_err, -int(math.floor(math.log10(x_err))))
    x = round(x, -int(math.floor(math.log10(x_err))))
    return x, x_err

def get_pretty_param(value, error):
    val, err = round_by_err(value, error)
    pretty_param = "("+str(val)+u"\u00B1"+str(err)+")"
    pretty_param = pretty_param.replace(".", ",")
    return pretty_param

def get_named_param(param_str, value, error):
    named_param = param_str+" = "+get_pretty_param(value, error)
    return named_param

def func(x,a,b):
   return a*x+b

def script_name():
    return os.path.basename(os.path.realpath(__file__)).replace(".py", "")

def print_excel_params(ps, pe):
    for i in range(0, len(ps)):
        print str(i)+" "+str(ps[i])+" "+str(pe[i])

#x,y,z # z s errorama
d = np.loadtxt(script_name()+".txt", converters = {0: cf, 1: cf})
x,y = d[:,0],d[:,1]
#
#dfit = d[d[:, 0] < 250]
#popt,pcov = curve_fit(func, dfit[:,0], ln(dfit[:,1]))
#y_fit = popt[0]*x+popt[1]
#
#ps = popt
#pe = np.sqrt(np.diag(pcov))
#
##print_excel_params(ps, pe)
#
#print(get_named_param("a", ps[0], pe[0]))
#print(get_named_param("b", ps[1], pe[1]))

#plt.errorbar(x,y,yerr=z)  # errorbary
plt.clf()
plt.plot(x,y,'-.+', label=u"Naměřené hodnoty", ms=15)
#plt.plot(x,y_fit, label=u"Fitovaná funkce")

# Kosmetika
plt.grid()
plt.legend()
plt.ylabel(u"n [-]")
plt.xlabel(u"p [Pa]")
plt.ylim(5,25)
#plt.xlim(0,800)

#plt.text(200, 10, u'f(x)='+get_pretty_param(ps[0], pe[0])+'x+'+get_pretty_param(ps[1], pe[1])+'', fontsize=12)

# Uložení
plt.savefig(script_name()+".png")
plt.show()
