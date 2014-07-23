
close all;
tRange = [ 0, 80 ];
manipulateK = false;


y0 = rand( 19, 1 );
y0( 18 ) = 0.9;
    
if( 1 )
    k = rand( 31, 1 );
    k = [92.331732, 0.86466471, 79.9512906, 97.932525, 1, 3.4134082, 0.61409879, 0.61409879, 3.4134082, 0.98168436,  ...
         0.981684, 4.7267833, 0.17182818, 0.68292191, 1.0, 3.2654672, 0.61699064, 0.61699064, 37.913879, 0.86466471, ...
         0.86466471, 0.99326205, 0.99326205, 1.0, 5.9744464, 1.7182818, 1.7182818, 1.7182818, 1.7182818, 0.55950727, ...
         1.0117639 ];
    conserved = [ 16.4734, 4.9951, 1.60063, 1.20891, 2.77566 ];
    y0 = rand( 19, 1 );
    y0( 18 ) = 0.9;
end

params = struct();

k4s = 80:1:110;
y019s = 0:0.4:10;
stuffc2 = zeros( length( y019s ), 1 );
j = 1;

k( 28 ) = 100;

for y019 = y019s
    i = 1;
    stuffc  = zeros( length( k4s ), 1 );
    y0( 19 ) = y019;
    for k4 = k4s
        k( 4 ) =k4;
        params.k = k;
        [ t, y, k ] = abcRunOdeSystem( y0, params, tRange, manipulateK );

        subplot( 131 );
        plot( t, y(:, 19 ) );

        subplot( 132 );
        stuffc( i ) = y(end,19 );
        plot( k4s( 1:i ), stuffc( 1: i ) );
        %axis( [ min( k4s ), max( k4s ), min( 0, min( stuffc ) ), max( 2, max( stuffc ) ) ] );
        subplot( 133 );
        stuffc2( j, 1 ) = mean( stuffc( 1:i ) );
        plot( y019s( 1:j ), stuffc2( 1: j ) );
        %axis( [ min( y019s ), max( y019s ), min( 0, min( stuffc ) ), max( 2, max( stuffc ) ) ] );
        
        pause( 0.01 );

        i = i + 1;
    end
    
    
    
    j = j + 1;
    

    
end