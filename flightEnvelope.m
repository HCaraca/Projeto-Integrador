%variaveis da aeronave
clmax = 1.3;
clmin = -1;
ws = 84.15; %N/m^s
nmax = 3.8;
nmin = -0.4*nmax;
vcruise = 25;
clalfa = 0.09045455;
cmed = 0.28;
Vb = 66; %V gust max gust
Vc = 50; %V cruise 
Vd = 25; %V dive

%variaveis do ambiente
rho = 1.225;
g = 9.81;

%Cálculos
v = 0:0.1:25;
vdive = 1.5*vcruise;
nclmax = 0.5*rho*clmax*v.^2/ws;
nclmin = 0.5*rho*clmin*v.^2/ws;
VlimAeroelastico = [vcruise vdive];
nlimAeroelastico = [nmin 0];
va = sqrt((2*nmax*ws)/(rho*clmax));

%gusts of wind
miu = 2*ws/(rho*g*cmed*clalfa);
k = 0.88*miu/(5.3 +miu); %subsonico
Vb = k*Vb*0.3048; %V gust max gust
Vc = k*Vc*0.3048; %V cruise 
Vd = k*Vd*0.3048; %V dive
deltanb = rho*Vb*va*clalfa/(2*ws);
deltanc = rho*Vc*vcruise*clalfa/(2*ws);
deltand = rho*Vd*vdive*clalfa/(2*ws);
vnb = [0 va];
nbposi = [1 1+deltanb];
nbneg = [1 1-deltanb];
vnc = [0 vcruise];
ncposi = [1 1+deltanc];
ncneg = [1 1-deltanc];
vnd = [0 vdive];
ndposi = [1 1+deltand];
ndneg = [1 1-deltand];

% Gráficos
plot(v,nclmax,'DisplayName','Positive Stall Limit');
hold on
plot(v,nclmin,'DisplayName','Negative Stall Limit');
plot(VlimAeroelastico,nlimAeroelastico,'DisplayName','Limite Aeroelástico');

linenmax = yline(nmax,'-g','Structural Limit','DisplayName','Positive Structural Limit');
linenmax.LabelHorizontalAlignment = 'left';
linenmin = yline(nmin,'-c','Structural Limit','DisplayName','Negative Structural Limit');
linenmin.LabelHorizontalAlignment = 'left';

linedinamiclimit = xline(vdive,'-m','Dinamic Pressure Limit','DisplayName','Dinamic Pressure Limit');
linedinamiclimit.LabelVerticalAlignment = 'middle';

%gusts of wind
%nb
plot(vnb,nbposi);
plot(vnb,nbneg);

%nc
plot(vnc,ncposi);
plot(vnc,ncneg);

%nd
plot(vnd,ndposi);
plot(vnd,ndneg);

%legend('show','Location','SouthOutside');
xlim([0 vdive+5])
ylim([nmin-0.5 nmax+1])

