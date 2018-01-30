% script to simulate some r2 and co data, to see what curve they produce
% when correlated

% edited from EB script Deconvolution simulation V2
% [ma] sept2017
%% plot sine wave

% easier just to make a noisy sine wave, this simulates TW data quite
% well...

newlength = 240;
nCycles = 10;
sequence_time = 1:newlength;

std_noise = 0.5; % STD of noise
noise = std_noise*(randn(newlength,1));

f = nCycles ./ newlength;
signal = sin(2*pi*f*sequence_time);

% if we change the frequency, then the coherence will drop!
f_sinewave = f;

% regardless of phase offset, coherence should still be high (measure of a
% fixed phase correlation)
phaseOff = 0;

%hold on
figure
plot(signal)
signal_noise = sin(2*pi*f_sinewave*sequence_time + phaseOff)+noise(1:240)';
hold on
plot(signal_noise)

%% cor anal 
% taken from computeCorAnal - justinGardner
hold off
tSeries = signal_noise';

%ft = fft(ptSeries);
ft = fft(tSeries);
ft = ft(1:1+fix(size(ft, 1)/2), :);
nFrames = size(tSeries,1); % nFrames is the same as newlength
ampFT = 2*abs(ft)/nFrames;
%nCycles = 10;

% Compute co and amp (avoiding divide by zero)
amp = ampFT(nCycles+1,:);
co = zeros(size(amp),'single');
sumAmp = sqrt(sum(ampFT.^2));
nonzeroIndices = find(sumAmp >0);
co(nonzeroIndices) = ampFT(nCycles+1,nonzeroIndices) ./ sumAmp(nonzeroIndices);
fprintf('\nCoherence is %.3f\n\n', co)

%% calc r2 between signal and signal_noise
r = corr(signal(:), signal_noise(:));
r2 = r .^2;
fprintf('\nr2 is %.3f\n\n', r2)

%% compare r2 and co relationship
% we want to simulate lots of voxels with different values of co and r2,
% then correlate them in a scatter and look for either a quadratic curve or
% a linear curve, and it will tell us the dependency


data_signal = zeros(256,newlength);


std_noise = 0; % STD of noise
noise = std_noise*(randn(newlength,1));

% this is our "model" (skip nlsq)
sine_wave = sin(2*pi*f*sequence_time);

% crazy for loop
for ii = 1:256
    
    % add some noise to the clean sine wave (signal)
    data_signal(ii,:) = signal' + noise;
    
    %% compute coherence
    tSeries = data_signal(ii,:)';
    %ft = fft(ptSeries);
    ft = fft(tSeries);
    ft = ft(1:1+fix(size(ft, 1)/2), :);
    nFrames = size(tSeries,1); % nFrames is the same as newlength
    ampFT = 2*abs(ft)/nFrames;
    %nCycles = 10;
    % Compute co and amp (avoiding divide by zero)
    amp = ampFT(nCycles+1,:);
    coZ = zeros(size(amp),'single');
    sumAmp = sqrt(sum(ampFT.^2));
    nonzeroIndices = find(sumAmp >0);
    coZ(nonzeroIndices) = ampFT(nCycles+1,nonzeroIndices) ./ sumAmp(nonzeroIndices);
    
    co(ii) = coZ;
    %% compute r2
    
    
    r = corrcoef(data_signal(ii,:), sine_wave);
    r = r(2,1);
    %r = corr(data_signal(ii,:), sine_wave);
    r2(ii) = r .^2; 
    
    % increment the noise
    std_noise = std_noise + 0.01;
    noise = std_noise*(randn(newlength,1));
end

%% gramm_sim
g = gramm('x', co, 'y', r2); 
%g = gramm('x', co, 'y', r2); 
%cmap = rainbow_colors(4).*0.9;
%g.set_color_options('map', cmap)
%g(1,1).geom_jitter('height',0.1, 'alpha',0.6);
g.geom_point('dodge', 0.5, 'alpha',0.5);
%g.stat_glm('disp_fit',true)

%g.facet_wrap(dig,'ncols',2,'scale','fixed')
%g.set_names('x','Coherence (TW)', 'y', 'r2 (pRF)', 'column', 'Digit', 'color', 'Digit (pRF)')
g.set_names('x','Coherence ', 'y', 'r2 ')
g.axe_property('YLim', [0,1])

g.set_title('Coherence and r2 ')
g.set_text_options('font', 'Helvetica', 'base_size', 16)
g.set_color_options('map', cmap(1,:))
g.draw()

%% real data
r2 = prf_overlays(:,1);
r = sqrt(r2);
co = tw_overlays(:,1);

idx = ~isnan(r2);
r2 = r2(idx);
r = r(idx);
co = co(idx);

corrcoef(co,r2);
% corrcoef(co,r);

%% gramm
cmap = [228,26,28; 55,126,184; 77,175,74; 152,78,163; 255,127,0];
cmap = cmap./256;

clf
g(1,1) = gramm('x', co, 'y', r2); 
%g = gramm('x', co, 'y', r2); 
%cmap = rainbow_colors(4).*0.9;
%g.set_color_options('map', cmap)
%g(1,1).geom_jitter('height',0.1, 'alpha',0.6);
g(1,1).geom_point('dodge', 0.5, 'alpha',0.5);
%g.stat_glm('disp_fit',true)

%g.facet_wrap(dig,'ncols',2,'scale','fixed')
%g.set_names('x','Coherence (TW)', 'y', 'r2 (pRF)', 'column', 'Digit', 'color', 'Digit (pRF)')
g(1,1).set_names('x','Coherence ', 'y', 'r2 ')
g(1,1).axe_property('YLim', [0,1])
g(1,1).axe_property('XLim', [0,1])

g(1,1).set_title('Coherence and r2 ')
g(1,1).set_text_options('font', 'Helvetica', 'base_size', 16)
g(1,1).set_color_options('map', cmap(1,:))


g(1,2) = gramm('x', co, 'y', r); 
%g = gramm('x', co, 'y', r2); 
%cmap = rainbow_colors(4).*0.9;
%g.set_color_options('map', cmap)
%g(1,2).geom_jitter('height',0.1, 'alpha',0.6);
g(1,2).geom_point('dodge', 0.5, 'alpha',0.5);
%g.stat_glm('disp_fit',true)

%g.facet_wrap(dig,'ncols',2,'scale','fixed')
%g.set_names('x','Coherence (TW)', 'y', 'r2 (pRF)', 'column', 'Digit', 'color', 'Digit (pRF)')
g(1,2).set_names('x','Coherence ', 'y', 'r ')
g(1,2).axe_property('YLim', [0,1])

g(1,2).axe_property('XLim', [0,1])


g(1,2).set_title('Coherence and r ')
g(1,2).set_text_options('font', 'Helvetica', 'base_size', 16)
g(1,2).set_color_options('map', cmap(1,:))

g.draw()

