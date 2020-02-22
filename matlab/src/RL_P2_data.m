function [fi2, la2] = RL_P2_data(fi_1, la_1, w1, d)
% Rhumb Line problem 2
% Author: aleksander.grm@fpp.uni-lj.si, 20/02/2020
%
%
% Inputs: P1, w1, dist
% Outputs: P2

    % convert to radians
    fi1r = d2r(dms2deg(fi_1));
    la1r = d2r(dms2deg(la_1));
    w1r = d2r(w1);
    dr = d2r(d/60); % assume d is in Nm!!
    
    % converts course to calculation angle
    w = calc_angle(w1r);
    dfr = abs(dr * cos(w));
    R = dr * sin(w);
    
    
    % Find delta fi and fi2r
    if (abs(w1r - pi/2) < 1e-8) | (abs(w1r - 3*pi/2) < 1e-8) % case dl = 0, on parallel
        fi2r = fi1r;
    elseif w1r < pi/2 || w1r > 3*pi/2
        fi2r = fi1r + dfr;
    else
        fi2r = fi1r - dfr;
    end
    
    %
    % Find delta la and la2 
    %
    if (abs(w1r - pi) < 1e-8) | (abs(w1r - 2*pi) < 1e-8) | (abs(w1r) < 1e-8) % case df = 0, on meridian
        dlr = 0;
    elseif (abs(w1r - pi/2) < 1e-8) | (abs(w1r - 3*pi/2) < 1e-8) % Check if w = 90, 270!
        dlr = abs(R/cos(fi1r));
    else
        cos_ft = dfr/log(tan(pi/4 + fi2r/2)/tan(pi/4 + fi1r/2));
        dlr = abs(R/cos_ft);
    end
    
    if (w1r < pi)
        la2r = la1r + dlr;
    else
        la2r = la1r - dlr;
    end
    
    fi2 = r2d(fi2r);
    la2 = r2d(la2r);
    
end