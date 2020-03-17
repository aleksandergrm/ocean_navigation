function long_m = get_midpoint_long(la_1d, dl_m)
% Calculates the midpoint longitude on orthodrome
% Author: aleksander.grm@fpp.uni-lj.si, 20/02/2020
%
    long_m = la_1d + dl_m; 
            
    if long_m < -180 % pasing from W -> E date line
        %fprintf('dl_i < -180: la=%f', 360 + dl_i)
        long_m = 360 + long_m;
    elseif long_m > 180 % passing from E -> W date line
        %fprintf('dl_i > 180: la=%f', dl_i - 360)
        long_m = long_m - 360;
    end
                
end