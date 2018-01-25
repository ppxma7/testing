% taylor expansion stuff
% for delta(E)/kbT stuff
clc
x = 0.5;
theAnswer = exp(x);
fprintf('\nActual %.3f\n', theAnswer)
myexpan = 1 + x + ( x^2./factorial(2) ) + ( x^3./factorial(3) ); % taylor expansion
fprintf('\nApprox x^3 %.3f\n', myexpan)
highTemp = 1 + x;
fprintf('\nApprox high temp %.3f\n\n', highTemp)