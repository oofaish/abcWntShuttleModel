    yTags = {
    'Yo',
    'X',
    'CXY',
    'Yc',
    'Da',
    'CYD',
    'P',
    'Yon',
    'Xn',
    'CXYn',
    'Ycn',
    'Dan',
    'CYDn',
    'CXTn',
    };

for i = 1:14
    disp( [yTags{ i },'=', num2str( y0( i ) ) ]);
end

%CYPn    = conserved( 1 ) - ( Yo + CXY + Yc + CYD + CYP + Yon + Ycn + CYDn );
%Di      = conserved( 2 ) - ( Da + CYD + Dan + CYDn );
%CYP     = conserved( 3 ) - P;
%Pn      = conserved( 4 ) - CYPn;
%Tn      = conserved( 5 ) - CXTn;