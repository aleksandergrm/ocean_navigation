function long_m = get_midpoints(la_1, la_2, np)
% Calculates the midpoints on orthodrome
% Author: aleksander.grm@fpp.uni-lj.si, 20/02/2020
%

    long_m = zeros(3,np);
    la_1d = dms2deg(la_1);
    la_2d = dms2deg(la_2);
    dl = get_delta_long(la_1d, la_2d);
        
    ddl = dl/(np+1);
        
    for i = 1:np
        dl_i = get_midpoint_long(la_1d, i*ddl);
        long_m(:,i) = deg2dms(dl_i);
    end
end