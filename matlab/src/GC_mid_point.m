function [fi, la] = GC_mid_point(fi_1,la_1,fi_2,la_2,la_i)
% Calculates the point or points Pi on GC
% Author: aleksander.grm@fpp.uni-lj.si, 20/02/2020
%
%
% Inputs: P1, P2, la_i
% Outputs: Pi
    
    [w1_gc, d_gc, fiv_gc, lav_gc] = GC_data(fi_1,la_1,fi_2,la_2);

    lair = d2r(dms2deg(la_i));
    dl = abs(lair - d2r(lav_gc));
    f = atan(cos(dl)/cot(d2r(fiv_gc)));

    fi = deg2dms(r2d(f));
    la = deg2dms(r2d(lair));
    
end