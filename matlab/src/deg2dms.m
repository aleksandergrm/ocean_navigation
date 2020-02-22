function dms = deg2dms(dd)
% converts angle in decimal deg to deg,min,sec
% Author: aleksander.grm@fpp.uni-lj.si, 20/02/2020
%
  
    d = floor(dd);
    m = (dd - d)*60;
    s = (dd - d - m/60)*3600;
    
    if abs(s - 60) < 1e-8
        m = m + 1;
        s = 0;
    end
    
    if abs(m - 60) < 1e-8
        d = d + 1;
        m = 0;
    end
    
    m = abs(m);
    s = abs(s);
    
    dms = [d,m,s];
end