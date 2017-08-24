% name:     af
% purpose:  - this is a script with some basic ideas about stats, like glm /
%           sum of squares etc.
%           - data and progression is from "An Adventure in Statistics"
%           Andy Field, 2016
%           - everything is spelled out step by step (instead of
%           using functions like var or std or ttest2) so you can see every single step.
%
% author:   [ma]
% date:     2017-08

%% basics

% y = [4 1 2 3 2 5 5 3 1 3]';
% x = [4 4 5 1 4 3 2 4 4 3]';

%y = [13 15 30 16 19 23 15 16 26 23]';
%x = [0 2 14 0 13 9 1 4 3 7]';
% N = length(x);

% comparing two means
% recall that...
%
%                observed difference -   expected difference    
%                    between means        between means if      
%        t =                            null hypothesis is true 
%                --------------------./-------------------------- 
%
%                    standard error of sample means difference
%
% let's do an independent t-test!

x1 = [11 11 10 9 7 11 12 14 19 11 19 11 17 13]';
x2 = [10 4 9 11 9 14 16 13 7 12 0 10 13 0]';
y = [x1; x2];
N = length(x1).*2;
x = [zeros(N./2,1); ones(N./2,1)]; 

% mean
meanX = mean(x);
meanY = mean(y);

% squared deviance
devSqrX = (x - meanX).^2;
devSqrY = (y - meanY).^2;

% sum of squared errors
sseX = sum(devSqrX);
sseY = sum(devSqrY);

% sse divided by N-1 = variance
varX = sseX ./ (N-1);
varY = sseY ./ (N-1);

% standard deviation = sqrt(variance)
sdX = sqrt(varX);
sdY = sqrt(varY);

% cross product deviations
xcp = x - meanX;
ycp = y - meanY;
cp = xcp .* ycp;
% sum of cross products
scp = sum(cp);

%% for glm...
% for outcome_i = (  b_0  + b_1 .* X_i ) + error
% predictor sum of squares
predssX = sum((xcp.^2));
% find regression coeffs
b1 = scp ./ predssX;

% so far...
% Y = b0 + b1  .*  X
% rearrange: b0 = Y - b1 .* X
% b0 = mean(Y) - b1 .* mean(X)
b0 = meanY - (b1 .* meanX);

% get a model prediction
% e.g. b0 + b1 .* X

% make space, fill it up
modelData = [zeros(N,1) zeros(N,1)];
modelData(:,1) = repmat(b0, N, 1);
modelData(:,2) = repmat(b1, N, 1);

% now we output our model y's
modelY = modelData(:,1) + (modelData(:,2).*x); 

% residual y's (y - model y's)
residY = y - modelY;
sqresidY = residY.^2;
ssr = sum(sqresidY); % residual sum of squares


% now we can find the standard error of b
p = 2; % number of parameters (regression coeffs)
varModel = ssr ./ (N - p);
seModel = sqrt(varModel); %<--- standard error in the model

% model standard error divided by sum of squares for predictor x (but first
% sqrt)
seb = seModel ./ sqrt(predssX); %<-- this is the standard error of b1



% confidence intervals for b1
% 95% upper/lower = b +/- (t_n-p .* seb)
% t for 8 dof, at 0.05 is 2.306
% t for 26 dof, 0.05, is 2.056
ci95lower = b1 - (2.056 .* seb);
ci95upper = b1 + (2.056 .* seb);

% is this value is greater than the t stat at N-p dof, then it is
% significant (depending on what p you want)
% for a two-tailed test, we must look at the interval between the
% confidence intervals, if our value lies outside this, then it is
% significant

% for a paired samples t-test, we would just do the same for the
% differences.
% mean(differences) and std of difference
% se_diff = sd ./ sqrt(N)
% t = mean(differences) ./ se_diff
tb = b1 ./ seb;




%% goodness of fit

% 1  - residual sum of squares divided by total sum of squares
sst = sseY;
r2 = 1 - (ssr ./ sst);
% with one variable (predictor), this is equivalent to Pearson's
% correlation coeff

%% covariance
cov = scp ./ (N-1);

% pearson's r
r = cov ./ (sdX.*sdY);

% t scores
t = (r .* sqrt(N-2))  ./  sqrt(  (1-r.^2)  );

% matlab: 
[h p ci stats] = ttest2(x, y);

% df = N - no. parameters
% for this dataset, df = 8, and at p = 0.05, tnull = 2.306
% for values smaller than this, the trend is not significant


%% effect size
d = (meanX1 - meanX2) ./ seModel;
% for paired samples, would have to use:
% d = d ./ sqrt(1-r) where r is pearson's correlation
% standardize by dividing by std and .* sqrt(2)

