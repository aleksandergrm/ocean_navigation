function dl = get_delta_long(la_1d, la_2d)
% Calculates delta lambda in all conditions. Sign is OK!
% Author: aleksander.grm@fpp.uni-lj.si, 20/02/2020
%
%   - la_1d: lambda 1 in deg
%   - la_2d: lambda 2 in deg
%   - dl: delta lambda in deg

    if la_1d < 0
        la1 = 360 + la_1d;
    else
        la1 = la_1d;
    end
    
    if la_2d < 0
        la2 = 360 + la_2d;
    else
        la2 = la_2d;
    end
    
    dl = la2 - la1;
    
    if dl < -180
        dl = 360 + dl;
    elseif dl > 180
        dl = dl - 360;
    end
end