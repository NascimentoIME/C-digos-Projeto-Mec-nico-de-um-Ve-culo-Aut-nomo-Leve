function [V_Gx, W_b, W_s, BETA_1_PONTO] = minhaFuncao(V_Lx, V_Lz, V_Ex, V_Ez, V_Gz,BETA_2)
% Função para calcular variáveis de saída da suspensão a partir de múltiplas entradas

     % Atribuir valores fixos para os parâmetros
    %BETA_1 = 0.055;    %fim de curso minimo 0.05465  % fim de curso maximo 0.0589 em metors
    %BETA_2 = 2.6;  %fim de curso minimo 2.729 radianos %fim de curso maximo 2.591 radianos
    %BETA_3 =  2.2; %fim de curso  2.264 radianos %fim de curso maximo 2.168 radianos
    GAMA =  0.380; %radianos
    R_1 = 0.091782; %a
    R_2 = 0.048414; %metors
    alfa = 1.122526%radianos
    r3 = 34.66%radianos
    r2 = 48.414%mm
    % 1. Cálculo de beta1 usando Lei dos Cossenos
    angulo = -alfa + GAMA + BETA_2;
    BETA_1 = sqrt(r2^2 + r3^2 + 2*r2*r3*cos(angulo)); % em mm
    % 2. Cálculo de beta3 usando Lei dos Senos
    seno_BETA_3_menos_alfa = (r2 / BETA_1) * sin(angulo);%sen(BETA_3 - alfa)
    BETA_3_menos_alfa = asin(seno_BETA_3_menos_alfa);

    BETA_3 = BETA_3_menos_alfa + alfa;%radianos

    % Defina a matriz de parâmetros da suspensão
    M = [
        0, 0, 1, -tan(BETA_2), tan(BETA_2);
        0, 0, 0, 1 / (R_1 * cos(BETA_2)), -1 / (R_1 * cos(BETA_2));
        sin(BETA_3) / BETA_1, cos(BETA_3) / BETA_1, -sin(BETA_3) / BETA_1, ...
        (R_2 * cos(BETA_2 + GAMA - BETA_3) / (R_1 * cos(BETA_2) * BETA_1)) - cos(BETA_3) / BETA_1, ...
        -R_2 * cos(BETA_2 + GAMA - BETA_3) / (R_1 * cos(BETA_2) * BETA_1);
        -cos(BETA_3), sin(BETA_3), cos(BETA_3), ...
        (R_2 * sin(-(BETA_2 + GAMA) + BETA_3) / (R_1 * cos(BETA_2))) - sin(BETA_3), ...
        R_2 * sin((BETA_2 + GAMA) - BETA_3) / (R_1 * cos(BETA_2))
    ];

    % Calcule as saídas
    resultado = M * [V_Lx; V_Lz; V_Ex; V_Ez; V_Gz];

    % Atribua os valores de saída
    V_Gx = resultado(1);
    W_b = resultado(2);
    W_s = resultado(3); 
    BETA_1_PONTO = resultado(4); 
end