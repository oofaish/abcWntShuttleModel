function [ t, y ] = abcRunOdeSystem( y0, params, tRange, options )

    if params.id == 1
        dydt = @( t, y )( abcOdeSystem( t, y, params ) );
    else
        dydt = @( t, y )( abcOdeSystem2( t, y, params ) );
    end
    [ t, y ] = ode15s( dydt, tRange, y0, options );

end