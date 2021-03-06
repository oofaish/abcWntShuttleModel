function [ y0, k, conserved ] = abcInitiate( id )

k = [92.331732, 0.86466471, 79.9512906, 97.932525, 1, 3.4134082, 0.61409879, 0.61409879, 3.4134082, 0.98168436, ...
     0.981684, 4.7267833, 0.17182818, 0.68292191, 1.0, 3.2654672, 0.61699064, 0.61699064, 37.913879, 0.86466471, ...
     0.86466471, 0.99326205, 0.99326205, 1.0, 5.9744464, 1.7182818, 1.7182818, 1.7182818, 1.7182818, 0.55950727, 1.0117639 ];

%               y        D        P      Pn       T
conserved = [ 16.4734, 4.9951, 1.60063, 1.20891, 130] %2.77566 ];
y0 = rand( 14, 1 );
    
%IC here are for [X,    Cxy, Yc,   Cyd,   Cyp,   Yon,   Xn,  Cxyn,    Ycn,  Dan, Cydn, Cypn, Di,    Cxtn]   
ic =            [0.1, 0.15, 1.0, 0.628, 1.018, 1.05, 0.05, 5.819, 1.0067, 0.58, 1.62, 1.15, 0.582, 1.0];
    %              1    2     3     4       5     6     7     8      9       10    11    12, 13,     14] 
    
if( id == 1 )
    y0( 1 ) = ic( 12 );%conserved( 1 ) - ic( 2 ) - ic( 3 ) - ic( 4 ) - ic( 5 ) - ic( 6 ) - ic( 8 ) - ic( 11 ) - ic( 12 ) - ic( 9 );
    y0( 2 ) = ic( 1 );
    y0( 3 ) = ic( 2 );
    y0( 4 ) = ic( 3 );
    y0( 5 ) = conserved( 2 ) - ic( 4 ) - ic( 10 ) - ic( 11 ) - ic( 13 );
    y0( 6 ) = ic( 4 ); 
    y0( 7 ) = conserved( 3 ) - ic( 5 );
    y0( 8 ) = ic( 6 );
    y0( 9 ) = ic( 7 );
    y0( 10 ) = ic( 8 );
    y0( 11 ) = ic( 9 );
    y0( 12 ) = ic( 10 );
    y0( 13 ) = ic( 11 );
    y0( 14 ) = ic( 14 );
else
    y0 = ic;
end

end