function dd = dms2deg(x)
% Converts angle in deg,min,sec to decimal deg 
% Author: aleksander.grm@fpp.uni-lj.si, 20/02/2020
%

    sgn = sign(x(1));
    dd = sgn * (abs(x(1)) + abs(x(2))/60 + abs(x(3))/3600 );
end