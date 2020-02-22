function [w1,d] = RL_P1_data(fi_1,la_1,fi_2,la_2)
% Rhumb Line problem 1
% Author: aleksander.grm@fpp.uni-lj.si, 20/02/2020
%
%
% Inputs: P1, P2
% Outputs: w1, dist

    % convert to radians
    fi1r = d2r(dms2deg(fi_1));
    la1r = d2r(dms2deg(la_1));
    fi2r = d2r(dms2deg(fi_2));
    la2r = d2r(dms2deg(la_2));
    
    dfr = fi2r - fi1r; % delta LAT with sign
    dlr = la2r - la1r; % delta lONG with sign
    
    %
    % Calculation of tilde LAT (it will be always a positive number)
    %
    if abs(dfr) < 1e-8 % Check if delta LAT = 0
        ft = 0;
    else
        c_ft = dfr/log(tan(pi/4 + fi2r/2)/tan(pi/4 + fi1r/2));
        ft = acos(c_ft); 
        if c_ft < 0 % condition for negative angles (180 - ft)
            ft = pi - ft;
        end
    end    
    %fprintf('ft = %.2f\n',ft*180/pi)
    
    % Depature course. Result is always in I quadrant [0,90]
    w = atan(cos(ft)*abs(dlr/dfr));
    % Convert to real course in deg!
    w1 = r2d(course(w,dfr,dlr));
    
    % Loxodrome distance
    if abs(dfr) < 1e-8
        d = abs(dlr)*cos(fi1r);
    elseif abs(dlr) < 1e-8
        d = abs(dfr);
    elseif (abs(w) < pi/20) | (abs(w - pi) < pi/20) % Condition to avoid small numbers
        d = abs(dfr)/cos(w); 
    else
        d = cos(ft)*abs(dlr)/sin(w);
    end 
    
    d = r2d(d)*60; % convert to Nm!
end