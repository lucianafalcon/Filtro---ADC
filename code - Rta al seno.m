%% Limpio todo
clear all; %limpia variables
close all; % cierra toda ventana/grafico abierta
clc; % limpia la consola

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Respuesta al seno transferencia original - analitico
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Definir la función como anónima
f = @(X) 0.000243*exp(-6000*X) + 0.725*X.*exp(-6000*X) ...
         - 0.000243*exp(-(2500./27)*X).*cos(491.35*X) ...
         + 0.00145*exp(-(2500./27)*X).*sin(491.35*X);

% Definir el rango de X
X = linspace(0.001, 0.1, 1000); % Intervalo de X [0.001, 0.01] con 1000 puntos

% Evaluar la función
Y = f(X);

% Graficar la función
figure(1);
plot(X, Y, 'LineWidth', 1.5, 'Color', 'r');
title('Respuesta al Seno en 491.35rad/s');
xlabel('Tiempo (s)');
ylabel('Tensión (V)');
grid on;
grid minor;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Respuesta al seno transferencia original - normalizado - ltspice
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%transferencia original
s = tf('s');
H = (50760000*(s^2 + 500^2))/((s + 6000)^2 * (s^2 + s*(5000/27) + 500^2))

% Transferencia normalizada
s = tf('s');
H2 = (75591081*(s^2 + 500^2))/((s^2 + s*11678 + 53279343) * (s^2 + s*186 + 500^2));


%%
w0 = 500;
f0 = w0/(2*pi);

%%% Respuesta a senoidales

% genero señales de H(s) original  
[sin_f0_10,t_f0_10] = gensig("SIN" , 10/f0 , 0.3); 
[sin_10f0,t_10f0] = gensig("SIN" , 1/(10*f0) , 0.1); 
[sin_f0,t_f0] = gensig("SIN" , 1/f0 , 0.1); 
% genero señales de H(s) normalizado
[sin2_f0_10,t2_f0_10] = gensig("SIN" , 10/f0 , 0.3); 
[sin2_10f0,t2_10f0] = gensig("SIN" , 1/(10*f0) , 0.1); 
[sin2_f0,t2_f0] = gensig("SIN" , 1/f0 , 0.1); 
% genero señales de H(s) simulado ltspice


%genero respuestas a las señales de H(s) original
[y_sin_f0_10,t_sin_f0_10] = lsim(H,sin_f0_10,t_f0_10); 
[y_sin_10f0,t_sin_10f0] = lsim(H,sin_10f0,t_10f0); 
[y_sin_f0,t_sin_f0] = lsim(H,sin_f0,t_f0); 
%genero respuestas a las señales de H(s) normalizado
[y2_sin_f0_10,t2_sin_f0_10] = lsim(H2,sin2_f0_10,t2_f0_10); 
[y2_sin_10f0,t2_sin_10f0] = lsim(H2,sin2_10f0,t2_10f0); 
[y2_sin_f0,t2_sin_f0] = lsim(H2,sin2_f0,t2_f0);  


%--------------------------------
%Bode de la transferencia LTSPICE

% Cargar los datos desde el archivo
data = readtable('Vout_seno.txt', 'Delimiter', '\t', 'ReadVariableNames', false);
data2 = readtable('Vout_seno_10f.txt', 'Delimiter', '\t', 'ReadVariableNames', false);
data1 = readtable('Vout_seno_0.5f.txt', 'Delimiter', '\t', 'ReadVariableNames', false);

% Separar las columnas
tiempo = data.Var1; % tiempo en seg
magnitude_V = data.Var2; % Columna 2: magnitud de la tensión en voltios

tiempo1 = data1.Var1; % tiempo en seg
magnitude_V1 = data1.Var2; % Columna 2: magnitud de la tensión en voltios

tiempo2 = data2.Var1; % tiempo en seg
magnitude_V2 = data2.Var2; % Columna 2: magnitud de la tensión en voltios


%%%%%%%%%%
% GRAFICOS 
%%%%%%%%%% 
% Graficos rta al seno


% plots
figure(2)
plot(t_sin_f0,y_sin_f0, 'b', 'linewidth',1.5)
xlabel("Tiempo [s]")
ylabel("Tension [V]")
title("Respuesta al seno f0=79.5Hz")
grid on
grid minor
hold on; 

plot(t2_sin_f0,y2_sin_f0, 'm', 'linewidth',1.5)
hold on; 

semilogx(tiempo, magnitude_V, 'c', 'LineWidth', 1.5);
legend('Original','Normalizado','Simulación', 'Location', 'best');  % Leyenda
hold off;

%-------
figure(3)
plot(t_sin_f0_10,y_sin_f0_10, 'b', 'linewidth',1.5)
xlabel("Tiempo [s]")
ylabel("Tension [V]")
title("Respuesta al seno f0/10=7.957Hz")
grid on
grid minor
hold on; 

plot(t2_sin_f0_10,y2_sin_f0_10, 'm', 'linewidth',1.5)
hold on; 

semilogx(tiempo1, magnitude_V1, 'c', 'LineWidth', 1.5);
legend('Original','Normalizado','Simulación', 'Location', 'best');  % Leyenda
hold off;

%-------
figure(4)
plot(t_sin_10f0,y_sin_10f0, 'b', 'linewidth',1.5)
xlabel("Tiempo [s]")
ylabel("Tension [V]")
title("Respuesta al seno 10*f0=795HZ")
grid on
grid minor

hold on; 

plot(t2_sin_10f0,y2_sin_10f0, 'm', 'linewidth',1.5)
hold on;

semilogx(tiempo2, magnitude_V2, 'c', 'LineWidth', 1.5);
legend('Original','Normalizado','Simulación', 'Location', 'best');  % Leyenda
hold off;


