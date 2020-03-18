% ********************************************* 
% *** Domaca naloga iz Planiranje Potovanja ***
%**********************************************

% *** Vpis polozajec Odhoda in prihoda ***
%
% V vektor fi in la vpisete polozaj v obliki [deg,min,sec]
% Lahko tudi vpisete [deg,min,0] kjer je min decimalno število minut
%
% Primer:
% fi = [10,15,30] ali enako fi = [10,15.5,0]

% Vpisite polozaj odhoda
fi_1 = -[33,02,0]; % [deg, min, sec]
la_1 = -[71,37,0]; % [deg, min, sec]

% Vpisite polozaj prihoda
fi_2 = -[41,30,0]; % [deg, min, sec]
la_2 = [174,30,0]; % [deg, min, sec]

% ***********************************************************
% Od tukaj naprej sam izracuna vse parametre plovbe
% in rezultate zapiše na ekran in v datoteko voyage_plan.xlsx

% *** add src path ***
% Doda pot, kjer se nahajajo funkcije
lp = pwd;
addpath(fullfile(lp,'src'));

% Doloci parametre Ortodrome
%
%  w1_gc  - kurz odhoda na ortodromi
%  d_gc   - razdalja na ortodromi
%  fi_vgc - fi vrha ortodrome
%  la_vgc - lambda vrha ortodrome
%

[w1_gc, d_gc, fi_vgc, la_vgc] = GC_data(fi_1,la_1,fi_2,la_2);
fiv = deg2dms(fi_vgc);
lav = deg2dms(la_vgc);
fprintf('GC: \x03C9=%.2f\xB0, d=%.2f Nm', w1_gc, d_gc)
fprintf('P_v: %s', print_position(fiv, lav))
    
% Dolocite stevilo vmesnih tock, ki se bodo izracunale na Ortodromi
%
% Ponavadi dolocimo število delilnih tock na ortodromi tako, da je delta lambda
% med dvema tockama okoli 10 stopinj
%

np = 10; % pravilno nastavi stevilo delilnih tock, da bo Delta Lambda okoli 10 stopinj
ll = get_midpoints(la_1,la_2,np); % izracuna lambdo za vse delilne tocke
lat = zeros(1,np+2);
long = zeros(1,np+2);

% vpiše v seznam tocko odhoda
lat(1) = dms2deg(fi_1);
long(1) = dms2deg(la_1);
for k = 1:np
	% za vsako delilno tocko doloci polozaj na ortodromi in jo zapise v seznam
    [fi_m, la_m] = GC_mid_point(fi_1,la_1,fi_2,la_2,ll(:,k)); 
    lat(k+1) = dms2deg(fi_m);
    long(k+1) = dms2deg(la_m);
end
% vpise v seznam tocko odhoda
lat(np+2) = dms2deg(fi_2);
long(np+2) = dms2deg(la_2);

% Izpisale se bodo vse vmesne tocke s parametri Loksodrome (kurz, razdalja)
% Enak izpis se bo vpisla v Excel datoteko "voyage_plan.xlsx"
%
print_RL_on_GC_mid_points(np,lat,long);

% Izris tock na Merkatorjevi karti:
%  - prihoda in odhoda
%  - vrha ortodrome (ce je med tockama odhoda-prihoda)
%  - vseh vmesnih tock na ortodromi 
% 
figure('color','w');
latWn = [(min(lat)-5), (max(lat)+5)];
dl = get_delta_long(long(1),long(end));
if dl < 0
    longWn = [long(end)-10, long(1)+10];
else
   longWn = [long(1)-10, long(end)+10]; 
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