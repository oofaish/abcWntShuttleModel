function [ t, y, k ] = abcRunOdeSystem( y0, params, tRange, manipulateK )

if manipulateK
    k = params.k;
    if( k( 14 ) > 0.7 )
        k( 14 ) = k( 14 ) - 0.3;
    end
    k( 3 ) = k( 14 ) + 0.3;%just for a bit of fun

    tmp1 = ( k( 3 ) - k( 14 ) ) / ( k( 3 ) * k( 15 ) );
    tmp2 = ( k( 3 ) - k( 14 ) ) / ( k( 5 ) * k( 14 ) );


    k( 24 ) = - 1/ tmp1 + 0.1;%satisfy first condition
    k( 25 ) =  1 / tmp2 - 0.1;

    params.k = k;
else
    k = params.k;
end

    dydt = @( t, y )( abcOdeSystem( t, y, params ) );

    [ t, y ] = ode15s( dydt, tRange, y0 );

end