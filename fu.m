
cd /Users/ppxma7/data/10301_pRF_Vis2

load('rh_5s_getroitseries_feb18.mat')
clean_lkj = detrend(clean_lkj);
clean_lkj = clean_lkj.*100;
mclean = mean(clean_lkj,2);
msem = std(clean_lkj,0,2) ./ length(mclean);
x = 1:55;
%figure, errorbar(mclean, msem);

%clear variables
%

figure
h = errorPlot(x, mclean, msem, [0 0 0], [1 1 1]*0.8, 1, 1);
hold on

clear clean_lkj mclean msem

load('rh_1s_getroitseries_feb18.mat')
clean_lkj = detrend(clean_lkj);
clean_lkj = clean_lkj.*100;
mclean = mean(clean_lkj,2);
msem = std(clean_lkj,0,2) ./ length(mclean);

hh = errorPlot(x, mclean, msem, [0 0 1], [1 1 1]*0.8, 1, 1);

clear clean_lkj mclean msem

load('wiener_deconv_hrfs.mat')
clean_lkj = wienerShapes_empty;
clean_lkj = detrend(clean_lkj);
clean_lkj = clean_lkj.*100;
mclean = mean(clean_lkj,2);
msem = std(clean_lkj,0,2) ./ length(mclean);

hhh = errorPlot(x, mclean, msem, [1 0 0], [1 1 1]*0.8, 1, 1);

xlabel('time (s)')
ylabel('BOLD % signal change')

legend([h hh hhh], {'5s','1s', 'Wiener deconv 5s'})

