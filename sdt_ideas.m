% %some signal detection (SDT)
%
% ds + ma

% x - internal variable
%%
x = linspace(-5,5,100);

%% 
% noise distribution
% signal+noise distribution
% given a particular d-prime: d
d = 0.5;

% pdfs for the nice diagram
n = normpdf(x, 0, 1); % centered at mu = 0 (by fiat... because we like it there); sigma = 1 for both distributions
sn = normpdf(x, 0 + d, 1);

% cdfs for more useful / ROC calculations

n_cdf = normcdf(x, 0, 1); 
sn_cdf = normcdf(x, 0 + d, 1);


figure
subplot(2,1,1)
plot(x,n,'k', x,sn, 'r')

% let's pick a criterion c (on the response axis)
% michael likes 1

c = 1;
% make verticl line
hold on
plot([1 1]*c, get(gca, 'ylim'), 'linewidth', 2) 


subplot(2,1,2)
plot(x,n_cdf,'k', x,sn_cdf, 'r')


%% 
% we now need p(hits), p(FA)
% which are the 1 - cumulattive areas

pFA = 1- n_cdf;
pHit = 1- sn_cdf;

figure
plot(pFA, pHit, 'k')
axis([0 1 0 1])
axis square


cs = [1, 0, -2];
% for only 1 c and a partiuclar d'
pFA_1 = 1 -  normcdf(cs, 0, 1); 
pHit_1 = 1 - normcdf(cs, 0 + d, 1);

hold on
plot(pFA_1, pHit_1, 'ro', 'markerfacecolor', 'r', 'markersize',7)

