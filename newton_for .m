% Newton _ function%%
x = 0.5;
tol = 1e-6;
maxIter = 100;

fprintf('Iteration\t x\t\t Error\n');

for i = 1:maxIter

    fx = myFunction(x);
    dfx = myDerivative1(x);

    xnew = x - fx/dfx;

    error = abs(xnew - x);

    fprintf('%d\t\t %.8f\t %.8f\n', i, xnew, error);

    if error < tol
        break;
    end

    x = xnew;

end

fprintf('\nRoot = %.8f\n', xnew);
fprintf('Number of iterations = %d\n', i); 
