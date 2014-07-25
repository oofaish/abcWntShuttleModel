
close all;
tRange = [ 0, 50 ];

if( 1 )
    
    k = [92.331732, 0.86466471, 79.9512906, 97.932525, 1, 3.4134082, 0.61409879, 0.61409879, 3.4134082, 0.98168436,  ...
         0.981684, 4.7267833, 0.17182818, 0.68292191, 1.0, 3.2654672, 0.61699064, 0.61699064, 37.913879, 0.86466471, ...
         0.86466471, 0.99326205, 0.99326205, 1.0, 5.9744464, 1.7182818, 1.7182818, 1.7182818, 1.7182818, 0.55950727, ...
         1.0117639 ];
    %               y        D        P      Pn       T
    conserved = [ 16.4734, 4.9951, 1.60063, 1.20891, 2.77566 ];
    y0 = rand( 14, 1 );
    
    %k( 1 ) = k( 1 ) / 50;
    %k( 3 ) = k( 3 ) / 50;
    %k( 19 ) = k( 19 ) / 50;
    %k(12 )= k( 12 ) * 10;
    
    %deal with Dsh amount
    %tmp1 = [ 0; rand( 4, 1 ); 1 ];
    tmp1 = [ 0; 0.20; 0.40; 0.60; 0.80; 1 ];
    tmp1 = sort( tmp1 );
    tmp1 = diff( tmp1 );
    y0(  5 ) = conserved( 2 ) * tmp1( 1 );
    y0( 12 ) = conserved( 2 ) * tmp1( 2 );
    y0( 13 ) = conserved( 2 ) * tmp1( 3 );
    y0(  6 ) = conserved( 2 ) * tmp1( 4 );
    %rest go to Di
    
    %randomly distribute the y/DC amount
    %tmp1 = [ 0; rand( 9, 1 ); 1 ];
    tmp1 = 0:(1/10):1;
    tmp1 = sort( tmp1 );
    tmp1 = diff( tmp1 );
    yIndices = [ 1, 3, 4, 8, 10, 11 ]; %6 and 12 already set.
    for i = 1:length( yIndices )
        y0( yIndices( i ) ) = tmp1( i ) * conserved( 1 );
    end
    
    %P
    y0( 7 ) = rand( 1, 1 ) * conserved( 3 );
    
    %Pn - already calculated in DC amount

    %randomly distribute the TCF amount
    y0( 14 ) = y0( 14 ) * conserved( 5 );
    
    y0( 2 ) = 5;
    y0( 9 ) = 0.5;
    
    %k( 12 ) = k( 12 ) / 2;
    %k( 16 ) = k( 16 ) / 2;
    %X is too small in cytoplasm
    %k(1) = 50;
    %k(25) = k(25)/2;
    %k(24) = k(24)*10;
    
    %for k5
    if( 0 )
        k( 24 ) = 1;
        k( 30 ) = 20;
        k( 12 ) = 20;
        k( 25 ) = 0;
        k( 13 ) = 0;
        k( 31 ) = 0;
    end
    
else
    k = rand( 31, 1 );
    y0 = rand( 14, 1 );
    %y0( 18 ) = 0.9;
end

params = struct();

params.conserved = conserved;

options = odeset( 'AbsTol', 1e-7 );

k4s = [ 20, 0:0.05:1, 1:0.5:5];%originally this goes a lot higher
%k4s = 0:1:20;%originally this goes a lot higher
%k3s = 0:20:310;
k28s = 0:0.1:2;
k5s  = 0:0.1:2;
k14s = 0:2:50;

kIndex = 4;
ks     = k4s;

yIndex = 14;

%y014s = [ 0:0.05:0.25, 0.30:0.25:conserved( 5 ), conserved( 5 ) ];
y014s = [ 0:0.4:conserved( 5 ), conserved( 5 ) ];
stuffc2 = zeros( length( y014s ), 1 );
i = 0;

%k( 28 ) = 100;

yFinals = zeros( length( ks ) * length( y014s ), 1 );
kPlots  = zeros( length( yFinals ),              1 );


figure( 'position', [ 100 100 1500 1000 ], 'name', 'Go Bull Frogs', 'NumberTitle','off');
pause( 0.1 );

for thisK = ks
    k( kIndex ) = thisK;
    
    if( thisK > 0.5 )
        one = 1;
    end
    
    tmp1 = ( k( 3 ) - k( 14 ) ) / ( k( 3 ) * k( 15 ) );
    tmp2 = ( k( 3 ) - k( 14 ) ) / ( k( 5 ) * k( 14 ) );
    done = false;
    if( -1 / k( 24 ) > tmp1 )
        disp( [ num2str( k( kIndex ) ), ' - First Condition Meet' ] );
        done = true;
    end
    if( 1 / k( 25 ) < tmp2 )
        disp( [ num2str( k( kIndex ) ), ' - Second Condition Meet' ] );
        done = true;
    end
    
    if( ~ done )
        disp( [ num2str( k( kIndex ) ), ' - Neither condition meet' ] );
    end
    
    
    for y014 = y014s
        %stuffc  = zeros( length( k4s ), 1 );
        y0( yIndex ) = y014;
        i = i + 1;        
        params.k = k;
        [ t, y ] = abcRunOdeSystem( y0, params, tRange, options );

        %subplot( 131 );
        %plot( t, y(:, 14 ) );

        %subplot( 132 );
        %stuffc( i ) = y(end,14 );
        %plot( k4s( 1:i ), stuffc( 1: i ) );
        %axis( [ min( k4s ), max( k4s ), min( 0, min( stuffc ) ), max( 2, max( stuffc ) ) ] );
        %subplot( 133 );
        %stuffc2( j, 1 ) = mean( stuffc( 1:i ) );
        %plot( y014s( 1:j ), stuffc2( 1: j ) );
        %axis( [ min( y019s ), max( y019s ), min( 0, min( stuffc ) ), max( 2, max( stuffc ) ) ] );
        
        yFinals( i ) = y( end, yIndex ); %round( y( end, 14 ) * 1000 ) / 1000;
        kPlots(  i ) = thisK;
        
        subplot( 321 );
        plot( kPlots( 1:i ), yFinals( 1:i ), '.', 'LineWidth', 2 );
        xlabel( 'K' );
        ylabel( 'final CXTn' );
        
        subplot( 322 );
        plot( t, y(:, yIndex), 'LineWidth', 2 );
        xlabel( 'T' );
        ylabel( 'CXTn' );
        
        subplot( 323 );
        plot( t, y(:, 8), 'LineWidth', 2 );
        xlabel( 'T' );
        ylabel( 'Yon' );

        subplot( 324 );
        plot( t, y(:, 2), 'LineWidth', 2 );
        xlabel( 'T' );
        ylabel( 'X' );
        
        subplot( 325 );
        plot( t, y(:, 9), 'LineWidth', 2 );
        xlabel( 'T' );
        ylabel( 'Xn' );

        subplot( 326 );
        plot( t, y(:, 11), 'LineWidth', 2 );
        xlabel( 'T' );
        ylabel( 'Ycn' );
        
        
        pause( 0.01 );

       
    end
end