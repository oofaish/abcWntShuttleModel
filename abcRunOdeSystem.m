function [ t, y ] = abcRunOdeSystem( y0, params, tRange, options )

    dydt = @( t, y )( abcOdeSystem( t, y, params ) );
    [ t, y ] = ode15s( dydt, tRange, y0, options );

end