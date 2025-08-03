function [V_Gx, W_b, W_s, BETA_1_PONTO] = fcn( ...
    V_Lx, V_Lz, V_Ex, V_Ez, V_Gz, ...
    delta_BETA_1, delta_BETA_2, delta_BETA_3)

% Valores nominais (iniciais)
BETA_1_0 = 0.055;
BETA_2_0 = 2.6;
BETA_3_0 = 2.2;

% Limites físicos dos parâmetros
BETA_1_min = 0.05465;
BETA_1_max = 0.0589;
BETA_2_min = 2.591;
BETA_2_max = 2.729;
BETA_3_min = 2.168;
BETA_3_max = 2.264;

% Atualização dos parâmetros
BETA_1 = min(max(BETA_1_0 + delta_BETA_1, BETA_1_min), BETA_1_max);
BETA_2 = min(max(BETA_2_0 + delta_BETA_2, BETA_2_min), BETA_2_max);
BETA_3 = min(max(BETA_3_0 + delta_BETA_3, BETA_3_min), BETA_3_max);

% Constantes
GAMA = 0.380;
R_1 = 0.091782;
R_2 = 0.048414;

% Matriz M
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

entrada = [V_Lx; V_Lz; V_Ex; V_Ez; V_Gz];
resultado = M * entrada;

% Saídas
V_Gx         = resultado(1);
W_b          = resultado(2);
W_s          = resultado(3);
BETA_1_PONTO = resultado(4);
