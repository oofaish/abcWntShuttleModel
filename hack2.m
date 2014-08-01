close all;
tRange = [ 0, 100 ];

id = 1;

[ y0, k, conserved ] = abcInitiate( id ); %1 means my method, 2 means adams
    
params = struct();

params.conserved = conserved;

options = odeset( 'AbsTol', 1e-4 );


params.k = k;
params.id = id;
[ t, y ] = abcRunOdeSystem( y0, params, tRange, options );

y( end, : ) 
