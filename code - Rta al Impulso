%% Limpio todo
clear all; %limpia variables
close all; % cierra toda ventana/grafico abierta
clc; % limpia la consola

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Respuesta al impulso transferencia original - analitico
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Definir la función como anónima
f = @(X) 230.37*exp(-(2500/27)*X).*cos(491.35*X) ...
         - 97.84*exp(-(2500/27)*X).*sin(491.35*X) ...
         - 9.71*exp(-6000*X) + 51408000*X.*exp(-6000*X);

% Definir el rango de X
X = linspace(0.001, 0.06, 1000); % Intervalo [0.001, 0.01] con 1000 puntos

% Evaluar la función
Y = f(X);

% Graficar la función
figure(1);
plot(X, Y, 'LineWidth', 1.5, 'Color', 'r'); % Línea verde con grosor 2
title('Respuesta al Impulso');
xlabel('Tiempo (s)');
ylabel('Tensión (V)');
grid on;
grid minor;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Respuesta al impulso transferencia original y normalizado
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
syms s;

disp("La funcion de transferencia del sistema es:")
H = (50760000*(s^2 + 500^2))/((s + 6000)^2 * (s^2 + s*(5000/27) + 500^2))

disp("La Respuesta al Impulso del sistema es:")
rta_impulso = ilaplace(H)


%---
% Crear simbólicamente la función de transferencia
syms s t
% Numerador y denominador simbólicos
numerador = 75591081 * (s^2 + 500^2);
denominador = (s^2 + s*11678 + 53279343) * (s^2 + s*186 + 500^2);
H2 = numerador / denominador;

% Transformada inversa de Laplace (respuesta al impulso)
rta_impulso = ilaplace(H2, s, t);

% Mostrar la ecuación de la respuesta al impulso
disp("La ecuación de la respuesta al impulso del sistema normalizado es:");
disp(rta_impulso);


%%%%%%%%%% 
%_GRAFICOS
%%%%%%%%%%

figure(2)
s = tf('s');
H = (50760000*(s^2 + 500^2))/((s + 6000)^2 * (s^2 + s*(5000/27) + 500^2))
[y, t] = impulse(H); % Obtener la respuesta al impulso
plot(t, y,'linewidth',1.5,'color','b');
title("Respuesta al Impulso");
xlabel("Tiempo (s)");
ylabel("Tensión (V)");
grid on
grid minor

hold on
s = tf('s');
H = (75591081*(s^2 + 500^2))/((s^2 + s*11678 + 53279343) * (s^2 + s*186 + 500^2))
[y, t] = impulse(H); % Obtener la respuesta al impulso
plot(t, y,'linewidth',1.5,'color','m');
legend('Original', 'Normalizado', 'Location', 'best');  % Leyenda

hold off;
