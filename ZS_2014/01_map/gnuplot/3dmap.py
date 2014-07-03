#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import sys

from mpl_toolkits.mplot3d import Axes3D
from matplotlib import cm
from matplotlib.ticker import LinearLocator, FormatStrFormatter
import matplotlib.pyplot as plt
import numpy as np

dpi = 200

plt.clf()
plt.close('all')

fig = plt.figure()

ax = fig.gca(projection='3d')

soubor = sys.argv[1]
sirka = int(sys.argv[2])

output_name = soubor+'_out.txt'

output = '#radek\t#sloupec\t#hodnota\n'

z = np.ndarray([12, 12])
i = -1
for line1 in open(soubor+".txt"):
    i += 1
    for j in range (0,sirka):
        z[i][j]=(float(line1.split()[j].replace(',', '.')))

x = np.arange(1, 13, 1)
y = np.arange(1, 13, 1)
x, y = np.meshgrid(x, y)

surf = ax.plot_surface(x, y, z, cmap=cm.coolwarm, rstride=1, cstride=1, linewidth=0, antialiased=False)
bar = plt.colorbar(surf, shrink=0.5, label="U [V]")
ax.set_xlim(1, 12)
ax.set_ylim(1, 12)
ax.set_zlabel('U [V]')
ax.set_ylabel('y [-]')
ax.set_xlabel('x [-]')

#ax.zaxis.set_major_locator(LinearLocator(10))
ax.zaxis.set_major_formatter(FormatStrFormatter('%.0f'))
ax.yaxis.set_ticks(np.arange(1,13,1))
ax.xaxis.set_ticks(np.arange(1,13,1))
pismenka = ["L", "K", "J", "I", "H", "G", "F", "E", "D", "C", "B", "A"]
ax.xaxis.set_ticklabels(pismenka)
ax.view_init(25, 35)
#fig.colorbar(surf, shrink=0.5, aspect=5)

#plt.show()


plt.savefig(soubor+".png", dpi=dpi, facecolor='w', edgecolor='w',
        orientation='portrait', papertype=None, format=None,
        transparent=False, bbox_inches=None, pad_inches=0.1,
        frameon=None)

fig1 = plt.figure()

ax = fig1.gca()     

x = np.arange(1, 13, 1)
y = np.arange(1, 13, 1)
x, y = np.meshgrid(x, y)

levels = np.linspace(z.min(), z.max(), 20)
surf = ax.contourf(13-x, 13-y, z, cmap=cm.coolwarm, rstride=1, cstride=1, linewidth=0, antialiased=True, levels=levels)
bar = plt.colorbar(surf, label="U [V]")
ax.set_xlim(1, 12)
ax.set_ylim(1, 12)
      
ax.set_ylabel('y [-]')
ax.set_xlabel('x [-]')

ax.yaxis.set_ticks(np.arange(1,13,1))
ax.xaxis.set_ticks(np.arange(1,13,1))
pismenka = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L"]
cisla = [str(12-x) for x in range(0,12)]
ax.xaxis.set_ticklabels(pismenka)
ax.xaxis.tick_top()
ax.xaxis.set_label_position('top')
ax.yaxis.set_ticklabels(cisla)
                       
#plt.show() 
                                                                        
plt.savefig(soubor+"_map.png", dpi=dpi, facecolor='w', edgecolor='w',
        orientation='portrait', papertype=None, format=None,
        transparent=False, bbox_inches=None, pad_inches=0.1,
        frameon=None)