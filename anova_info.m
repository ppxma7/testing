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

%% f-ratio

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

% total sum of squares (observed - grand mean)
sst = sum([predssX1; predssX2; predssX3]);
% dof here is N - 1

% residual sum of squares (observed - model (i.e. the group mean) )
ssr = sum([x1total; x2total; x3total]);
% dof here is N - no. of groups

% model sum of squares (grand mean - model) (for 3 groups)
% or to simplify things..
ssmodel = sst - ssr;
% dof here is no. of groups - 1

% so far, sst/r/m are all totals, which explain total variation. But sse
% used sum of all 36 vals, whilst ssmodel used sum of 3 vals (mean of the
% groups). So, we should find the Mean Sum of Squares (MS), by dividing by
% dof.
groups = 3;
MS_model = ssmodel ./ (groups-1); % used 3 group means minus 1 (for dof)

MS_residual = ssr ./ (N - groups);

% Now can calculate f-ratio (explained variance to noise)
f_ratio = MS_model ./ MS_residual; 

% dof model is 2, dof resid is 33. Look at f-table and at 0.05, the
% critical value is 3.28. If our value is less than that, then not
% significant at p = 0.05

%% contrast coding

% 1) compare 2 groups against control
% 2) compare 2 groups against each other
%
%        contrast 1   contrast 2    contrast 1 .*
%                                   contrast 2
%                                    (product)
%     x1 = [ -2           0             0        ] (x1 is our control)
%     x2 = [  1           1             1        ]
%     x3 = [  1          -1            -1        ]

% y = b0 + b1(dummy1) + b2(dummy2) + error
% y = b0 + b1(x2 & x3 vs. x1) + b2 (x2 vs. x3)

% in this case b0 = grand mean (if group membership is unknown, then
% predicted value of the outcome would be the grand mean). 

% mean(x1) = b0 + (-2 .* b1) + (b2 .* 0) %look at first row, first two
%                                                                  columns
% mean(x1) = b0 - 2b1
% 2b1 = b0 - mean(x1)
% 2b1 =     ( mean(x2) + mean(x3) + mean(x1) ./ 3  ) - mean(x1)
% 6b1 =       mean(x2) + mean(x3) + mean(x1)         - 3mean(x1)
% 6b1 =       mean(x2) + mean(x3) + 2mean(x2)
% 3b1 =     ( mean(x2) + mean(x3) . / 2 )            - mean(x1)
% b1 = 0.33 ( mean(x2) + mean(x3) . / 2 )            - mean(x1) 

contrastb1 = (1./3) .* (  (meanX2 + meanX3)./2 - meanX1 );

% now look at x2 

% mean(x2) = b0 + (b1 .* 1) + (b2 .* 1) %look at second row, first two
%                                                                  columns
% b2 = mean(x2) - b1 - b0
% now take b1 from previous derivation and b0
% messy...          --------------- b1 --------------------------       --------------b0---------------
% b2 = mean(x2)   -  0.33 ( mean(x2) + mean(x3) . / 2 ) - mean(x1))  -   ( mean(x2) + mean(x3)  + mean(x1) ./ 3  )
% 3b2 = 3mean(x2) -       ( mean(x2) + mean(x3) . / 2 ) - mean(x1))  -   ( mean(x2) + mean(x3)  + mean(x1) ./ 3  )
% 6b2 = 6mean(x2) -       ( mean(x2) + mean(x3)         - 2mean(x1)) -  2( mean(x2) + mean(x3)  + mean(x1) )
% 6b2 = 6mean(x2) -         mean(x2) - mean(x3)         + 2mean(x2)  -  2mean(x2)   - 2mean(x3) - 2mean(x2) )

% 6b2 = 3mean(x2) - 3mean(x3)
% b2 = mean(x2) - mean(x3) ./2

contrastb2 = (meanX2 - meanX3) ./ 2;

% from here, you can work out t-stats, and associated pvalue to check for
% signficance.
% needs fixing!!!

% p = 3; % number of parameters (regression coeffs)
% varModel = ssr ./ (N - p);
% seModel = sqrt(varModel); %<--- standard error in the model
% 
% % model standard error divided by sum of squares for predictor x (but first
% % sqrt)
% seb = seModel ./ sqrt(x2total); %<-- this is the standard error of b1
% tb = contrastb1 ./ seb;

