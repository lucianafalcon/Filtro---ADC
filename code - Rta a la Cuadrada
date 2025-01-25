%% Limpio todo
clear all; %limpia variables
close all; % cierra toda ventana/grafico abierta
clc; % limpia la consola

%%%%%%%%%%%%%%%%%%%%%%%%
%Respuesta a la cuadrada  
%%%%%%%%%%%%%%%%%%%%%%%%

%transferencia original
s = tf('s');
H = (50760000*(s^2 + 500^2))/((s + 6000)^2 * (s^2 + s*(5000/27) + 500^2))

%transferencia normalizada
H2 = (75591081*(s^2 + 500^2))/((s^2 + s*11678 + 53279343) * (s^2 + s*186 + 500^2))
w0 = 500;
f0 = w0/(2*pi);
%%% Respuesta a la cuadrada
% Defino una cuadrada de periodo 1/f0 y dura 10 periodos
[cuad,t] = gensig("SQUARE" , 1/f0 , 10/f0); 



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Bode de la transferencia LTSPICE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Cargar los datos desde el archivo
data = readtable('Vout_cuad_f.txt', 'Delimiter', '\t', 'ReadVariableNames', false);
data1 = readtable('Vout_cuad_f_10.txt', 'Delimiter', '\t', 'ReadVariableNames', false);
data2 = readtable('Vout_cuad_10f.txt', 'Delimiter', '\t', 'ReadVariableNames', false);

% Separar las columnas
tiempo = data.Var1; % tiempo en seg
magnitude_V = data.Var2; % Columna 2: magnitud de la tensión en voltios

tiempo1 = data1.Var1; %
magnitude_V1 = data1.Var2; 

tiempo2 = data2.Var1; 
magnitude_V2 = data2.Var2; 


%%%%%%%%%
%GRAFICOS
%%%%%%%%%

%Ahora busco la respuesta al filtro:
%[cuad,t] = gensig("SQUARE" , f0 , 50/f0); 
[y_cuad,t_cuad] = lsim(H,cuad,t);

figure(1)
plot(t_cuad,y_cuad, 'linewidth',1.5,'color','b')
xlabel("Tiempo [s]")
ylabel("Tensión [V]")
title("Respuesta a la cuadrada f0=79.5Hz")
grid on
grid minor

hold on
[y_cuad,t_cuad] = lsim(H2,cuad,t); 
plot(t_cuad,y_cuad, 'linewidth',1.5,'color',  'm')

hold on
semilogx(tiempo, magnitude_V, 'c', 'LineWidth', 1.5);

plot(t,cuad, 'color','k')
legend('Original','Normalizado','Simulación', 'Cuadrada','Location', 'best');  % Leyenda
hold off

%%
% Defino una cuadrada de periodo 10/f0 y dura 5 periodos
[cuad,t] = gensig("SQUARE" , 10/f0 , 50/f0); 

%Ahora busco la respuesta al filtro con esto:
figure(2)
[y_cuad,t_cuad] = lsim(H,cuad,t); 
plot(t_cuad,y_cuad, 'linewidth',1.5,'color','b')
xlabel("Tiempo [s]")
ylabel("Tensión [V]")
title("Respuesta a la cuadrada f0/10=7.95Hz")
legend('Original', 'Location', 'best');  % Leyenda
grid on
grid minor

hold on
[y_cuad,t_cuad] = lsim(H2,cuad,t); 
plot(t_cuad,y_cuad, 'linewidth',1,'color', 'm')

hold on
semilogx(tiempo1, magnitude_V1, 'c', 'LineWidth', 1.5);

plot(t,cuad, 'color','k')
legend('Original','Normalizado','Simulación', 'Cuadrada','Location', 'best');  % Leyenda

hold off


%%
% Defino una cuadrada de periodo 10f0 y dura 5 periodos
[cuad,t] = gensig("SQUARE" , 1/(10*f0) , 40/(10*f0)); 

%Ahora busco la respuesta al filtro con esto:
figure(3)
[y_cuad,t_cuad] = lsim(H,cuad,t); 
plot(t_cuad,y_cuad, 'linewidth',1,'color','b')
xlabel("Tiempo [s]")
ylabel("Tensión [V]")
title("Respuesta a la cuadrada 10f0=795Hz")
legend('Original', 'Location', 'best');  % Leyenda
grid on
grid minor

hold on
[y_cuad,t_cuad] = lsim(H2,cuad,t); 
plot(t_cuad,y_cuad, 'linewidth' ,1,'color','m')

hold on
semilogx(tiempo2, magnitude_V2, 'c', 'LineWidth', 1.5);

plot(t,cuad, 'color','k')
legend('Original','Normalizado','Simulación','Cuadrada', 'Location', 'best');  % Leyenda
hold off
