%longitudinal
pcurto1 = [-9.1422 -7.4294];
pcurto2 = [-9.1422 7.4294];
fugoide1 = [-0.0141 -0.3389];
fugoide2 = [-0.0141 0.3389];

% Gráfico
scatter(pcurto1(1),pcurto1(2),'DisplayName','Período Curto');
hold on
scatter(pcurto2(1),pcurto2(2),'DisplayName','Período Curto (par)');
scatter(fugoide1(1),fugoide1(2),'DisplayName','Fugoide');
scatter(fugoide2(1),fugoide2(2),'DisplayName','Fugoide (par)');
legend('show','Location','SouthOutside');
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
hold off


%lateral
rolamento = [-30.0282 0];
rolamentoH1 = [-1.2021 -5.9651];
rolamentoH2 = [-1.2021 5.9651];
espiral = [0.0188 0];

% Gráfico
scatter(rolamento(1),rolamento(2),'DisplayName','rolamento');
hold on
scatter(rolamentoH1(1),rolamentoH1(2),'DisplayName','Rolamento Holandês');
scatter(rolamentoH2(1),rolamentoH2(2),'DisplayName','Rolamento Holandês (par)');
scatter(espiral(1),espiral(2),'DisplayName','Espiral');
legend('show','Location','SouthOutside');
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
hold off