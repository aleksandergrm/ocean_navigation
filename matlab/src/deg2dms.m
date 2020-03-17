function dms = deg2dms(dd)
% converts angle in decimal deg to deg,min,sec
% Author: aleksander.grm@fpp.uni-lj.si, 20/02/2020
%
    sgn = sign(dd);
    d = floor(abs(dd));
    m = floor((abs(dd) - d)*60);
    s = (abs(dd) - d - m/60)*3600;
    
    if abs(s - 60) < 1e-8
        m = m + 1;
        s = 0;
    end
    
    if abs(m - 60) < 1e-8
        d = d + 1;
        m = 0;
    end
    
    dms = [sgn*d,m,s];
end