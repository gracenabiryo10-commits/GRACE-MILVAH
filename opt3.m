% Problem 3: Minimum-Cost Ore Blending (Quadratic Programming)
clear; clc; close all;

grade = [1.2; 2.0; 3.2];
a     = [10; 12; 18];
b     = [0.004; 0.006; 0.010];
cap   = [600; 600; 400];

total_ore = 1000; target_grade = 2.0;

H = diag(2*b);
f = a;

Aeq = [1 1 1;
       grade'];
beq = [total_ore; target_grade*total_ore];

lb = zeros(3, 1);
ub = cap;

options = optimoptions('quadprog', 'Display', 'off');
[x_opt, fval] = quadprog(H, f, [], [], Aeq, beq, lb, ub, [], options);

blend_grade = (grade' * x_opt) / sum(x_opt);

fprintf('--- Problem 3 Results ---\n');
benches = {'A', 'B', 'C'};
for i = 1:3
    fprintf('Bench %s: %.2f t/day\n', benches{i}, x_opt(i));
end
fprintf('Total ore: %.2f t/day\n', sum(x_opt));
fprintf('Blend grade: %.3f g/t\n', blend_grade);
fprintf('Minimum total mining cost: $%.2f per day\n', fval);
fprintf('Average cost: $%.2f per tonne\n\n', fval/sum(x_opt));

figure;
bar(categorical(benches), x_opt, 0.5); hold on;
plot(1:3, cap, 'k_', 'MarkerSize', 20, 'LineWidth', 2);
title('Optimal Ore Blend by Bench');
xlabel('Bench'); ylabel('Ore mined (t/day)');
legend('Optimal tonnes', 'Bench limit');
grid on;

t_vals = linspace(160, 400, 100);
cost_vals = zeros(size(t_vals));
for k = 1:length(t_vals)
    xAB = Aeq(:, 1:2) \ (beq - Aeq(:, 3)*t_vals(k));
    x = [xAB; t_vals(k)];
    cost_vals(k) = 0.5*x'*H*x + f'*x;
end

figure;
plot(t_vals, cost_vals, 'LineWidth', 2); hold on;
plot(x_opt(3), fval, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
x_two = [600; 0; 400];
plot(400, 0.5*x_two'*H*x_two + f'*x_two, 'ks', 'MarkerSize', 9);
title('Mining Cost Along the Feasible Blends');
xlabel('Tonnes mined from bench C (t/day)'); ylabel('Total mining cost ($/day)');
legend('Cost of every feasible blend', 'Optimal blend', 'Only benches A and C');
grid on;