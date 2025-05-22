function [F_Lx, F_Lz, F_Ex, F_Ez, F_Gz] = minhaFuncaoForcas(F_Gx, M_b, M_s, F_s)
% Função para calcular as forças de saída usando a transposta da matriz M
 
% Atribuir valores fixos para os parâmetros
    BETA_1 = 0.055;    %fim de curso minimo 0.05465  % fim de curso maximo 0.0589 em metors
    BETA_2 = 2.6;  %fim de curso minimo 2.729 radianos %fim de curso maximo 2.591 radianos
    BETA_3 =  2.2; %fim de curso  2.264 radianos %fim de curso maximo 2.168 radianos
    GAMA =  0.380; %radianos
    R_1 = 0.091782; %metros
    R_2 = 0.048414; %metors
    
   
    % Defina a matriz de parâmetros da suspensão (mesma matriz M do código original)
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

    % Calcule a transposta da matriz M
    M_transposta = M';

    % Calcule os resultados multiplicando a matriz transposta pelos vetores de entrada
    resultado = M_transposta * [F_Gx; M_b; M_s; F_s];

    % Atribua os valores de saída
    F_Lx = resultado(1);
    F_Lz = resultado(2);
    F_Ex = resultado(3);
    F_Ez = resultado(4);
    F_Gz = resultado(5);
end