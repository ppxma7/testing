
lambda = 42.58;
B = 1:10;

for ii = 1:10
    omega(ii) = myfield(lambda, B(ii));
end

figure, scatter(1:10,omega)





function[omega] = myfield(lambda, B)

if nargin == 0
    lambda = 42.58;
    B = 7;
elseif nargin == 1
    B = 7;
end

omega = lambda .* B;


end