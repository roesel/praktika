# -*- coding: utf-8 -*-
import os
import numpy as np
from numpy import log as ln
from numpy import log10 as log
from scipy.optimize import curve_fit
import math
import inspect

class graf:
    def __init__(self, setting):
        global plt

        from matplotlib import rc
        if (setting=="tex"):
            rc('font',**{'family':'serif', 'serif':['Computer Modern'], 'size':15})
            rc('text', usetex=True)
            rc('text.latex', unicode=True)
        if (setting=="fast"):
            rc('font',**{'family':'sans-serif', 'sans-serif':['Verdana'], 'size':15})

        rc('figure', figsize=(1.6180*7,7))
        import matplotlib.pyplot as plt

    def cf(self, string):
        if (string=="-"):
            ret = 0
        else:
            ret = float(string.replace(",", "."))
        return ret

    def fc(self, flo):
        ret = str(flo)
        ret = ret.replace(".", ",")
        return ret

    def round_by_err(self, x, x_err):
        x_err = round(x_err, -int(math.floor(math.log10(x_err))))
        x = round(x, -int(math.floor(math.log10(x_err))))
        return x, x_err

    def get_pretty_param(self, value, error):
        val, err = self.round_by_err(value, error)
        pretty_param = "("+str(val)+u"\u00B1"+str(err)+")"
        pretty_param = pretty_param.replace(".", ",")
        return pretty_param

    def get_named_param(self, param_str, value, error):
        named_param = param_str+" = "+self.get_pretty_param(value, error)
        return named_param

    def script_name(self):
        #return os.path.basename(os.path.realpath(__file__)).replace(".py", "")
        name = inspect.stack()[-1][1]
        return name.replace(".py", "")

    def print_excel_params(self, ps, pe):
        delimeter = "\t"
        for i in range(0, len(ps)):
            print delimeter.join((str(i), self.fc(ps[i]), self.fc(pe[i])))

    def loadtxt(self, numcols=2, name="", decimal=",", skiprows=0):
        if (name==""):
            name = self.script_name()+".txt"
        if (decimal==","):
            converters = {i:self.cf for i in range (0,numcols) }
        return np.loadtxt(name, converters=converters, skiprows=skiprows)

    def clf(self):
        plt.clf()

    def semilogy(self, *args, **kwargs):
        plt.semilogy(*args, **kwargs)

    def plot(self, *args, **kwargs):
        plt.plot(*args, **kwargs)


    def cosmetics(self, labels=["x", "y"], grid=True, legend=True, loc=1):
        if grid: plt.grid()
        if legend: plt.legend(loc=loc)
        plt.xlabel(labels[0])
        plt.ylabel(labels[1])

    def xlim(self, *args, **kwargs):
        plt.xlim(*args, **kwargs)

    def ylim(self, *args, **kwargs):
        plt.ylim(*args, **kwargs)

    def errorbar(self, *args, **kwargs):
        plt.errorbar(*args, **kwargs)

    def save(self, name=""):
        if (name != ""):
            plt.savefig(name+'.pdf', format='pdf', dpi=1200)
        else:
            plt.savefig(self.script_name()+'.pdf', format='pdf', dpi=1200)

    def show(self):
        plt.show()

    def unpack(self, d1):
        x, y = d1[:,0],d1[:,1]
        return x, y

    def slice_dom(self, d,  min, max, unpack = True):
        dslicemax = d[d[:, 0] < max]
        d1 = dslicemax[dslicemax[:, 0] > min]
        if unpack: return d1[:,0],d1[:,1]

    def fit(self, *args, **kwargs):
        popt,pcov = curve_fit(*args, **kwargs)

        ps = popt
        pe = np.sqrt(np.diag(pcov))

        self.print_excel_params(ps, pe)

        print(self.get_named_param("a", ps[0], pe[0]))
        print(self.get_named_param("b", ps[1], pe[1]))

        fitlabel = u'f(x)='+self.get_pretty_param(ps[0], pe[0])+'x+'+self.get_pretty_param(ps[1], pe[1])+''

        return ps, pe, fitlabel
