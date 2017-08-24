% name:     anova_info
% purpose:  - this is a script with some basic ideas about comparing
%           multiple means
%           - data and progression is from "An Adventure in Statistics"
%           Andy Field, 2016
%           - everything is spelled out step by step (instead of
%           using functions like var or std or ttest2) so you can see every single step.
%
% author:   [ma]
% date:     2017-08

%% Imagine we have 3 groups

x1 = [8 2 7 8 1 5 7 4 4 4 7 3]';
x2 = [10 5 3 4 3 7 8 3 4 3 4 3]';
x3 = [0 5 2 1 0 10 0 0 1 1 3 9]';

N = length(x1).*3;

% for each group
% mean
meanX1 = mean(x1);
meanX2 = mean(x2);
meanX3 = mean(x3);

% squared deviance
devSqrX1 = (x1 - meanX1).^2;
devSqrX2 = (x2 - meanX2).^2;
devSqrX3 = (x3 - meanX3).^2;

% sum of squared errors
sseX1 = sum(devSqrX1);
sseX2 = sum(devSqrX2);
sseX3 = sum(devSqrX3);

% sse divided by N-1 = variance
varX1 = sseX1 ./ (  (N./3) -1);
varX2 = sseX2 ./ (  (N./3) -1);
varX3 = sseX3 ./ (  (N./3) -1);

% standard deviation = sqrt(variance)
sdX1 = sqrt(varX1);
sdX2 = sqrt(varX2);
sdX3 = sqrt(varX3);

%for the grand group 
gx = [x1; x2; x3];
gMean = mean( gx );
gsse = sum((gx - gMean).^2);
gvar = gsse ./ (N-1);
gsd = sqrt(gvar);

% make some dummy variables
% outcome = b0  + b1.*X1 + b2.*X2 + error
%
%        x2  x3
% x1 = [ 0   0 ]
% x2 = [ 1   0 ]
% x3 = [ 0   1 ]
%
% we compare x2 vs. control and x3 vs. control
% y = b0 + (b1 .* 0) + (b2 .* 0)
% mean(control) = b0
b0 = meanX1;

% for x2
% y = b0 + (b1 .* 1) + (b2. * 0)
% y = b0 + b1
% mean(x2) = mean(control) + b1
% b1 = mean(x2) - mean(control)
b1 = meanX2 - meanX1;

% for x3
% y = b0 + (b1 .* 0) + (b2. * 1)
% y = b0 + b2
% b1 = mean(x3) - mean(control)
b2 = meanX3 - meanX1;



% find sums of squares now
%x1
x1resid = (x1 - gMean).^2;
predssX1 = sum(x1resid);

x1tot = (x1 - meanX1).^2;
x1total = sum(x1tot);

%x2
x2resid = (x2 - gMean).^2;
predssX2 = sum(x2resid);

x2tot = (x2 - meanX2).^2;
x2total = sum(x2tot);

%x3
x3resid = (x3 - gMean).^2;
predssX3 = sum(x3resid);

x3tot = (x3 - meanX3).^2;
x3total = sum(x3tot);

% total sum of squares
sst = sum([predssX1; predssX2; predssX3]);

% residual sum of squares
ssr = sum([x1total; x2total; x3total]);









% 
% 
% %% for glm...
% % for outcome_i = (  b_0  + b_1 .* X_i ) + error
% % predictor sum of squares
% predssX = sum((xcp.^2));
% % find regression coeffs
% b1 = scp ./ predssX;
% 
% % so far...
% % Y = b0 + b1  .*  X
% % rearrange: b0 = Y - b1 .* X
% % b0 = mean(Y) - b1 .* mean(X)
% b0 = meanY - (b1 .* meanX);
% 
% % get a model prediction
% % e.g. b0 + b1 .* X
% 
% % make space, fill it up
% modelData = [zeros(N,1) zeros(N,1)];
% modelData(:,1) = repmat(b0, N, 1);
% modelData(:,2) = repmat(b1, N, 1);
% 
% % now we output our model y's
% modelY = modelData(:,1) + (modelData(:,2).*x); 
% 
% % residual y's (y - model y's)
% residY = y - modelY;
% sqresidY = residY.^2;
% ssr = sum(sqresidY); % residual sum of squares
% 
% 
% % now we can find the standard error of b
% p = 2; % number of parameters (regression coeffs)
% varModel = ssr ./ (N - p);
% seModel = sqrt(varModel); %<--- standard error in the model
% 
% % model standard error divided by sum of squares for predictor x (but first
% % sqrt)
% seb = seModel ./ sqrt(predssX); %<-- this is the standard error of b1
% 
% 
% 
% % confidence intervals for b1
% % 95% upper/lower = b +/- (t_n-p .* seb)
% % t for 8 dof, at 0.05 is 2.306
% % t for 26 dof, 0.05, is 2.056
% ci95lower = b1 - (2.056 .* seb);
% ci95upper = b1 + (2.056 .* seb);
% 
% % is this value is greater than the t stat at N-p dof, then it is
% % significant (depending on what p you want)
% % for a two-tailed test, we must look at the interval between the
% % confidence intervals, if our value lies outside this, then it is
% % significant
% 
% % for a paired samples t-test, we would just do the same for the
% % differences.
% % mean(differences) and std of difference
% % se_diff = sd ./ sqrt(N)
% % t = mean(differences) ./ se_diff
% tb = b1 ./ seb;
% 
% 
% 
% 
% %% goodness of fit
% 
% % 1  - residual sum of squares divided by total sum of squares
% sst = sseY;
% r2 = 1 - (ssr ./ sst);
% % with one variable (predictor), this is equivalent to Pearson's
% % correlation coeff
% 
% %% covariance
% cov = scp ./ (N-1);
% 
% % pearson's r
% r = cov ./ (sdX.*sdY);
% 
% % t scores
% t = (r .* sqrt(N-2))  ./  sqrt(  (1-r.^2)  );
% 
% % matlab: 
% [h p ci stats] = ttest2(x, y);
% 
% % df = N - no. parameters
% % for this dataset, df = 8, and at p = 0.05, tnull = 2.306
% % for values smaller than this, the trend is not significant
% 
% 
% %% effect size
% d = (meanX1 - meanX2) ./ seModel;
% % for paired samples, would have to use:
% % d = d ./ sqrt(1-r) where r is pearson's correlation
% % standardize by dividing by std and .* sqrt(2)

