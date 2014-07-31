function [ dy ] = abcOdeSystem( t, y, params )
%ODESYSTEM Summay of this function goes here
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
    
    X       = y(  1 );

    CXY     = y(  2 );
    Yc      = y(  3 );
    %Da
    CYD     = y(  4 );
    %P
    CYP     = y(  5 );

    Yon     = y(  6 );
    Xn      = y(  7 );

    CXYn    = y(  8 );
    Ycn     = y(  9 );
    Dan     = y(  10 );
    CYDn    = y( 11 );
    %Pn
    CYPn    = y( 12 );

    Di      = y( 13 );
    %T
    CXTn    = y( 14 );

	totalY  = conserved( 1 );
    totalD  = conserved( 2 );
    totalP  = conserved( 3 );
    totalPn = conserved( 4 );
    totalT  = conserved( 5 );

    Yo      = totalY  - ( CXY + Yc + CYD + Yon + CXYn + Ycn + CYDn + CYPn + CYP );
    Da      = totalD  - ( CYD + Dan + CYDn + Di );
    P       = totalP  - ( CYP );
    Pn      = totalPn - ( CYPn );
    Tn      = totalT  - ( CXTn );
    
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
   
    %dy(  1 ) = k( 1 ) * Yo * X + ( k( 2 ) + k( 3 ) ) * CXY - k( 6 ) * Yo * Da + k( 7 ) * CYD + k( 11 ) * CYP;
    dy(  1 ) = k( 4 ) - k( 5 ) * X + k( 24 ) * Xn - k( 25 ) * X - k( 1 ) * Yo * X + k( 2 ) * CXY;
    dy(  2 ) = k( 1 ) * Yo * X - ( k( 2 ) + k( 3 ) ) * CXY;
    dy(  3 ) = -k( 22 ) * Yc + k( 23 ) * Ycn + k( 8 ) * CYD - k( 9 ) * Yc * P + k( 10 ) * CYP;
    %dy(  4 ) = -k( 26 ) * Da + k( 27 ) * Dan + k( 28 ) * Di - k( 29 ) * Da - k( 6 ) * Yo * Da + ( k( 7 )  + k( 8 ) ) * CYD;
    dy(  4 ) = k( 6 ) * Yo * Da - ( k( 7 ) + k( 8 ) ) * CYD;
    %dy(  6 ) = - k( 9 ) *  Yc * P + ( k( 10 )+ k( 11 ) ) * CYP;
    dy(  5 ) = k( 9 ) * Yc * P - ( k( 10 ) + k( 11 ) ) * CYP;
    dy(  6 ) = - k( 12 ) * Yon * Xn + ( k( 13 ) + k( 14 ) ) * CXYn - k( 16 ) * Yon * Dan + k( 17 ) * CYDn + k( 21 ) *  CYPn;
    dy(  7 ) = - ( k( 24 ) + k( 15 ) ) *  Xn + k( 25 ) * X - k( 12 ) * Yon * Xn + k( 13 ) * CXYn - k( 30 ) * Xn * Tn + k( 31 ) * CXTn;
    dy( 8 ) = k( 12 ) * Yon * Xn - ( k( 13 ) + k( 14 ) ) * CXYn;
    dy( 9 ) = k( 22 ) * Yc - k( 23 ) * Ycn + k( 18 ) * CYDn - k( 19 ) * Ycn * Pn + k( 20 ) * CYPn;
    dy( 10 ) = k( 26 ) * Da - k( 27 ) * Dan - k( 16 ) * Yon * Dan + ( k( 17 ) + k( 18 ) ) * CYDn;
    dy( 11 ) = k( 16 ) * Yon * Dan - ( k( 17 ) + k( 18 ) ) * CYDn;
    %dy( 15 ) = -k( 19 ) * Ycn * Pn + ( k( 20 ) + k( 21 ) ) * CYPn;
    dy( 12 ) = k( 19 ) * Ycn * Pn - ( k( 20 ) + k( 21 ) ) * CYPn;
    dy( 13 ) = -k( 28 ) * Di + k( 29 ) * Da;
    %dy( 18 ) = -k( 30 ) * Xn * Tn + k( 31 ) * CXTn;
    dy( 14 ) = k( 30 ) * Xn * Tn - k( 31 ) * CXTn;
    
    
end

