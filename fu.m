
%cd /Users/ppxma7/data/10301_pRF_Vis2
%cd /Users/ppxma7/data/11120_pRF_Vis8
%clc
%clear variables
%load('rh_5s_getroitseries_feb18.mat')
%load('grt_5s2_kill.mat')
load('kill_grt_5s_mb3.mat')
clean_lkj = detrend(clean_lkj);
clean_lkj = clean_lkj.*100;
mclean13 = mean(clean_lkj,2);
msem13 = std(clean_lkj,0,2) ./ sqrt(length(mclean13));
x = 1:55;
%figure, errorbar(mclean, msem);

%clear variables
%
mboop = mean(clean_lkj,2);
mmboop = max(mboop,[],1);

figure
h = errorPlot(x, mclean13, msem13, [0 0 0], [1 1 1]*0.8, 0.6, 1);
hold on

clear clean_lkj mclean msem

%load('rh_1s_getroitseries_feb18.mat')
load('kill_grt_1s_mb3.mat')
clean_lkj = detrend(clean_lkj);
clean_lkj = clean_lkj.*100;
mclean14 = mean(clean_lkj,2);
msem14 = std(clean_lkj,0,2) ./ sqrt(length(mclean14));

hh = errorPlot(x, mclean14, msem14, [0 0 1], [1 1 1]*0.8, 0.6, 1);

clear clean_lkj mclean msem

%load('wiener_deconv_hrfs.mat')
load('wiener_kill_5s_mb3.mat')
clean_lkj = wienerShapes_empty;
%clean_lkj = detrend(clean_lkj);
%clean_lkj = clean_lkj.*100;
%keyboard

%fudge factor for pRFVis4
%clean_lkj = detrend(clean_lkj);
clean_lkj = clean_lkj.*3;
mclean15 = mean(clean_lkj,2);
msem15 = std(clean_lkj,0,2) ./ sqrt(length(mclean15));

hhh = errorPlot(x, mclean15, msem15, [1 0 0], [1 1 1]*0.8, 0.6, 1);

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

%% general plotting

figure
load('kill_d2_glm.mat')
x = 1:29;
xT = 1:522;

if exist('clean_bla','var')
    clean_lkj = clean_bla;
else
    %clean_lkj = detrend(clean_lkj);
    %clean_lkj = clean_lkj.*100;
    clean_lkj = (clean_lkj-1).*100;
end

mclean = mean(clean_lkj,2);
msem = std(clean_lkj,0,2) ./ sqrt(length(mclean));
%figure, errorbar(mclean, msem);
% clear variable
rr = errorPlot(x, mclean, msem, [1 0 0], [1 1 1]*0.85, 0.6, 2);

if exist('clean_tmp','var')
    tmpSeries2 = clean_tmp;
else
    tmpSeries2 = detrend(tmpSeries);
    tmpSeries2 = tmpSeries2.*100;
end

mcleanTT = mean(tmpSeries2,2);
msemTT = std(tmpSeries2,0,2) ./ sqrt(length(mcleanTT));

load('kill_d3_glm.mat')
if exist('clean_bla','var')
    clean_lkj = clean_bla;
else
    %clean_lkj = detrend(clean_lkj);
    %clean_lkj = clean_lkj.*100;
    clean_lkj = (clean_lkj-1).*100;
end
mclean = mean(clean_lkj,2);
msem = std(clean_lkj,0,2) ./ sqrt(length(mclean));
hold on
rrr = errorPlot(x, mclean, msem, [0 1 0], [1 1 1]*0.85, 0.6, 2);

if exist('clean_tmp','var')
    tmpSeries2 = clean_tmp;
else
    tmpSeries2 = detrend(tmpSeries);
    tmpSeries2 = tmpSeries2.*100;
end

mcleanTTT = mean(tmpSeries2,2);
msemTTT = std(tmpSeries2,0,2) ./ sqrt(length(mcleanTTT));

load('kill_d4_glm.mat')
if exist('clean_bla','var')
    clean_lkj = clean_bla;
else
    %clean_lkj = detrend(clean_lkj);
    %clean_lkj = clean_lkj.*100;
    clean_lkj = (clean_lkj-1).*100;
end
mclean = mean(clean_lkj,2);
msem = std(clean_lkj,0,2) ./ sqrt(length(mclean));
hold on
rrrr = errorPlot(x, mclean, msem, [0 0 1], [1 1 1]*0.85, 0.6, 2);

if exist('clean_tmp','var')
    tmpSeries2 = clean_tmp;
else
    tmpSeries2 = detrend(tmpSeries);
    tmpSeries2 = tmpSeries2.*100;
end

mcleanTTTT = mean(tmpSeries2,2);
msemTTTT = std(tmpSeries2,0,2) ./ sqrt(length(mcleanTTTT));

legend([rr rrr rrrr], {'D2', 'D3', 'D4'})
ylabel('BOLD % signal change')
xlabel('time (s)')
%ylim([-1.5 1.5])
% now for tmpseries

figure('Position',[100 100 1200 500]);
subplot(3,1,1)
rT = errorPlot(xT, mcleanTT, msemTT, [0 0 0], [1 1 1]*0.8, 1, 2);
xlim([0 522])
noEvents = 18-2;
vline(25)
hold on
for ii = 1:noEvents
    vline([25+(29.*ii)])
end
set(gca,'xticklabel', {[]});


subplot(3,1,2)
rTT = errorPlot(xT, mcleanTTT, msemTTT, [0 0 0], [1 1 1]*0.8, 1, 2);
xlim([0 522])

vline(25)
hold on
for ii = 1:noEvents
    vline([25+(29.*ii)])
end
ylabel('BOLD % signal change')
set(gca,'xticklabel', {[]});


subplot(3,1,3)
rTTT = errorPlot(xT, mcleanTTTT, msemTTTT, [0 0 0], [1 1 1]*0.8, 1, 2);
xlim([0 522])

vline(25)
hold on

for ii = 1:noEvents
    vline([25+(29.*ii)])
end

xlabel('time (s)')

%% plotting for Figure5.4 chapter5, vistest1

load('rh_grt_april2018_smallroi.mat')

x = 1:size(clean_lkj,1);
xT = 1:size(tmpSeries,1);

%if exist('clean_bla','var')
%    clean_lkj = clean_bla;
%else
%    clean_lkj = detrend(clean_lkj);
%    clean_lkj = clean_lkj.*100;
%end

mclean = mean(clean_lkj,2);
msem = std(clean_lkj,0,2) ./ sqrt(length(mclean));
figure
vv1 = errorPlot(x, mclean, msem, [0 0 0], [1 1 1]*0.85, 1, 2);

if exist('clean_tmp','var')
    tmpSeries2 = clean_tmp;
else
    tmpSeries2 = detrend(tmpSeries);
    tmpSeries2 = tmpSeries2.*100;
end



mcleanTT = mean(tmpSeries2,2);
msemTT = std(tmpSeries2,0,2) ./ sqrt(length(mcleanTT));
figure
vv1T = errorPlot(xT, mcleanTT, msemTT, [0 0 0], [1 1 1]*0.75, 1, 2);
%xlim([0 ])

noEvents = 6;
vline(45)
hold on
for ii = 1:noEvents
    vline((45.*ii))
end
ylabel('BOLD % signal change')
%set(gca,'xticklabel', {[]});
xlabel('time (s)')


   
   
   
   
   
   
   
   
   