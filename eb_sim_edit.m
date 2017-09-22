% script to simulate some r2 and co data, to see what curve they produce
% when correlated

% edited from EB script Deconvolution simulation V2
% [ma] sept2017

%% Eleanor Barratt
% Deconvolution Simulation - V2
% 28/01/16

% % Initial simulation
% 
% font_size = 18;

% % Generate haemodynamic response using gamma function
% max_time = 20;
% dt = 0.6; % Equivalent of TR time
% time = 0:dt:(max_time-dt); 
% n = length(time);
% hrf = gampdf(time,6) -0.5*gampdf(time,10);
% %Create block containing simulated button presses equal to 1 and zero
% %otherwise
% max_block = 8*60;
% s = zeros(max_block/dt,1);
% sequence_time = 0:dt:(max_block-dt);

% figure;
% plot(time,hrf)
% xlabel('Time (s)')
% ylabel('HRF')
% set(gcf,'Color','White')
% set(gca,'fontsize',font_size)
% title('HRF')
% set(findall(gcf,'type','text'),'fontSize',font_size)

% % plot hrf
% tr = 2;
% t = 0:tr:(30-tr); % time in s
% p = [6 12 0.9 0.9 0.35];
% % add a zero to scale to 1
% hrf = fmribHRF(t, p ,0);
% % figure
% plot(t,hrf)
% 
% 
% max_block = 8*3;
% %s = zeros(max_block/tr,1);
% s = zeros(max_block, 1);
% % sequence_time = 0:tr:(max_block-tr);
% 
% 
% % Generate model of button presses
% % Chose random times of button press
% s(1:10) = 0.5;
% s = cat(1,s,s,s,s,s,s,s,s,s,s);
% sequence_time = 1:length(s); 
% 
% 
% %% Try using Wiener Deconvolution
% 
% % Need to make them the same length
% newlength = length(hrf)+length(s)-1;
% hrf_pad = [hrf zeros(1,newlength-length(hrf))]; 
% s_pad = [s' zeros(1,newlength-length(s'))];
% 
% % First to convolution
% signal_FFT = ifft(fft(hrf_pad).*fft(s_pad));
% std_noise = 0.2; % STD of noise
% noise = std_noise*(randn(newlength,1));
% signal_noise = signal_FFT + noise';
% f = figure;
% set(f,'Position',[79 528 1538 420])
% %plot(sequence_time,signal_noise(1:length(sequence_time)))
% plot(sequence_time,signal_noise(1:length(sequence_time)))
%% plot sine wave

% easier just to make a noisy sine wave, this simulates TW data quite
% well...

std_noise = 0.2; % STD of noise
noise = std_noise*(randn(newlength,1));

f = 10./ 240;
bla = sin(2*pi*f*sequence_time);

f_sinewave = 1;

%hold on
figure
plot(bla)
signal_noise = sin(2*pi*f_sinewave*sequence_time)+noise(1:240)';
hold on
plot(signal_noise)

%% cor anal
tSeries = signal_noise';

%ft = fft(ptSeries);
ft = fft(tSeries);
ft = ft(1:1+fix(size(ft, 1)/2), :);
nFrames = size(tSeries,1);
ampFT = 2*abs(ft)/nFrames;
nCycles = 10;

% Compute co and amp (avoiding divide by zero)
amp = ampFT(nCycles+1,:);
co = zeros(size(amp),'single');
sumAmp = sqrt(sum(ampFT.^2));
nonzeroIndices = find(sumAmp >0);
co(nonzeroIndices) = ampFT(nCycles+1,nonzeroIndices) ./ sumAmp(nonzeroIndices);



