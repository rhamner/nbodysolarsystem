import matplotlib.pyplot as plt
import math

npoints=25000 #iteration parameters
dt = 0.001

m = [2E30, 6E24, 2E27, 6E23] #masses of sun, earth, jupiter, and mars respectively
x = [0, 1, 5.2, 1.67] #starting position on x-axis
y = [0, 0, 0, 0] #start a 0 on y-axis
vx = [0, 0, 0, 0] #start at 0 in x direction
vy = [0, 6.2832, 2.7549, 5.09] #average orbital speed

#placeholders for plot data
sunx = [];
suny = [];
earthx = [];
earthy = [];
jupiterx = [];
jupitery = [];
marsx = [];
marsy = [];

#iterate over entire time period
for i in range(0, npoints - 1):

    #iterate over all pairs of objects
    for j in range(0, len(m)):
        for k in range(j, len(m)):

            #for each pair, update velocities according to gravitational force
            if(k != j):
                dx = x[k] - x[j]
                dy = y[k] - y[j]
                D = dx*dx + dy*dy
                Fx = -(39.4784/D)*(dx/math.sqrt(D))
                Fy = -(39.4784/D)*(dy/math.sqrt(D))
                
                vx[k] = vx[k] + Fx*dt*m[j]/m[0]
                vy[k] = vy[k] + Fy*dt*m[j]/m[0]
                vx[j] = vx[j] - Fx*dt*m[k]/m[0]
                vy[j] = vy[j] - Fy*dt*m[k]/m[0]

    #update positions at the end
    for j in range(0, len(m)):
        x[j] = x[j] + vx[j]*dt
        y[j] = y[j] + vy[j]*dt

    sunx.append(x[0])
    suny.append(y[0])
    earthx.append(x[1])
    earthy.append(y[1])
    jupiterx.append(x[2])
    jupitery.append(y[2])
    marsx.append(x[3])
    marsy.append(y[3])


    #if math.fmod(i, 200) == 0:
        #plt.scatter(x[1], y[1], 40, [.25, .25, .95])
        #plt.scatter(x[0], y[0], 80, [.95, .7, .2])
        #plt.scatter(x[2], y[2], 60, [.25, .9, .25])
        #plt.xlim([-10, 10])
        #plt.ylim([-10, 10])
        #plt.draw()
        #plt.pause(0.005)
        #plt.clf()

plt.scatter(sunx, suny, 80, [.95, .7, .2])
plt.scatter(earthx, earthy, 40, [.25, .25, .95])
plt.scatter(jupiterx, jupitery, 60, [.25, .9, .25])
plt.scatter(marsx, marsy, 35, [.95, 0, 0])
plt.show()



