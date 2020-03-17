function w = math_angle(c)
% Converts nautical course to math angle
% Author: aleksander.grm@fpp.uni-lj.si, 20/02/2020
%

    if c > 0 && c < pi/2
        w = pi/2 - c;
    elseif c > pi/2 && c < pi
        w = - c;
    elseif c > pi && c < 3*pi/2
        w = - c + pi/2;
    else
        w = 2*pi - c + pi/2;
    end
end