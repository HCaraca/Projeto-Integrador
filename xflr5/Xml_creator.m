fid = fopen('aviao.xml','wt');     %alterar nome do ficheiro aqui
if fid<0
   fprintf('erro ao abrir o ficheiro\n');
   return;
end
format long;
fprintf(fid,'<?xml version="1.0" encoding="UTF-8"?>\n');
fprintf(fid,'<!DOCTYPE explane>\n');
fprintf(fid,'<explane version="1.0">\n');
fprintf(fid,'<Units>\n');
fprintf(fid,'<length_unit_to_meter>1</length_unit_to_meter>\n');
fprintf(fid,'<mass_unit_to_kg>1</mass_unit_to_kg>\n');
fprintf(fid,'</Units>\n');

%-------------------------------------PLANE-------------------------------------%
%---------------Definições do avião---------------%
perfil = 'SD7037';
plane_name = perfil;
plane_description = 'miau';
body = 'false';       %definir se há corpo ou não
%---------------Definições do avião---------------%

fprintf(fid,'<Plane>\n');
fprintf(fid,'<Name> %s </Name>\n',plane_name);
fprintf(fid,'<Description>\n');
fprintf(fid,'%s\n',plane_description);
fprintf(fid,'</Description>\n');
%------------Definir inércia------------%
fprintf(fid,'<Inertia>\n');
%------------Definir massas------------%
fprintf(fid,'<Point_Mass>\n');
fprintf(fid,'<Tag></Tag>\n');
fprintf(fid,'<Mass>  6.200 </Mass>\n');
fprintf(fid,'<coordinates>  0.085,   0, -0.2</coordinates>\n');
fprintf(fid,'</Point_Mass>\n');
%----------------Massas----------------%
fprintf(fid,'</Inertia>\n');
%----------------Inércia----------------%
fprintf(fid,'<has_body> %s </has_body>\n',body);         


%--------------------------------------ASA--------------------------------------%
%---------------Definições do asa---------------%
name_wing = 'Main Wing';    %Nomear a asa
wing_description = '';      
tilt_angle_asa = 0;             %ângulo em graus  
pos_asa = [0 0 0];          %definir posição
%---------------Definições do asa---------------%

fprintf(fid,'<wing>\n');
fprintf(fid,'<Name>%s</Name>\n',name_wing);
fprintf(fid,'<Type>MAINWING</Type>\n');
%-----random definições de cor-----------%
fprintf(fid,'<Color>\n');
fprintf(fid,'<red>208</red>\n');                
fprintf(fid,'<green>145</green>\n');                
fprintf(fid,'<blue>140</blue>\n');                
fprintf(fid,'<alpha>255</alpha>\n');                
fprintf(fid,'</Color>\n'); 
%-----alterar valores numéricos para alterar a cor---%
fprintf(fid,'<Description>%s</Description>\n',wing_description); 
fprintf(fid,'<Position> %0.3f, %0.3f, %0.3f</Position>\n',pos_asa(1),pos_asa(2),pos_asa(3)); 
fprintf(fid,' <Tilt_angle> %0.3f </Tilt_angle>\n',tilt_angle_asa);                      
fprintf(fid,'<Symetric>true</Symetric>\n');          %convém né
fprintf(fid,'<isFin>false</isFin>\n');               
fprintf(fid,'<isDoubleFin>false</isDoubleFin>\n'); 
fprintf(fid,'<isSymFin>false</isSymFin>\n'); 
%-----Definir inércia da asa-----%
fprintf(fid,'<Inertia>\n'); 
fprintf(fid,'<Volume_Mass>  1.500</Volume_Mass>\n'); 
fprintf(fid,'</Inertia>\n'); 
%--------------Inércia-----------%

%------------Início das sections------------%
%------------------------------------Definições das sections------------------------------------------%
n_sections_asa = 11;                                       %definir o número de secções pretendidas
wing_span = 2;                                             %em metros
%Y_asa = @(t)((t/n_sections_asa)*(wing_span/2));            %função que define a posição de cada secção
Y_asa = [0 0.308 0.399 0.639 0.709 0.774 0.835 0.892 0.945 0.976 0.993 1.022]*1.4/1.022;
corda_asa = @(y)(0.5*(0.3375*sqrt(1-(y/1)^2)+0.28)); %função que define a corda em função da distância à raíz
twist_asa = @(y)(-sin((pi*y)/wing_span));                  %função que define a twist em função da distância à raíz
diedro_1_asa = 0;
%diedro_2 = ; caso haja mais que um diedro ao longo da asa;
%diedro_change = ; Y a partir do qual o diedro muda de valor;
x_paineis_asa = 16;                                        %número de paineis em x
x_distribuicao_asa = 'UNIFORM';                             %escolher entre 'COSINE', 'UNIFORM', 'SINE' ou '-SINE'
y_paineis_asa = 4;                                         %número de paineis em x
y_distribuicao_asa = 'Uniform';                             %escolher entre 'COSINE', 'UNIFORM', 'SINE' ou '-SINE'
foil_asa = perfil;
%------------------------------------Definições das sections------------------------------------------%
fprintf(fid,'<Sections>\n'); 

for i = 1 : n_sections_asa
    fprintf(fid,'<Section>\n');
    fprintf(fid,'<y_position> %.3f </y_position>\n',Y_asa(i));
    fprintf(fid,'<Chord> %.3f </Chord>\n',corda_asa(Y_asa(i)));
    fprintf(fid,'<xOffset> %.3f </xOffset>\n',corda_asa(0)-corda_asa(Y_asa(i)));
%-----------Caso haja dois diedros diferentes-----------%    
    %if Y(i) < diedro_change
        fprintf(fid,'<Dihedral> %.3f </Dihedral>\n',diedro_1_asa);
    %else 
    %    fprintf(fid,'<Dihedral> %.3f </Dihedral>\n',diedro_2);
    %end
%-----------Diedros-----------%     
    fprintf(fid,'<Twist> %.3f </Twist>\n',twist_asa(Y_asa(i)));
    fprintf(fid,'<x_number_of_panels> %d </x_number_of_panels>\n',x_paineis_asa);
    fprintf(fid,'<x_panel_distribution> %s </x_panel_distribution>\n',x_distribuicao_asa);
    fprintf(fid,'<y_number_of_panels> %d </y_number_of_panels>\n',y_paineis_asa);
    fprintf(fid,'<y_panel_distribution> %s </y_panel_distribution>\n',y_distribuicao_asa);
    fprintf(fid,'<Left_Side_FoilName>%s</Left_Side_FoilName>\n',foil_asa);
    fprintf(fid,'<Right_Side_FoilName>%s</Right_Side_FoilName>\n',foil_asa);
    fprintf(fid,'</Section>\n');
end

fprintf(fid,'</Sections>\n');
%------------Fim das sections------------%
fprintf(fid,'</wing>\n');
%--------------------------------------Fim da ASA--------------------------------------%


%--------------------------------------ELEVATOR--------------------------------------%
%---------------Definições do elevator---------------%
name_elevator = 'ELeVaTOr';    %Nomear o elevator
elevator_description = '';      
tilt_angle_elev = -1.5;          %ângulo em graus  
pos_elev = [0.85 0 0.24];          %definir posição
%---------------Definições do elevator---------------%

fprintf(fid,'<wing>\n');
fprintf(fid,'<Name>%s</Name>\n',name_elevator);
fprintf(fid,'<Type>ELEVATOR</Type>\n');
%-----random definições de cor-----------%
fprintf(fid,'<Color>\n');
fprintf(fid,'<red>138</red>\n');                
fprintf(fid,'<green>216</green>\n');                
fprintf(fid,'<blue>140</blue>\n');                
fprintf(fid,'<alpha>255</alpha>\n');                
fprintf(fid,'</Color>\n'); 
%-----alterar valores numéricos para alterar a cor---%
fprintf(fid,'<Description>%s</Description>\n',elevator_description); 
fprintf(fid,'<Position> %0.3f, %0.3f, %0.3f</Position>\n',pos_elev(1),pos_elev(2),pos_elev(3)); 
fprintf(fid,' <Tilt_angle> %0.3f </Tilt_angle>\n',tilt_angle_elev);                      
fprintf(fid,'<Symetric>true</Symetric>\n');          %convém né
fprintf(fid,'<isFin>false</isFin>\n');               
fprintf(fid,'<isDoubleFin>false</isDoubleFin>\n'); 
fprintf(fid,'<isSymFin>false</isSymFin>\n'); 
%-----Definir inércia da asa-----%
fprintf(fid,'<Inertia>\n'); 
fprintf(fid,'<Volume_Mass>  0.000</Volume_Mass>\n'); 
fprintf(fid,'</Inertia>\n'); 
%--------------Inércia-----------%

%------------Início das sections------------%
%------------------------------------Definições das sections------------------------------------------%
n_sections_elev = 2;                                       %definir o número de secções pretendidas
elev_span = 0.4;                                           %em metros
Y_elev = [0 0.4];           %função que define a posição de cada secção
corda_elev = @(y)(0.2); %função que define a corda em função da distância à raíz
twist_elev = @(y)(0);                  %função que define a twist em função da distância à raíz
diedro_1_elev = -37;
%diedro_2 = ; caso haja mais que um diedro ao longo da asa;
%diedro_change = ; Y a partir do qual o diedro muda de valor;
x_paineis_elev = 10;                                        %número de paineis em x
x_distribuicao_elev = 'UNIFORM';                               %escolher entre 'COSINE', 'UNIFORM', 'SINE' ou '-SINE'
y_paineis_elev = 7;                                         %número de paineis em x
y_distribuicao_elev = 'UNIFORM';                            %escolher entre 'COSINE', 'UNIFORM', 'SINE' ou '-SINE'
foil_elev = 'NACA 0008';
%------------------------------------Definições das sections------------------------------------------%
fprintf(fid,'<Sections>\n'); 

for i = 1 : n_sections_elev 
    fprintf(fid,'<Section>\n');
    fprintf(fid,'<y_position> %.3f </y_position>\n',Y_elev(i));
    fprintf(fid,'<Chord> %.3f </Chord>\n',corda_elev(Y_elev(i)));
    fprintf(fid,'<xOffset> %.3f </xOffset>\n',corda_elev(0)-corda_elev(Y_elev(i)));
%-----------Caso haja dois diedros diferentes-----------%    
    %if Y(i) < diedro_change
        fprintf(fid,'<Dihedral> %.3f </Dihedral>\n',diedro_1_elev);
    %else 
    %    fprintf(fid,'<Dihedral> %.3f </Dihedral>\n',diedro_2);
    %end
%-----------Diedros-----------%     
    fprintf(fid,'<Twist> %.3f </Twist>\n',twist_elev(Y_elev(i)));
    fprintf(fid,'<x_number_of_panels> %d </x_number_of_panels>\n',x_paineis_elev);
    fprintf(fid,'<x_panel_distribution> %s </x_panel_distribution>\n',x_distribuicao_elev);
    fprintf(fid,'<y_number_of_panels> %d </y_number_of_panels>\n',y_paineis_elev);
    fprintf(fid,'<y_panel_distribution> %s </y_panel_distribution>\n',y_distribuicao_elev);
    fprintf(fid,'<Left_Side_FoilName>%s</Left_Side_FoilName>\n',foil_elev);
    fprintf(fid,'<Right_Side_FoilName>%s</Right_Side_FoilName>\n',foil_elev);
    fprintf(fid,'</Section>\n');
end

fprintf(fid,'</Sections>\n');
%------------Fim das sections------------%
fprintf(fid,'</wing>\n');
%--------------------------------------Fim de ELEVATOR--------------------------------------%


%--------------------------------------FIN--------------------------------------%
%---------------Definições do fin---------------%
name_fin = 'el fin';    %Nomear o fin
fin_description = '';      
tilt_angle_fin = 0;               %ângulo em graus  
pos_fin = [1.3 0 0];          %definir posição
%---------------Definições do fin---------------%

fprintf(fid,'<wing>\n');
fprintf(fid,'<Name>%s</Name>\n',name_fin);
fprintf(fid,'<Type>FIN</Type>\n');
%-----random definições de cor-----------%
fprintf(fid,'<Color>\n');
fprintf(fid,'<red>233</red>\n');                
fprintf(fid,'<green>201</green>\n');                
fprintf(fid,'<blue>110</blue>\n');                
fprintf(fid,'<alpha>255</alpha>\n');                
fprintf(fid,'</Color>\n'); 
%-----alterar valores numéricos para alterar a cor---%
fprintf(fid,'<Description>%s</Description>\n',fin_description); 
fprintf(fid,'<Position> %0.3f, %0.3f, %0.3f</Position>\n',pos_fin(1),pos_fin(2),pos_fin(3)); 
fprintf(fid,' <Tilt_angle> %0.3f </Tilt_angle>\n',tilt_angle_fin);                      
fprintf(fid,'<Symetric>true</Symetric>\n');          %convém né
fprintf(fid,'<isFin>true</isFin>\n');                
fprintf(fid,'<isDoubleFin>false</isDoubleFin>\n'); 
fprintf(fid,'<isSymFin>false</isSymFin>\n'); 
%-----Definir inércia da asa-----%
fprintf(fid,'<Inertia>\n'); 
fprintf(fid,'<Volume_Mass>  0.000</Volume_Mass>\n'); 
fprintf(fid,'</Inertia>\n'); 
%--------------Inércia-----------%

%------------Início das sections------------%
%------------------------------------Definições das sections------------------------------------------%
n_sections_fin = 69;                                       %definir o número de secções pretendidas
fin_span = 0.44;                                           %em metros
Y_fin = @(t)((t/n_sections_fin)*(fin_span/2));             %função que define a posição de cada secção
corda_fin = @(y)(0.5*(0.3375*sqrt(1-(y/1.127)^2)+0.2653)); %função que define a corda em função da distância à raíz
twist_fin = @(y)(-sin((pi*y)/fin_span));                   %função que define a twist em função da distância à raíz
diedro_1_fin = 0;
%diedro_2 = ; caso haja mais que um diedro ao longo da asa;
%diedro_change = ; Y a partir do qual o diedro muda de valor;
x_paineis_fin = 10;                                        %número de paineis em x
x_distribuicao_fin = 'UNIFORM';                            %escolher entre 'COSINE', 'UNIFORM', 'SINE' ou '-SINE'
y_paineis_fin = 7;                                         %número de paineis em x
y_distribuicao_fin = 'COSINE';                             %escolher entre 'COSINE', 'UNIFORM', 'SINE' ou '-SINE'
foil_fin = 'NACA 0018';
%------------------------------------Definições das sections------------------------------------------%
fprintf(fid,'<Sections>\n'); 

for i = 0 : n_sections_fin-1
    fprintf(fid,'<Section>\n');
    fprintf(fid,'<y_position> %.3f </y_position>\n',Y_fin(i));
    fprintf(fid,'<Chord> %.3f </Chord>\n',corda_fin(Y_fin(i)));
    fprintf(fid,'<xOffset> %.3f </xOffset>\n',corda_fin(Y_fin(0))-corda_fin(Y_fin(i)));
%-----------Caso haja dois diedros diferentes-----------%    
    %if Y(i) < diedro_change
        fprintf(fid,'<Dihedral> %.3f </Dihedral>\n',diedro_1_fin);
    %else 
    %    fprintf(fid,'<Dihedral> %.3f </Dihedral>\n',diedro_2);
    %end
%-----------Diedros-----------%     
    fprintf(fid,'<Twist> %.3f </Twist>\n',twist_fin(Y_fin(i)));
    fprintf(fid,'<x_number_of_panels> %d </x_number_of_panels>\n',x_paineis_fin);
    fprintf(fid,'<x_panel_distribution> %s </x_panel_distribution>\n',x_distribuicao_fin);
    fprintf(fid,'<y_number_of_panels> %d </y_number_of_panels>\n',y_paineis_fin);
    fprintf(fid,'<y_panel_distribution> %s </y_panel_distribution>\n',y_distribuicao_fin);
    fprintf(fid,'<Left_Side_FoilName> %s </Left_Side_FoilName>\n',foil_fin);
    fprintf(fid,'<Right_Side_FoilName> %s </Right_Side_FoilName>\n',foil_fin);
    fprintf(fid,'</Section>\n');
end

fprintf(fid,'</Sections>\n');
%------------Fim das sections------------%
fprintf(fid,'</wing>\n');
%--------------------------------------Fim de FIN--------------------------------------%

fprintf(fid,'</Plane>\n');
fprintf(fid,'</explane>\n');
%--------------------------------------Fim do PLANE--------------------------------------%
fclose(fid);