%% Limpio todo
clear all; %limpia variables
close all; % cierra toda ventana/grafico abierta
clc; % limpia la consola

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Bode de la transferencia analitica
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Definir las frecuencias angulares (rad/s)
omega = logspace(0, 5, 500);  % De 10 rad/s a 1M rad/s

% Transferencia original
s = tf('s');
H = (50760000*(s^2 + 500^2))/((s + 6000)^2 * (s^2 + s*(5000/27) + 500^2));

% Evaluar magnitud y fase usando bode
[mag, phase, freq] = bode(H, omega);  % Obtiene magnitud, fase y frecuencia

% Convertir magnitud a dB y fase a grados
magnitude = 20*log10(squeeze(mag));  % Magnitud en dB
phase = squeeze(phase);  % Fase en grados

%---
% Transferencia normalizada
s = tf('s');
H2 = (75591081*(s^2 + 500^2))/((s^2 + s*11678 + 53279343) * (s^2 + s*186 + 500^2));

% Evaluar magnitud y fase usando bode
[mag2, phase2, freq2] = bode(H2, omega);  % Obtiene magnitud, fase y frecuencia

% Convertir magnitud a dB y fase a grados
magnitude2 = 20*log10(squeeze(mag2));  % Magnitud en dB
phase2 = squeeze(phase2);  % Fase en grados
%---


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Bode de la transferencia LTSPICE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Cargar los datos desde el archivo
data = readtable('Vout.txt', 'Delimiter', '\t', 'ReadVariableNames', false);

% Separar las columnas
frequencies = data.Var1; % Frecuencia (Hz)
magnitude_dB = str2double(extractBetween(data.Var2, '(', 'dB')); % Magnitud (dB)
phase_deg = str2double(extractBetween(data.Var2, ',', '°')); % Fase (grados)

% Convertir las frecuencias de Hz a rad/s
frequencies_rad_s = 2 * pi * frequencies;


%%%%%%%%% 
%GRAFICOS 
%%%%%%%%%
% Graficar diagramas de Bode

%grafico magnitud
figure(1);
semilogx(freq, magnitude, 'b', 'LineWidth', 1.5);
grid on;
title('Diagrama de Bode - Magnitud');
xlabel('Frecuencia (rad/s)');
ylabel('Magnitud (dB)');

hold on;
semilogx(freq2, magnitude2, 'm', 'LineWidth', 1.5);

hold on; 
semilogx(frequencies_rad_s, magnitude_dB, 'c', 'LineWidth', 1.5);
legend('Original','Normalizado','Simulación', 'Location', 'best');  % Leyenda

hold off;

%grafico fase
figure(2)

semilogx(freq, phase, 'b', 'LineWidth', 1.5);
grid on;
title('Diagrama de Bode - Fase');
xlabel('Frecuencia (rad/s)');
ylabel('Fase (grados)');

hold on; 

semilogx(freq2, phase2, 'm', 'LineWidth', 1.5);

hold on; 

semilogx(frequencies_rad_s, phase_deg, 'c', 'LineWidth', 1.5);
legend('Original','Normalizado','Simulación', 'Location', 'best');  % Leyenda
