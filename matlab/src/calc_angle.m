function w = calc_angle(c)
% Converts nautical course to calculation angle
% Author: aleksander.grm@fpp.uni-lj.si, 20/02/2020
%

    if c > 0 && c < pi/2
        w = c;
    elseif c > pi/2 && c < pi
        w = pi - c;
    elseif c > pi && c < 3*pi/2
        w = c - pi;
    else
        w = 2*pi - c;
    end
end