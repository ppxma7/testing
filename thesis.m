%snippets of code for thesis figures

%% make a spiral
t = linspace(0, 20*pi, 1000);
x = t.*cos(t);
y = t.*sin(t);
z = t/3;
plot3(x,y,z, 'r')

%% damped sine wave
x = 0:0.01:6*pi;
y = 1.*exp(-0.2*x).*cos(2*pi*x); % damped sine wave
plot(x,y)
hold on
plot(x,exp(-0.2*x),'--r') % add exp line

%% gradient echo


%% sinc wave
x = -50:0.01:50;
plot(x, sinc(x));
