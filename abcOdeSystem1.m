function dy = abcOdeSystem1( t, y )

dy = zeros( 2, 1 );
dy( 1 ) = y( 1 ) * ( y( 1 ) - 2 ) * ( - y( 1 ) + 3 );
dy( 2 ) = - y( 2 ) + 1;

end