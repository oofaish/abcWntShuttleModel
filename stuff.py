
	dxdt[0]   =  k4-k5*X-k25*X-k1*(x1tot-CXY-Yc-CYD-CYP-Yon-CXYn-Ycn-CYDn-CYPn)*X+k2*CXY+k24*Xn						    
	dxdt[1]   =  k1*(x1tot-CXY-Yc-CYD-CYP-Yon-CXYn-Ycn-CYDn-CYPn)*X-k2*CXY-k3*CXY									    
	dxdt[2]   =  -k22*Yc+k8*CYD-k9*Yc*(x7tot-CYP)+k10*CYP+k23*Ycn										    
	dxdt[3]   =  k6*(x1tot-CXY-Yc-CYD-CYP-Yon-CXYn-Ycn-CYDn-CYPn)*(x5tot-CYD-Dan-CYDn-Di)-k7*CYD-k8*CYD	
	dxdt[4]   =  k9*Yc*(x7tot-CYP)-k10*CYP-k11*CYP												    
	dxdt[5]   =  -k12*Yon*Xn+k13*CXYn+k14*CXYn-k16*Yon*Dan+k17*CYDn+k21*CYPn						
	dxdt[6]   =  k25*X-k15*Xn-k24*Xn-k12*Yon*Xn+k13*CXYn-k30*Xn*(x18tot-CXTn)+k31*CXTn			
	dxdt[7]   =  k12*Yon*Xn-k13*CXYn-k14*CXYn												    
	dxdt[8]   =  k22*Yc-k23*Ycn+k18*CYDn-k19*Ycn*(x15tot-CYPn)+k20*CYPn									    
	dxdt[9]   =  k26*(x5tot-CYD-Dan-CYDn-Di)-k27*Dan-k16*Yon*Dan+k17*CYDn+k18*CYDn					
	dxdt[10]  =  k16*Yon*Dan-k17*CYDn-k18*CYDn												    
	dxdt[11]  =  k19*Ycn*(x15tot-CYPn)-k20*CYPn-k21*CYPn											    
	dxdt[12]  =  k29*(x5tot-CYD-Dan-CYDn-Di)-k28*Di											    
	dxdt[13]  =  k30*Xn*(x18tot-CXTn)-k31*CXTn
