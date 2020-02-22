function dd = dms2deg(x)
% Converts angle in deg,min,sec to decimal deg 
% Author: aleksander.grm@fpp.uni-lj.si, 20/02/2020
%

    dd = x(1) + x(2)/60 + x(3)/3600;
end