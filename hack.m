
close all;
tRange = [ 0, 800 ];

id = 2;

[ y0, k, conserved ] = abcInitiate( id );

params = struct();

params.conserved = conserved;
params.id = id;
options = odeset( 'AbsTol', 1e-3 );

%k4s = [ 0:0.025:1, 1:0.5:5];%originally this goes a lot higher
%k4s = 80:2:130;%originally this goes a lot higher
k4s = 95:0.1:100;
%k3s = 40:1:80;
k3s = 60:1:80;
k28s = 1.5:0.1:3;
k5s  = 0:0.1:2;
k14s = 0:2:50;

kIndex = 28;
ks     = k28s;

yIndex = 14;

%y014s = [ 0:0.05:0.25, 0.30:0.25:conserved( 5 ), conserved( 5 ) ];
y014s = [ 0:0.4:conserved( 5 ), conserved( 5 ) + 100 ];
stuffc2 = zeros( length( y014s ), 1 );
i = 0;

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