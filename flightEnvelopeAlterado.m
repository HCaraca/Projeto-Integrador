%variaveis da aeronave
clmax = 1.3;
clmin = -1;
ws = 84.15; %N/m^s
nmax = 3.8;
nmin = -0.4*nmax;
vcruise = 25;
clalfa = 0.09045455*180/pi;
cmed = 0.28;
Vb = 10; %V gust max gust

%variaveis do ambiente
rho = 1.225;
g = 9.81;

%Cálculos
v = 0:0.1:45;
vdive = 1.5*vcruise;
nclmax = 0.5*rho*clmax*v.^2/ws;
nclmin = 0.5*rho*clmin*v.^2/ws;
VlimAeroelastico = [vcruise vdive];
nlimAeroelastico = [nmin 0];
va = sqrt((2*nmax*ws)/(rho*clmax));
vstall = sqrt((2*ws)/(rho*clmax));
nNegvstall = 0.5*rho*clmin*vstall^2/ws;

%gusts of wind
miu = 2*ws/(rho*g*cmed*clalfa);
k = 0.88*miu/(5.3 +miu); %subsonico
Vb = k*Vb; %V gust max gust
deltanb = rho*Vb*va*clalfa/(2*ws);
vnb = [0 va];
nbposi = [1 1+deltanb];
nbneg = [1 1-deltanb];

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
nbposi = extrapolate([vnb(1) nbposi(1)],[vnb(2) nbposi(2)],v);
plot(v,nbposi);
nbneg = extrapolate([vnb(1) nbneg(1)],[vnb(2) nbneg(2)],v);
plot(v,nbneg);

%stall
plot([vstall vstall],[nNegvstall 1]);

legend('show','Location','SouthOutside');
xlim([0 vdive+10])
%ylim([nmin-0.5 nmax+1])
ylim([-8 10])

function [yvalues] = extrapolate(begPoint,endPoint,xvalues)
m = (endPoint(2)-begPoint(2))/(endPoint(1)-begPoint(1));
b = begPoint(2);
yvalues = xvalues*m+b;
end