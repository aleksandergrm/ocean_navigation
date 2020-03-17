function [w1,d,fiv,lav] = GC_data(fi_1,la_1,fi_2,la_2)
% Great Circle problem
% Author: aleksander.grm@fpp.uni-lj.si, 20/02/2020
%
%
% Inputs: P1, P2
% Outputs: w1, dist, Pv

    % Covert to radians
    fi1r = d2r(dms2deg(fi_1));
    psi1r = pi/2 - fi1r;
    la1r = d2r(dms2deg(la_1));
    la1d = dms2deg(la_1);
    
    fi2r = d2r(dms2deg(fi_2));
    psi2r = pi/2 - fi2r;
    la2r = d2r(dms2deg(la_2));
    la2d = dms2deg(la_2);
    
    dfr = fi2r - fi1r;
    dlr = d2r(get_delta_long(la1d, la2d));
    
    % Find distance
    cos_d = cos(psi1r) * cos(psi2r) + sin(psi1r) * sin(psi2r) * cos(abs(dlr)); 
    dr = acos(cos_d);
    d = r2d(dr)*60; % distance in Nm
    
    % Find departure course
    w = acos( (cos(psi2r) - cos(psi1r)*cos(dr))/(sin(psi1r)*sin(dr)));
    if(dlr < 0)
        w1 = 360 - r2d(w);
    else
        w1 = r2d(w);
    end        
    
    % Vertex latitiude   
    fivr = sign(cos(w)) * acos( abs(sin(w)) * cos(fi1r) );
    fiv = r2d(fivr);
    
    % Vertex longitude
    pivr = sign(dlr)*acos(tan(fi1r)/tan(fivr));
    lav = get_midpoint_long(la1d, r2d(pivr));
        
end