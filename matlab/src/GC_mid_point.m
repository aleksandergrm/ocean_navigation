function [fi, la] = GC_mid_point(fi_1,la_1,fi_2,la_2,la_i)
% Calculates the point or points Pi on GC
% Author: aleksander.grm@fpp.uni-lj.si, 20/02/2020
%
%
% Inputs: P1, P2, la_i
% Outputs: Pi
    
    [w1_gc, d_gc, fiv_gc, lav_gc] = GC_data(fi_1,la_1,fi_2,la_2);
    
    % set inital variables
    la_id = dms2deg(la_i);
    fi_1r = d2r(dms2deg(fi_1));
    la_1d = dms2deg(la_1);
    fi_vr = d2r(fiv_gc);
    dl_d = get_delta_long(dms2deg(la_1), dms2deg(la_2));
    
    % convert W1_GC to original value
    if (dl_d < 0)
        w = d2r(360 - w1_gc);
    else
        w = d2r(w1_gc);
    end
    
    % find midpoint latitude using P_v 
    % (it is problematic with S hemisphere)
    %dl_ir = d2r(get_delta_long(lav_gc, la_id));
    %fi_ir = atan(cos(dl_ir) * tan(fi_vr));
    
    % find midpoint latitude using P_1 (stable)
    dl_ir = abs(d2r(get_delta_long(la_1d, la_id)));
    if (fi_1r < 0)
        w = pi - w;
        fi_1r = abs(fi_1r);
        fi_ir = atan( sin(dl_ir) / (tan(w) * cos(fi_1r)) + tan(fi_1r) * cos(dl_ir) );
        fi_ir = - fi_ir;
    else
        fi_ir = atan( sin(dl_ir) / (tan(w) * cos(fi_1r)) + tan(fi_1r) * cos(dl_ir) );
    end
    
    fi = deg2dms(r2d(fi_ir));
    la = deg2dms(la_id);
    
end