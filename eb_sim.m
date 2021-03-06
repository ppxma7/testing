% Eleanor Barratt
% Deconvolution Simulation - V2
% 28/01/16

% Initial simulation

font_size = 18;

% Generate haemodynamic response using gamma function
max_time = 20;
dt = 0.6; % Equivalent of TR time
time = 0:dt:(max_time-dt); 
n = length(time);
hrf = gampdf(time,6) -0.5*gampdf(time,10);
%Create block containing simulated button presses equal to 1 and zero
%otherwise
max_block = 8*60;
s = zeros(max_block/dt,1);
sequence_time = 0:dt:(max_block-dt);

figure;
plot(time,hrf)
xlabel('Time (s)')
ylabel('HRF')
set(gcf,'Color','White')
set(gca,'fontsize',font_size)
title('HRF')
set(findall(gcf,'type','text'),'fontSize',font_size)


% Generate model of button presses
% Chose random times of button press
for meh = [100:101,200:201,300:301,400:401,500:501,600:601,700:701] %Random times of a button press
    s(meh) = 1;
end

Button_press_times = [100,200,300,400,500,600,700]*dt;

%% Try using Wiener Deconvolution

% Need to make them the same length
newlength = length(hrf)+length(s)-1;
hrf_pad = [hrf zeros(1,newlength-length(hrf))]; 
s_pad = [s' zeros(1,newlength-length(s'))];

% First to convolution
signal_FFT = ifft(fft(hrf_pad).*fft(s_pad));
std_noise = 0.05; % STD of noise
noise = std_noise*(randn(newlength,1));
signal_noise = signal_FFT + noise';
f = figure;
set(f,'Position',[79 528 1538 420])
plot(sequence_time,signal_noise(1:length(sequence_time)))
title('Signal generated by convolution')
hold on
Y = [-10 10];
ylim([-0.2,0.5])
for n = 1:length(Button_press_times)
    X = [Button_press_times(n), Button_press_times(n)];
    hold on
    plot(X,Y,'r--')
end
xlabel('Time (s)')
ylabel('Signal')

set(gcf,'Color','White')
set(gca,'fontsize',font_size)
set(findall(gcf,'type','text'),'fontSize',font_size)