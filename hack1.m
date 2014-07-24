tRange = [ 0, 10 ];
y0 = [ 3.5, 2 ];
x0s = 0:0.5:5;
xFinals = zeros( size( x0s ) );
i = 0;
for x = x0s
    i = i + 1;
    y0( 1 ) = x;
    [ t, y ] = ode15s( @abcOdeSystem1, tRange, y0 );
    xFinals( i ) = y( end, 1 );
end
%plot( t, y(:, 1) );
plot( x0s, xFinals, 'rx' );
