% Problem 3: Portfolio Risk Minimization (Quadratic Programming)
clear; clc; close all;

% Covariance Matrix (Hessian matrix H)
H = [0.32, 0.04; 
     0.04, 0.18]; 

% Linear term vector (zeros since we only minimize variance)
f = [0; 0];

% Equality Constraints: Aeq * w = beq
% Row 1: Return requirement (0.12*wA + 0.08*wB = 0.10)
% Row 2: Weights sum to 1   (1*wA + 1*wB = 1)
Aeq = [0.12, 0.08;
       1.00, 1.00];
beq = [0.10; 
       1.00];

% Boundary constraints (0 <= w <= 1)
lb = [0; 0];
ub = [1; 1];

% Solve using quadprog
options = optimoptions('quadprog', 'Display', 'off');
[w_opt, fval] = quadprog(H, f, [], [], Aeq, beq, lb, ub, [], options);

% Display results
fprintf('--- Problem 3 Results ---\n');
fprintf('Weight in Asset A (wA): %.4f\n', w_opt(1));
fprintf('Weight in Asset B (wB): %.4f\n', w_opt(2));
fprintf('Minimized Portfolio Variance: %.4f\n', fval);

% Plotting the feasible space along the weight constraints
wA_space = linspace(0, 1, 100);
wB_space = 1 - wA_space;
var_space = zeros(size(wA_space));

for i = 1:length(wA_space)
    w = [wA_space(i); wB_space(i)];
    var_space(i) = 0.5 * w' * H * w;
end

figure;
plot(wA_space, var_space, 'LineWidth', 2); hold on;
plot(w_opt(1), fval, 'bx', 'MarkerSize', 12, 'LineWidth', 2);
title('Portfolio Variance vs. Weight of Asset A');
xlabel('Weight of Asset A (w_A)');
ylabel('Portfolio Variance (Risk)');
legend('Risk Frontier Grid', 'Optimal Solution (Target Return 10%)');
grid on;
