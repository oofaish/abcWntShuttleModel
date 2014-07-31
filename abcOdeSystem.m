function [ dy ] = abcOdeSystem( t, y, params )
%ODESYSTEM Summary of this function goes here
%   Detailed explanation goes here
    
    
    %THINGS WITHOUT n in CYTOPLASM
    
    %DC  = destruction complex.
    %B   = beta-catenine
    %Dsh = Dishevelled
    %P   = Phosphate
    
    if( min( y ) < -1 )
        one = 1;
    end
    
                           
    conserved = params.conserved;
    
    Yo      = y(  1 ); %open DC- degrades B                                                         
    X       = y(  2 ); %Beta-catenine
    
    CXY     = y(  3 ); %DC + B
    Yc      = y(  4 ); %closed DC - does not degarade B
    Da      = y(  5 ); %Active Dsh - can CLOSE DC, so MORE B.
    CYD     = y(  6 ); %DC + Dsh
    P       = y(  7 ); 
    CYP     = conserved( 3 ) - P;%y(  8 ); %DC + Phosphate
    
    Yon     = y(  8 ); %open DC in nucleus - degrades B
    Xn      = y(  9 ); %B in nucleus
    
    CXYn    = y( 10 ); %DC + B in nucleus
    Ycn     = y( 11 ); %Closed DC in nucleus
    Dan     = y( 12 ); %Active Dsh in Nucleus, can close DC, so MORE B.
    CYDn    = y( 13 ); %DC + Dsh
    
    CYPn    = conserved( 1 ) - ( Yo + CXY + Yc + CYD + CYP + Yon + Ycn + CYDn + CXYn );
        %y( 16 ); %DC + Phosphate in nucleus
    Pn      = conserved( 4 ) - CYPn; %y( 15 ); 
    
    Di      = conserved( 2 ) - ( Da + CYD + Dan + CYDn );
        %y( 17 ); %Inactive Dsh, cannot work with DC, so DC degrades B, so less B
    
    CXTn    = y( 14 ); %B + TCF (Target Gene Transcription!) YEY!
    Tn      = conserved( 5 ) - CXTn;%y( 18 ); %TCF 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% k1 - rate of B being marked by DC for destruction (so forming a Complex XY)
    %% k2 - rate of XY Complex converting back to B and DC
    %% k3 - rate of B destruction from CXY so you get your DC back
    %% k4 - default rate of creation of B
    %% k5 - rate of B just degrading (not due to DC, but natuarally?)
    %%
    %%
    %% k14 - (in nucleus) rate of B destruction from CXY so you get DC back - SAME AS K3
    %% k15 - (in nucleus) rate of B degrading - SAME AS K5
    %%
    %%
    %% k24	- rate of B moving from nucleus to cytoplasm
    %% k25	- rate of B moving from cytoplasm to nucleus
    %% k26      - 
    %% k27	- destruction of Dsh (natural, not to anything else)
    %% k28+29 	-  Conversion of active and inactive Dsh
    %% %%%%%%%%%%%%%%%%%%% K28 is the interesting bad boy, higher implies wnt stimulation. 
    %% k30 	- Target Gene Transcription (due to formation of B + TCF complex)
    %% k31 	- 'conversion' of Target Gene Complex (B + TCF) back to TCF and B
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    k = params.k;
    
    
    dy = zeros( 14, 1 );
   
    dy(  1 ) = k( 1 ) * Yo * X + ( k( 2 ) + k( 3 ) ) * CXY - k( 6 ) * Yo * Da + k( 7 ) * CYD + k( 11 ) * CYP;
    dy(  2 ) = k( 4 ) - k( 5 ) * X + k( 24 ) * Xn - k( 25 ) * X - k( 1 ) * Yo * X + k( 2 ) * CXY;
    dy(  3 ) = k( 1 ) * Yo * X - ( k( 2 ) + k( 3 ) ) * CXY;
    dy(  4 ) = -k( 22 ) * Yc + k( 23 ) * Ycn + k( 8 ) * CYD - k( 9 ) * Yc * P + k( 10 ) * CYP;
    dy(  5 ) = -k( 26 ) * Da + k( 27 ) * Dan + k( 28 ) * Di - k( 29 ) * Da - k( 6 ) * Yo * Da + ( k( 7 )  + k( 8 ) ) * CYD;
    dy(  6 ) = k( 6 ) * Yo * Da - ( k( 7 ) + k( 8 ) ) * CYD;
    dy(  7 ) = - k( 9 ) *  Yc * P + ( k( 10 )+ k( 11 ) ) * CYP;
    %dy(  8 ) = k( 9 ) * Yc * P - ( k( 10 ) + k( 11 ) ) * CYP;
    dy(  8 ) = - k( 12 ) * Yon * Xn + ( k( 13 ) + k( 14 ) ) * CXYn - k( 16 ) * Yon * Dan + k( 17 ) * CYDn + k( 21 ) *  CYPn;
    dy(  9 ) = - ( k( 24 ) + k( 15 ) ) *  Xn + k( 25 ) * X - k( 12 ) * Yon * Xn + k( 13 ) * CXYn - k( 30 ) * Xn * Tn + k( 31 ) * CXTn;
    dy( 10 ) = k( 12 ) * Yon * Xn - ( k( 13 ) + k( 14 ) ) * CXYn;
    dy( 11 ) = k( 22 ) * Yc - k( 23 ) * Ycn + k( 18 ) * CYDn - k( 19 ) * Ycn * Pn + k( 20 ) * CYPn;
    dy( 12 ) = k( 26 ) * Da - k( 27 ) * Dan - k( 16 ) * Yon * Dan + ( k( 17 ) + k( 18 ) ) * CYDn;
    dy( 13 ) = k( 16 ) * Yon * Dan - ( k( 17 ) + k( 18 ) ) * CYDn;
    %dy( 15 ) = -k( 19 ) * Ycn * Pn + ( k( 20 ) + k( 21 ) ) * CYPn;
    %dy( 16 ) = k( 19 ) * Ycn * Pn - ( k( 20 ) + k( 21 ) ) * CYPn;
    %dy( 17 ) = -k( 28 ) * Di + k( 29 ) * Da;
    %dy( 18 ) = -k( 30 ) * Xn * Tn + k( 31 ) * CXTn;
    dy( 14 ) = k( 30 ) * Xn * Tn - k( 31 ) * CXTn;
    
    
end

