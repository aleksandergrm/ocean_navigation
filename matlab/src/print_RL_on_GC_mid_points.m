function print_RL_on_GC_mid_points(np,lat,long)
% Prints RL data between two positions in navigation format
% Author: aleksander.grm@fpp.uni-lj.si, 20/02/2020
%
    fi_1 = deg2dms(lat(1));
    la_1 = deg2dms(long(1));
    
    if fi_1(1) > 0
        fi_s = 'N';
    else
        fi_s = 'S';
    end
    
    if la_1(1) > 0
        la_s = 'E';
    else
        la_s = 'W';
    end
    
    filename = 'voyage_plan.xlsx';
    %header = {' # ','fi[deg]','fi[min]','   ','la[deg]','la[min]','   ','course [deg]','distance [Nm]'};
    %writecell(header,filename,'Sheet',1,'Range','A1');
    line = {1, abs(fi_1(1)), fi_1(2)+fi_1(3)/60, fi_s, abs(la_1(1)), la_1(2)+la_1(3)/60, la_s, '', ''};
    writecell(line,filename,'Sheet',1,'Range','A2');
    
    fprintf('*** Route Data ***\n');
    fprintf('P(start): %s\n', print_position(deg2dms(lat(1)), deg2dms(long(1))));
    fprintf('P(end):   %s\n\n', print_position(deg2dms(lat(end)), deg2dms(long(end))));
    
    [w1_gc, d_gc, fiv_gc, lav_gc] = GC_data(deg2dms(lat(1)), deg2dms(long(1)), deg2dms(lat(end)), deg2dms(long(end)));
    fiv = deg2dms(fiv_gc);
    lav = deg2dms(lav_gc);
    fprintf('*** Great Circle Data ***\n');
    fprintf('GC: \x03C9=%.2f\xB0, d=%.2f Nm\n', w1_gc, d_gc);
    fprintf('P_v: %s\n\n', print_position(fiv, lav));
    
    [w1_rl, d_rl] = RL_P1_data(deg2dms(lat(1)), deg2dms(long(1)), deg2dms(lat(end)), deg2dms(long(end)));
    dist = 0;
    fprintf('*** Rhumb Line Data ***\n');
    fprintf('RL: \x03C9=%5.1f\xB0, d=%.2f Nm\n\n', w1_rl, d_rl);
    
    fprintf('*** Rhumb Line Mid Points Data ***\n');
    for k=1:np+1
        fi_1 = deg2dms(lat(k));
        la_1 = deg2dms(long(k));
        fi_2 = deg2dms(lat(k+1));
        la_2 = deg2dms(long(k+1));
        [w1_rl, d_rl] = RL_P1_data(fi_1, la_1, fi_2, la_2);
        fprintf('(P%d) -> (P%d): %s, %s\nRL: \x03C9=%5.1f\xB0, d=%.2f Nm\n\n', ...
            k, k+1,...
            print_position(deg2dms(lat(k)), deg2dms(long(k))),...
            print_position(deg2dms(lat(k+1)), deg2dms(long(k+1))),...
            w1_rl, d_rl);
        dist = dist + d_rl;
        
        if fi_2(1) > 0
            fi_s = 'N';
        else
            fi_s = 'S';
        end

        if la_2(1) > 0
            la_s = 'E';
        else
            la_s = 'W';
        end
        line = {k+1, abs(fi_2(1)), fi_2(2)+fi_2(3)/60, fi_s, abs(la_2(1)), la_2(2)+la_2(3)/60, la_s, w1_rl, d_rl};
        str = sprintf('A%d',k+2);
        writecell(line,filename,'Sheet',1,'Range',str)
            
    end
    fprintf('RL mid points distance d=%.2f Nm\n', dist);
    fprintf('**********************************\n\n', dist);
    
    fprintf('Distance difference (RL_mp - GC): %.2f Nm\n', dist - d_gc);
    
end