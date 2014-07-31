##
## Simulate Shuttle model 
## Created by Adam L MacLean on 24.06.2014
##

from numpy import *
from scipy.integrate import *
import matplotlib.pyplot as plt
import matplotlib

  
# INPUTS
tstep = 0.001
endt = 100

## PARAMETERS

## Param for multistability (last 5 entries are conserved amounts)
param = [ 92.331732, 0.86466471, 79.9512906, 97.932525, 1, 3.4134082 , 0.61409879, 0.61409879, 3.4134082, 0.98168436, 0.981684, 4.7267833,0.17182818, 0.68292191, 1.0, 3.2654672, 0.61699064, 0.61699064, 37.913879, 0.86466471, 0.86466471, 0.99326205, 0.99326205, 1.0, 5.9744464, 1.7182818, 1.7182818, 1.7182818, 1.7182818, 0.55950727, 1.0117639 ];
param = param + [ 16.4734, 4.9951, 1.60063, 1.20891, 2.77566];
#param = [92.331732, 0.86466471, 79.9512906, 97.932525, 1, 3.4134082 , 0.61409879, 0.61409879, 3.4134082, 0.98168436, 0.981684, 4.7267833, 0.17182818, 0.68292191, 1.0, 3.2654672, 0.61699064, 0.61699064, 37.913879, 0.86466471, 0.86466471, 0.99326205, 0.99326205, 1.0, 5.9744464, 1.7182818, 1.7182818, 1.7182818, 1.7182818, 0.55950727, 1.0117639 ];
#                  0   1    2    3    4    5   6   7     8    9   10    11    12   13                    
# IC here are for [X, Cxy, Yc, Cyd, Cyp, Yon, Xn, Cxyn, Ycn, Dan, Cydn, Cypn, Di, Cxtn]   
ic1 = [0.1, 0.15, 1.0, 0.628, 1.018, 1.05, 0.05, 5.819, 1.0067, 0.58, 1.62, 1.15, 0.582, 1.0]

# Conserved totals are [Y (Yo), D (Da), P, Pn, Tn] => [x1, x5, x7, x15, x18]

# MODEL
def model_odes(y, t, parameters):

	dxdt=zeros(14)
	par=parameters
	k1=par[0]
	k2=par[1]
	k3=par[2]
	k4=par[3]
	k5=par[4]
	k6=par[5]
	k7=par[6]
	k8=par[7]
	k9=par[8]
	k10=par[9]
	k11=par[10]
	k12=par[11]
	k13=par[12]
	k14=par[13]
	k15=par[14]
	k16=par[15]
	k17=par[16]
	k18=par[17]
	k19=par[18]
	k20=par[19]
	k21=par[20]
	k22=par[21]
	k23=par[22]
	k24=par[23]
	k25=par[24]
	k26=par[25]
	k27=par[26]
	k28=par[27]
	k29=par[28]
	k30=par[29]
	k31=par[30]
	x1tot=par[31]
	x5tot=par[32]
	x7tot=par[33]
	x15tot=par[34]
	x18tot=par[35]
	
	x2 = y[0]   #X 
	x3  = y[1]  #CXY
	x4  = y[2]  #Yc
	x6  = y[3]  #Cyd
	x8  = y[4]  #Cyp
	x9  = y[5]  #Yon
	x10 = y[6]  #Xn
	x11 = y[7]  #Cxyn
	x12 = y[8]  #Ycn
	x13 = y[9]  #Dan
	x14 = y[10] #Cydn
	x16 = y[11] #Cypn
	x17 = y[12] #Di
	x19 = y[13] #X
	
#                  0   1    2    3    4    5   6   7     8    9   10    11    12   13                    
# IC here are for [X, Cxy, Yc, Cyd, Cyp, Yon, Xn, Cxyn, Ycn, Dan, Cydn, Cypn, Di, Cxtn]   
	
	#print k4-k5*x2-k25*x2-k1*(x1tot-x3-x4-x6-x8-x9-x11-x12-x14-x16)*x2+k2*x3+k24*x10
	#print k4;
	#print k5*x2 
	#print k25*x2
	#print k1
	#print (x1tot-x3-x4-x6-x8-x9-x11-x12-x14-x16)
	#print k1*(x1tot-x3-x4-x6-x8-x9-x11-x12-x14-x16)*x2
	#print k2*x3
	#print k24*x10

	dxdt[0]   =  k4-k5*x2-k25*x2-k1*(x1tot-x3-x4-x6-x8-x9-x11-x12-x14-x16)*x2+k2*x3+k24*x10						    
	dxdt[1]   =  k1*(x1tot-x3-x4-x6-x8-x9-x11-x12-x14-x16)*x2-k2*x3-k3*x3									    
	dxdt[2]   =  -k22*x4+k8*x6-k9*x4*(x7tot-x8)+k10*x8+k23*x12										    
	dxdt[3]   =  k6*(x1tot-x3-x4-x6-x8-x9-x11-x12-x14-x16)*(x5tot-x6-x13-x14-x17)-k7*x6-k8*x6	
	dxdt[4]   =  k9*x4*(x7tot-x8)-k10*x8-k11*x8												    
	dxdt[5]   =  -k12*x9*x10+k13*x11+k14*x11-k16*x9*x13+k17*x14+k21*x16						
	dxdt[6]   =  k25*x2-k15*x10-k24*x10-k12*x9*x10+k13*x11-k30*x10*(x18tot-x19)+k31*x19			
	dxdt[7]   =  k12*x9*x10-k13*x11-k14*x11												    
	dxdt[8]   =  k22*x4-k23*x12+k18*x14-k19*x12*(x15tot-x16)+k20*x16									    
	dxdt[9]   =  k26*(x5tot-x6-x13-x14-x17)-k27*x13-k16*x9*x13+k17*x14+k18*x14					
	dxdt[10]  =  k16*x9*x13-k17*x14-k18*x14												    
	dxdt[11]  =  k19*x12*(x15tot-x16)-k20*x16-k21*x16											    
	dxdt[12]  =  k29*(x5tot-x6-x13-x14-x17)-k28*x17											    
	dxdt[13]  =  k30*x10*(x18tot-x19)-k31*x19
    
 	return(dxdt)


font = {'size': 25}
matplotlib.rc('font', **font)

def main():
	
	""" Integrate ODEs:
	odeint(model function, intial conditions, times, parameter set) """
	Y3A = odeint(model_odes, ic1, arange(0, endt, tstep), args=(param,))

	stuff = model_odes(ic1, 0, param )

	for i in range( 0, 14 ):
		print i + 1, '=', stuff[ i ], ", Y(", i, ")=",Y3A[-1,i]
	
	return

    # IC here are for [X, Cxy, Yc, Cyd, Cyp, Yon, Xn, Cxyn, Ycn, Dan, Cydn, Cypn, Di, Cxtn]   
	plt.plot(arange(0, endt, tstep), Y3A[:,0], color="blue",  linewidth=4.5, label="X")
	plt.plot(arange(0, endt, tstep), Y3A[:,2], color="red",  linewidth=4.5, label="Yc")
	plt.plot(arange(0, endt, tstep), Y3A[:,3], color="purple",  linewidth=4.5, label="Cyd")
	plt.plot(arange(0, endt, tstep), Y3A[:,6], color="blue",  linewidth=4.5, label="Xn")
	plt.plot(arange(0, endt, tstep), Y3A[:,8], color="green",  linewidth=4.5, label="Ycn")
	plt.plot(arange(0, endt, tstep), Y3A[:,11], color="pink",  linewidth=4.5, label="Cypn")
	plt.plot(arange(0, endt, tstep), Y3A[:,13], color="yellow",  linewidth=4.5, label="Cxtn")
	plt.legend(loc=1, prop={'size':20})

	#plt.xlim((0.0, 10.6))
	#plt.ylim((0.5, 2.0))
	#plt.xticks([0, 150, 300])

	#plt.show()
	#raw_input("Press Enter to continue")

if __name__ == '__main__':
	main()

