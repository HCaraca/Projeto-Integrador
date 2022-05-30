clc
clear all

% NOTA: Todas as distancias/comprimentos estao expressos em [mm] e todas as
% massas em [g].

x_rel_placa = 1;

erro = 1;

while erro > 0.02
    
% Dados
corda_asa = 280;
corda_cauda = 200;
x_cauda_ba_cauda = 82;
x_asa_ba_asa = 162;
ba_asa_cauda = 1300;
zona_eletro = 250;
zona_cauda = 180;
zona_carga = 450;
rho_tubo_macho_cauda = 0.113; % [g/mm] 
rho_tubo_femea_cauda = 0.103; % [g/mm]
rho_tubo_asa = 3.59/178; % [g/mm]
longarina_ba = 89;
tubo_frente_long = 45.5;
tubo_tras_long = 114;
comp_tubo_asa = 192;

comp_aviao = zona_eletro + x_rel_placa + ba_asa_cauda + corda_cauda;
cb_ba_cauda = x_rel_placa + ba_asa_cauda - zona_carga - zona_cauda;

% Definicao parametros CAUDA

% Tubo Femea
aviao(1,1).componente = 'cauda';
aviao(1,1).nome = 'tubo_ext';
aviao(1,1).comp = zona_cauda;
aviao(1,1).x_nose = zona_eletro + zona_carga + aviao(1,1).comp/2;
aviao(1,1).mass = aviao(1,1).comp*rho_tubo_femea_cauda;
% Tubo Macho
aviao(1,2).componente = 'cauda';
aviao(1,2).nome = 'tubo_int';
aviao(1,2).comp = zona_cauda + cb_ba_cauda + corda_cauda - 50;
aviao(1,2).x_nose = comp_aviao - 50 - aviao(1,2).comp/2;
aviao(1,2).mass = aviao(1,2).comp*rho_tubo_macho_cauda;
% Estabilizadores
aviao(1,3).componente = 'cauda';
aviao(1,3).nome = 'cauda';
aviao(1,3).x_nose = zona_eletro + x_rel_placa + ba_asa_cauda + x_cauda_ba_cauda;
aviao(1,3).mass = 75.37*2;
% Roda
aviao(1,4).componente = 'cauda';
aviao(1,4).nome = 'roda';
aviao(1,4).x_nose =  zona_eletro + x_rel_placa + ba_asa_cauda + 130; %comp_aviao - 80 + 110*0.5;
aviao(1,4).mass = 17.75;
% Pecas 3D Cauda
aviao(1,5).componente = 'cauda';
aviao(1,5).nome = '3d_cauda';
aviao(1,5).x_nose = zona_eletro + x_rel_placa + ba_asa_cauda + 37;
aviao(1,5).mass = 3;


% Definicao parametros ASA

%Tubo da Frente Esquerda
aviao(2,1).componente = 'asa';
aviao(2,1).nome = 'tubo_frente_esq';
aviao(2,1).comp = comp_tubo_asa;
aviao(2,1).x_nose = zona_eletro + x_rel_placa + longarina_ba - tubo_frente_long;
aviao(2,1).mass = rho_tubo_asa*comp_tubo_asa;
% Tubo de Tras Esquerda
aviao(2,2).componente = 'asa';
aviao(2,2).nome = 'tubo_tras_esq';
aviao(2,2).comp = comp_tubo_asa;
aviao(2,2).x_nose = zona_eletro + x_rel_placa + longarina_ba + tubo_tras_long;
aviao(2,2).mass = rho_tubo_asa*comp_tubo_asa;
%Tubo da Frente Direita
aviao(2,3).componente = 'asa';
aviao(2,3).nome = 'tubo_frente_dir';
aviao(2,3).comp = comp_tubo_asa;
aviao(2,3).x_nose = zona_eletro + x_rel_placa + longarina_ba - tubo_frente_long;
aviao(2,3).mass = rho_tubo_asa*comp_tubo_asa;
% Tubo de Tras Direita
aviao(2,4).componente = 'asa';
aviao(2,4).nome = 'tubo_tras_dir';
aviao(2,4).comp = comp_tubo_asa;
aviao(2,4).x_nose = zona_eletro + x_rel_placa + longarina_ba + tubo_tras_long;
aviao(2,4).mass = rho_tubo_asa*comp_tubo_asa;
% Asa Esquerda
aviao(2,5).componente = 'asa';
aviao(2,5).nome = 'asa_esq';
aviao(2,5).x_nose = zona_eletro + x_rel_placa + x_asa_ba_asa;
aviao(2,5).mass = 352;
% Asa Direita
aviao(2,6).componente = 'asa';
aviao(2,6).nome = 'asa_dir';
aviao(2,6).x_nose = zona_eletro + x_rel_placa + x_asa_ba_asa;
aviao(2,6).mass = 352;
% Peca 3D Frente
aviao(2,7).componente = 'asa';
aviao(2,7).nome = '3d_frente';
aviao(2,7).x_nose = zona_eletro + x_rel_placa + longarina_ba - tubo_frente_long;
aviao(2,7).mass = 15;
% Peca 3D Tras
aviao(2,8).componente = 'asa';
aviao(2,8).nome = '3d_tras';
aviao(2,8).x_nose = zona_eletro + x_rel_placa + longarina_ba + tubo_tras_long;
aviao(2,8).mass = 15;
% Longarina
aviao(2,9).componente = 'asa';
aviao(2,9).nome = 'longarina';
aviao(2,9).x_nose = zona_eletro + x_rel_placa + longarina_ba;
aviao(2,9).mass = 39;


% Definicao parametros ELETRO

% Eletronica
aviao(3,1).componente = 'eletro';
aviao(3,1).nome = 'eletro';
aviao(3,1).x_nose = 94;
aviao(3,1).mass = 675.3;


% Definicao parametros FUSELAGEM

% Cargo-Bay
aviao(4,1).componente = 'fuselagem';
aviao(4,1).nome = 'cb';
aviao(4,1).x_nose = 447.7;
aviao(4,1).mass = 355 - 5.76*2*(1+3/5) - aviao(1,1).mass;
% GPS
aviao(4,2).componente = 'fuselagem';
aviao(4,2).nome = 'gps';
aviao(4,2).x_nose = zona_eletro + x_rel_placa + longarina_ba + 2.6 + 10 + 42;
aviao(4,2).mass = 150;
% Trem
aviao(4,3).componente = 'fuselagem';
aviao(4,3).nome = 'trem';
aviao(4,3).x_nose = zona_eletro + x_rel_placa + 70;
aviao(4,3).mass = 116;
% Rodas
aviao(4,4).componente = 'fuselagem';
aviao(4,4).nome = 'rodas';
aviao(4,4).x_nose = zona_eletro + x_rel_placa + 70;
aviao(4,4).mass = 34*2;
% Sacos 1
aviao(4,5).componente = 'fuselagem';
aviao(4,5).nome = 'sacos1';
aviao(4,5).x_nose = 255 + (1/2)*111.25;
aviao(4,5).mass = 600;
% Sacos 2
aviao(4,6).componente = 'fuselagem';
aviao(4,6).nome = 'sacos2';
aviao(4,6).x_nose = 255 + (3/2)*111.25;
aviao(4,6).mass = 600;
% Sacos 3
aviao(4,7).componente = 'fuselagem';
aviao(4,7).nome = 'sacos3';
aviao(4,7).x_nose = 255 + (5/2)*111.25;
aviao(4,7).mass = 600;
% Sacos 4
aviao(4,8).componente = 'fuselagem';
aviao(4,8).nome = 'sacos4';
aviao(4,8).x_nose = 255 + (7/2)*111.25;
aviao(4,8).mass = 600;


% Calculo CG's dos componentes

% <<<<< -------------------   CG do AVIAO   ------------------- >>>>>

[cg_dist, total_mass] = compute_cg2(aviao);
cg_teo = zona_eletro + x_rel_placa + 118;
erro = abs(cg_dist-cg_teo);
x_rel_placa = x_rel_placa + 0.01;
end
% -------------------------------------------------------------------


% Funcao para o calculo da posicao do CG e da massa total de um componente
function[x_cg,tot_mass] = compute_cg2(body)
sum = 0;
tot_mass = 0;

for i=1:size(body,1)
    for j=1:size(body,2)
         if ~(isempty(body(i,j).x_nose))
            sum = sum + (body(i,j).x_nose)*(body(i,j).mass);
            tot_mass = tot_mass + body(i,j).mass;
         
         end
    end
end

x_cg = sum/tot_mass;

end


