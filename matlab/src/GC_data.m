function [w1,d,fiv,lav] = GC_data(fi_1,la_1,fi_2,la_2)
% Great Circle problem
% Author: aleksander.grm@fpp.uni-lj.si, 20/02/2020
%
%
% Inputs: P1, P2
% Outputs: w1, dist, Pv

    % Covert to radians
    fi1r = d2r(dms2deg(fi_1));
    la1r = d2r(dms2deg(la_1));
    fi2r = d2r(dms2deg(fi_2));
    la2r = d2r(dms2deg(la_2));
    
    dfr = fi2r - fi1r;
    dlr = la2r - la1r;
    
    % Find distabce
    cos_d = sin(fi1r) * sin(fi2r) + cos(fi1r) * cos(fi2r) * cos(abs(dlr)); 
    dr = acos(cos_d);
    d = r2d(dr)*60; % distance in Nm
    
    % Find departure course
    w = asin(cos(fi2r)*sin(abs(dlr))/sin(dr));
    w1 = r2d(course(w,dfr,dlr));
    
    % Vertex
    psivr = asin(sin(w)*cos(fi1r));
    pivr = asin(cot(w)*tan(psivr));
    
    fivr = pi/2 - psivr;
    lavr = la1r + sign(dlr)*pivr;
        
    fiv = r2d(fivr);
    lav = r2d(lavr);
    
end