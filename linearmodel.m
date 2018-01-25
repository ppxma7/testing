function[yhat] = linearmodel(b0, b1, xdata)

if nargin < 3
    b0 = 15.62;
    b1 = 0.75;
    xdata = [0 2 14 0 13 9 1 4 3 7];
end

y = [13 15 30 16 19 23 15 16 26 23];

for ii = 1:length(xdata)
yhat(ii) = b0 + (b1 .* xdata(ii));
end

for ij = 1:length(y)
resids(ij) = y(ij) - yhat(ij);
end

sqrdresids = resids.^2;
ssr = sum(sqrdresids);


figure, scatter(xdata, y, 'MarkerFaceColor', 'b')
hold on
plot(xdata,yhat, '-o', 'MarkerFaceColor', 'r')


for jj = 1:length(xdata)
hold on
plot([xdata(jj) xdata(jj)], [ y(jj) y(jj)-resids(jj)], '--')
end

set(gca, 'fontsize', 14)

xlabel('Example x data')
ylabel('Example y data')
legend('xdata', 'predicted model', 'residuals')


end