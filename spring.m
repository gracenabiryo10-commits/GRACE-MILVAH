% Assignment: Solver Benchmark for Spring Weight Minimization
clear; clc; close all;

% Design variables: x1 = wire diameter, x2 = coil diameter, x3 = active coils
obj_fun = @(x) x(1)^2 * x(2) * (x(3) + 2);

% Bounds from the slide
lb = [0.05, 0.25, 2.0];  
ub = [2.00, 1.30, 15.0]; 
nvars = 3;               
x0 = [0.1, 0.5, 10.0]; % Initial guess for local solvers

% Set up lists to store the names, times, and answers
solvers = {'fmincon', 'patternsearch', 'ga', 'particleswarm', 'simulannealbnd', 'surrogateopt'};
times = zeros(1, 6);
results = zeros(6, 3);
fvals = zeros(1, 6);

% Turn off the long command window printouts for each solver
opt_f = optimoptions('fmincon', 'Display', 'off');
opt_p = optimoptions('patternsearch', 'Display', 'off');
opt_g = optimoptions('ga', 'Display', 'off');
opt_ps = optimoptions('particleswarm', 'Display', 'off');
opt_sa = optimoptions('simulannealbnd', 'Display', 'off');
opt_so = optimoptions('surrogateopt', 'Display', 'off');

%% Run and Time each solver using tic/toc

% 1. fmincon
tic;
[r1, f1] = fmincon(obj_fun, x0, [], [], [], [], lb, ub, @spring_constraints, opt_f);
times(1) = toc; results(1,:) = r1; fvals(1) = f1;

% 2. patternsearch
tic;
[r2, f2] = patternsearch(obj_fun, x0, [], [], [], [], lb, ub, @spring_constraints, opt_p);
times(2) = toc; results(2,:) = r2; fvals(2) = f2;

% 3. ga
tic;
[r3, f3] = ga(obj_fun, nvars, [], [], [], [], lb, ub, @spring_constraints, opt_g);
times(3) = toc; results(3,:) = r3; fvals(3) = f3;

% Note: particleswarm, simulannealbnd, and surrogateopt don't accept 
% non-linear constraints directly, so we use a penalty function wrapper.
fit_fun = @(x) penalty_wrapper(x, obj_fun, lb, ub);

% 4. particleswarm
tic;
[r4, ~] = particleswarm(fit_fun, nvars, lb, ub, opt_ps);
times(4) = toc; results(4,:) = r4; fvals(4) = obj_fun(r4);

% 5. simulannealbnd
tic;
[r5, ~] = simulannealbnd(fit_fun, x0, lb, ub, opt_sa);
times(5) = toc; results(5,:) = r5; fvals(5) = obj_fun(r5);

% 6. surrogateopt
tic;
[r6, ~] = surrogateopt(fit_fun, lb, ub, opt_so);
times(6) = toc; results(6,:) = r6; fvals(6) = obj_fun(r6);

%% Print the results table
disp('------------------------------------------------------------------------');
fprintf('%-16s | %-20s | %-12s | %-12s\n', 'Solver', 'Optimal [x1, x2, x3]', 'Min Weight', 'Time (s)');
disp('------------------------------------------------------------------------');
for i = 1:6
    vec = sprintf('[%.3f, %.3f, %.3f]', results(i,1), results(i,2), results(i,3));
    fprintf('%-16s | %-20s | %-12.5f | %-12.4f\n', solvers{i}, vec, fvals(i), times(i));
end
disp('------------------------------------------------------------------------');

%% Plot the computation times
figure;
bar(times, 'FaceColor', [0.2 0.5 0.8]);
set(gca, 'XTickLabel', solvers, 'XTick', 1:6);
title('Computation Time Comparison');
xlabel('Optimization Solver');
ylabel('Execution Time (Seconds)');
grid on;

%% Constraint and Penalty Functions
function [c, ceq] = spring_constraints(x)
    ceq = [];
    c = zeros(4,1);
    % Equations rewritten to fit the c(x) <= 0 standard format
    c(1) = (x(2)^3 * x(3)) / (71785 * x(1)^4) - 1;
    c(2) = 1 - (4*x(2)^2 - x(1)*x(2)) / (12566 * x(1)^3 * (x(2) - x(1))) - 1 / (5108 * x(1)^2);
    c(3) = (140.45 * x(1)) / (x(3) * x(2)^2) - 1;
    c(4) = (x(1) + x(2)) / 1.5 - 1;
end

function score = penalty_wrapper(x, obj_fun, lb, ub)
    % Return a high penalty if bounds are missed
    if any(x < lb) || any(x > ub)
        score = 1e5;
        return;
    end
    [c, ~] = spring_constraints(x);
    score = obj_fun(x);
    % Add a heavy penalty if any constraint is violated
    if any(c > 0)
        score = score + 1000 + 5000 * sum(c(c > 0));
    end
end
