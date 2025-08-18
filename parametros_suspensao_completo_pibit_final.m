%% 


clc 
clear all
close all




%%%%% SUSPENÃO %%%%%

ks = 200; %%% N/m

bs = 10; %%% N.s/m

I = 5.6e-4; % momento de inércia da barra (garfo da suspensao) em kg·m^2



%%%% MASSA NÃO SUSPENSA %%%%%

massa_nao_suspensa = 200/1000; %%% gramas 


%%%% PNEU %%%%%%
kp = 1000; %% N/m 
bp = 5; %% N·s/m 

g = 9.81; 




% Lista decrescente de distâncias (em relação ao centro de massa)

a_Ax = 0.070;   % Ponto A: 7 cm à frente do CM (distância positiva)
a_Lx = 0.065;   % Ponto L: 6,5 cm atrás do CM
a_Ex = 0.030;   % Ponto E: 3 cm atrás do CM
a_Ez = 0.030;   % Ponto E: 3 cm abaixo do CM
a_Lz = 0.005;   % Ponto L: 0,5 cm acima do CM
comprimento_garfo_susp_traseira = 0.091782 %% comprimento da suspensão traseira


M = [1 0  a_Lx;
     0 1  a_Lz;
     1 0  a_Ex;
     0 1 -a_Ez;
     1 0 -a_Ax];

M_transposta = [1  0  1  0  1;
                0  1  0  1  0;
               a_Lx a_Lz a_Ex -a_Ez -a_Ax];



% Dados da carroceria
% massa da carroceria: 1.19745 kg
m_carroceria = 0.598725      % Massa em kg no modelo de MEIO CARRO  
L = 0.395;    % comprimento [m]
H = 0.101;    % altura [m]



% Cálculo do momento de inércia em pitch (eixo Y) para uma barra retangular

% Compatibilizar com o modelo Simulink
I_carroceria = (1/12) * m_carroceria * (L^2 + H^2);  % já está presente
inv_I_carroceria = 1 / I_carroceria;                % novo: ajuda na legibilidade

%%% entrei eixos
entre_eixos= 0.184356%m

%%%% velocidade do veículo
Vv = 5 %m/s 



%%%% obstáculos
Hmax = 10/100 %%% altura do quebra molas 8 cm tipo I ou 10 cm tipo II, sgundo Res. CONTRAM 39/1998
Lqm = 3,7 %%%% comprimento do quebra-molas 1,5 m tipo I ou 3,7 m tipo II, sgundo Res. CONTRAM 39/1998
Xcg = 10
%% fcn = Hmax * sin( (pi / Lqm) * (Vv * t - (Xcg - a_Ax)) ); ; %% quebra molas segundo norma
%% dy_dt = Hmax * cos( (pi / Lqm) * (Vv * t - (Xcg - a_Ax)) ) * (pi * Vv / Lqm);
t_reto_diant = (Xcg - a_Ax) / Vv;
z0_roda = 0.04 %%% altura em relação ao solo das rodas no início
z0_carroceria = 0.12 %%% altura em relação ao solo da carroceria no início





% Exibir resultados
fprintf('Massa da carroceria: %.2f kg\n', m_carroceria);
fprintf('Momento de inércia em pitch (Iy): %.5f kg·m^2\n', I_carroceria);







