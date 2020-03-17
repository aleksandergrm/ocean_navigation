% Example of GC, RL south hemisphere

clear all
close all 
clc

% *** add src path ***
lp = pwd;
addpath(fullfile(lp,'src'));

fi_1 = -[33,02,0]; % [deg, min, sec]
la_1 = -[71,37,0]; % [deg, min, sec]
fi_2 = - [41,30,0]; % [deg, min, sec]
la_2 = [174,30,0]; % [deg, min, sec]

[w1_gc, d_gc, fi_vgc, la_vgc] = GC_data(fi_1,la_1,fi_2,la_2);

% Generate points with delta lambda 10 deg
np = 10;
ll = get_midpoints(la_1,la_2,np);
lat = zeros(1,np+2);
long = zeros(1,np+2);

lat(1) = dms2deg(fi_1);
long(1) = dms2deg(la_1);
for k = 1:np
    [fi_m, la_m] = GC_mid_point(fi_1,la_1,fi_2,la_2,ll(:,k));
    lat(k+1) = dms2deg(fi_m);
    long(k+1) = dms2deg(la_m);
end
lat(np+2) = dms2deg(fi_2);
long(np+2) = dms2deg(la_2);

print_RL_on_GC_mid_points(np,lat,long);

% plot Mercator chart
figure('color','w');
latWn = [(min(lat)-5), (max(lat)+5)];
dl = get_delta_long(long(1),long(end));
if dl < 0
    longWn = [long(end)-5, long(1)+5];
else
   longWn = [long(1)-5, long(end)+5]; 
end
axesm('mapproj','mercator',...
    'maplatlim',latWn ,'maplonlim', longWn,...
    'MLineLocation',15,'PLineLocation',10);
axis off, gridm on, framem on; mlabel on; plabel on;
% Load coastline data and plot it in the figure.
load coastlines;
hg = geoshow(coastlat,coastlon,'displaytype','line','color','b');
geoshow(lat,long,'displaytype','line','color','r',...
    'markeredgecolor','b','markerfacecolor','r','marker','.');
geoshow(dms2deg(fi_1),dms2deg(la_1),'DisplayType','point',...
    'markeredgecolor','k','markerfacecolor','g','marker','o')
geoshow(dms2deg(fi_2),dms2deg(la_2),'DisplayType','point',...
    'markeredgecolor','k','markerfacecolor','r','marker','o')
geoshow(fi_vgc,la_vgc,'DisplayType','point',...
    'markeredgecolor','k','markerfacecolor','y','marker','o')
tightmap

% plot on a globe
figure
ax = axesm('globe');
ax.Clipping = 'off';
gridm('GLineStyle','-','Gcolor',[.8 .7 .6],'Galtitude',.01)
plot3m(lat,long,.01,'k')
plot3m(lat,long,.01,'r.')
view(3)
axis off