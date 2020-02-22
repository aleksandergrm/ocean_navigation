function c = course(w,df,dl)
% Converts calculated  angle to navigational course.
% Author: aleksander.grm@fpp.uni-lj.si, 20/02/2020
%
    
    if abs(df) < 1e-8 % df = 0
        if dl > 0
            c = pi/2;
        else
            c = 3*pi/2;
        end
    elseif abs(dl) < 1e-8 % dl = 0
        if df > 0
            c = 0;
        else
            c = pi;
        end
    elseif (df > 0) & (dl > 0) % I quadrant
        c = w;    
    elseif (df < 0) & (dl > 0) % II quadrant
        c = pi - w;
    elseif (df < 0) & (dl < 0) % III quadrant
        c = pi + w;
    else % IV quadrant
        c = 2*pi - w;
    end
end