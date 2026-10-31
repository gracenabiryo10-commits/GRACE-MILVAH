% Problem 1: Volume Maximization of an Open-Top Box
clear; clc; close all;

% Define objective function to minimize (negative volume for maximization)
v_neg = @(x) -(4*x^3 - 160*x^2 + 1500*x);

% Optimization parameters
x0 = 5;          % Initial guess
lb = 0;          % Lower bound
ub = 15;         % Upper bound

% Solve using fmincon
options = optimoptions('fmincon', 'Display', 'off');
[x_opt, fval] = fmincon(v_neg, x0, [], [], [], [], lb, ub, [], options);
max_volume = -fval;

% Display results
fprintf('--- Problem 1 Results ---\n');
fprintf('Optimal cutout size (x): %.4f cm\n', x_opt);
fprintf('Maximum Volume: %.4f cm^3\n\n', max_volume);

% Plotting
x_vals = linspace(0, 15, 200);
y_vals = 4*x_vals.^3 - 160*x_vals.^2 + 1500*x_vals;

figure;
plot(x_vals, y_vals, 'LineWidth', 2); hold on;
plot(x_opt, max_volume, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
title('Box Volume vs. Cutout Size');
xlabel('Cutout Size x (cm)');
ylabel('Volume (cm^3)');
legend('Volume Curve', 'Optimal Peak');
grid on;
