%% Limpio todo
clear all; %limpia variables
close all; % cierra toda ventana/grafico abierta
clc; % limpia la consola

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Respuesta al escalon - analitico
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Definir la función como anónima
f = @(x) 1.377 + 0.107*exp(-(x*(2500/27))).*cos(x*491.35) ...
         + 0.489*exp(-(x*(2500/27))).*sin(x*491.35) ...
         - 1.53*exp(-(x*6000)) - 8568*x.*exp(-(x*6000));

% Definir el rango de x
x = linspace(0.001, 0.2, 1000); % Intervalo [0.001, 0.01] con 1000 puntos

% Evaluar la función
y = f(x);

% Graficar la función
figure(1);
plot(x, y, 'LineWidth', 1.5, 'Color', 'r'); % Línea roja con grosor 2
title('Respuesta al escalón analítica');
xlabel('Tiempo (s)');
ylabel('Tensión (V)');
grid on;
grid minor;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Respuesta al escalon original - normalizada - ltspice
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Respuesta al escalon transferencia original 
syms s;

disp("La funcion de transferencia del sistema es:")
H = (50760000*(s^2 + 500^2))/((s + 6000)^2 * (s^2 + s*(5000/27) + 500^2))

disp("La Respuesta al escalon del sistema orioginal es:")
rta_escalon = ilaplace(H/s)


%Respuesta al escalon transferencia normalizada
syms s;

disp("La funcion de transferencia del sistema es:")
H2 = (75591081*(s^2 + 500^2))/((s^2 + s*11678 + 53279343) * (s^2 + s*186 + 500^2))

disp("La Respuesta al escalon del sistema orioginal es:")
rta_escalon = ilaplace(H2/s)

%--------------------------------------------
%rta a la cuadrada de la transferencia LTSPICE

% Cargar los datos desde el archivo
data = readtable('Vout_escalon.txt', 'Delimiter', '\t', 'ReadVariableNames', false);

% Separar las columnas
tiempo = data.Var1; % tiempo en seg
magnitude_V = data.Var2; % Columna 2: magnitud de la tensión en voltios


s = tf('s');
H = (50760000*(s^2 + 500^2))/((s + 6000)^2 * (s^2 + s*(5000/27) + 500^2))


%%%%%%%%%
%GRAFICOS 
%%%%%%%%%
% Respuesta al escalon
figure(1)
[y_step,t_step] = step(H);

s = tf('s');
H2 = (75591081*(s^2 + 500^2))/((s^2 + s*11678 + 53279343) * (s^2 + s*186 + 500^2))
% Respuesta al escalon
[y_step2,t_step2] = step(H2);

figure(2)
plot(t_step, y_step,'linewidth',1.5,'color','b');
title("Respuesta al escalón del sistema");
xlabel("Tiempo (s)");
ylabel("Tensión (V)");
grid on
grid minor

hold on 

plot(t_step2, y_step2,'linewidth',1.5,'color','m');
legend('Original', 'Normalizado', 'Location', 'best');  % Leyenda

hold on;

semilogx(tiempo, magnitude_V, 'c', 'LineWidth', 1.5);
legend('Original','Normalizado','Simulación', 'Location', 'best');  % Leyenda
hold off;
