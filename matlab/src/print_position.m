function str = print_position(fi, la)
% Prints position in navigation format
% Author: aleksander.grm@fpp.uni-lj.si, 20/02/2020
%
    fi_s = 'N';
    if fi(1) < 0
        fi_s = 'S';
    end
    
    la_s = 'E';
    if la(1) < 0
        la_s = 'W';
    end
    
    fi = abs(fi);
    la = abs(la);
    
    str = sprintf('\x03C6 = %d\xB0 %04.1f\x27 %s, \x03BB = %03d\xB0 %04.1f\x27 %s', ...
        fi(1), fi(2)+fi(3)/60, fi_s, la(1), la(2)+la(3)/60, la_s);
end