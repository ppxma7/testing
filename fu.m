
%cd /Users/ppxma7/data/10301_pRF_Vis2
%cd /Users/ppxma7/data/11120_pRF_Vis8
%clc
%clear variables
%load('rh_5s_getroitseries_feb18.mat')
load('grt_5s2_kill.mat')
clean_lkj = detrend(clean_lkj);
clean_lkj = clean_lkj.*100;
mclean13 = mean(clean_lkj,2);
msem13 = std(clean_lkj,0,2) ./ length(mclean13);
x = 1:55;
%figure, errorbar(mclean, msem);

%clear variables
%
mboop = mean(clean_lkj,2);
mmboop = max(mboop,[],1);

figure
h = errorPlot(x, mclean13, msem13, [0 0 0], [1 1 1]*0.8, 1, 1);
hold on

clear clean_lkj mclean msem

%load('rh_1s_getroitseries_feb18.mat')
load('grt_1s_kill.mat')
clean_lkj = detrend(clean_lkj);
clean_lkj = clean_lkj.*100;
mclean14 = mean(clean_lkj,2);
msem14 = std(clean_lkj,0,2) ./ length(mclean14);

hh = errorPlot(x, mclean14, msem14, [0 0 1], [1 1 1]*0.8, 1, 1);

clear clean_lkj mclean msem

%load('wiener_deconv_hrfs.mat')
load('grt_wiener_5s2.mat')
clean_lkj = wienerShapes_empty;
%clean_lkj = detrend(clean_lkj);
%clean_lkj = clean_lkj.*100;
%keyboard

%fudge factor for pRFVis4
%clean_lkj = detrend(clean_lkj);
clean_lkj = clean_lkj.*2;
mclean15 = mean(clean_lkj,2);
msem15 = std(clean_lkj,0,2) ./ length(mclean15);

hhh = errorPlot(x, mclean15, msem15, [1 0 0], [1 1 1]*0.8, 1, 1);

xlabel('time (s)')
ylabel('BOLD % signal change')

legend([h hh hhh], {'5s','1s', 'Wiener deconv 5s'})

%% plot mb3 vs mb2 better

ebalpha = 0.6;

load('kill_grt_1s_mb2.mat')
%clean_lkj = detrend(clean_lkj);
%clean_lkj = clean_lkj.*100;
mclean1s = mean(clean_bla,2);
msem1s = std(clean_bla,0,2) ./ sqrt(length(mclean1s));
x = 1:55;
%figure, errorbar(mclean, msem);

%clear variables
%
%mboop = mean(clean_bla,2);
%mmboop = max(mboop,[],1);

figure
subplot(2,1,1)
h = errorPlot(x, mclean1s, msem1s, [0 0 1], [1 1 1]*0.8, ebalpha, 1);
hold on

clear clean_lkj mclean msem

%load('rh_1s_getroitseries_feb18.mat')
load('kill_grt_1s_mb3.mat')
mclean1s3 = mean(clean_bla,2);
msem1s3 = std(clean_bla,0,2) ./ sqrt(length(mclean1s3));
%x = 1:55;

hh = errorPlot(x, mclean1s3, msem1s3, [1 0 0], [1 1 1]*0.8, ebalpha, 1);
ylim([-2 4])

ylabel('BOLD % signal change')



subplot(2,1,2)
clear clean_lkj mclean msem
legend([h hh], {'1s MB2', '1s MB3'})

%load('wiener_deconv_hrfs.mat')
load('kill_grt_5s_mb2.mat')
mclean5s = mean(clean_bla,2);
msem5s = std(clean_bla,0,2) ./ sqrt(length(mclean5s));
%x = 1:55;

hhh = errorPlot(x, mclean5s, msem5s, [0 0 1], [1 1 1]*0.8, ebalpha, 1);

clear clean_lkj mclean msem
% mb3
load('kill_grt_5s_mb3.mat')
mclean5s3 = mean(clean_bla,2);
msem5s3 = std(clean_bla,0,2) ./ sqrt(length(mclean5s3));
%x = 1:55;

hhhh = errorPlot(x, mclean5s3, msem5s3, [1 0 0], [1 1 1]*0.8, ebalpha, 1);

clear clean_lkj mclean msem



xlabel('time (s)')

legend([hhh hhhh], {'5s MB2', '5s MB3'})

