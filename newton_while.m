clc;
clear;

x = 0.5;
tol = 1e-6;
maxIter = 100;

i = 0;
error = Inf;

fprintf('Iteration\t x\t\t Error\n');

while error >= tol && i < maxIter

    i = i + 1;

    fx = myFunction1(x);
    dfx = myDerivative1(x);

    xnew = x - fx/dfx;

    error = abs(xnew - x);

    fprintf('%d\t\t %.8f\t %.8f\n', i, xnew, error);

    x = xnew;

end

fprintf('\nRoot = %.8f\n', x);
fprintf('Number of iterations = %d\n', i);