% Problem 2: Cost Minimization for Pasture Fencing
clear; clc; close all;

cost_fun = @(x) 20*x + (20000./x);

x0 = 20; lb = 1; ub = 200;

options = optimoptions('fmincon', 'Display', 'off');
[x_opt, min_cost] = fmincon(cost_fun, x0, [], [], [], [], lb, ub, [], options);
y_opt = 2000 / x_opt;

fprintf('--- Problem 2 Results ---\n');
fprintf('Optimal width parallel to road (x): %.4f m\n', x_opt);
fprintf('Optimal length perpendicular (y): %.4f m\n', y_opt);
fprintf('Minimum Cost: $%.2f\n\n', min_cost);

x_vals = linspace(10, 100, 200);
c_vals = 20*x_vals + (20000./x_vals);
figure;
plot(x_vals, c_vals, 'LineWidth', 2, 'Color', [0 0.5 0]); hold on;
plot(x_opt, min_cost, 'ko', 'MarkerSize', 10, 'MarkerFaceColor', 'k');
title('Fencing Cost vs. Width');
xlabel('Width Parallel to Road x (m)'); ylabel('Total Cost ($)');
legend('Cost Curve', 'Minimum Cost Point');
grid on;