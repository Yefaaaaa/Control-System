%% Prepare the Input
rng default 
Fs = 1;
n = 1:365;
x = cos(2*pi*(1/7)*n) + cos(2*pi*(1/3)*n);
figure
plot(x);
trend = 3*sin(2*pi*(1/1480)*n);
y = x + trend + 0.5*randn(size(n));
figure
plot(y)
% get the dB
[pxx,f ]  = periodogram(y,[],length(y),Fs);
figure
subplot(2,1,1); plot(n,y);
subplot(2,1,2); plot(f,10*log10(pxx))
%% Band Pass filter
% FIR filter
Hd1 = designfilt('bandpassfir',...
                 'StopbandFrequency1',1/60,'PassbandFrequency1',1/40,...
                 'PassbandFrequency2',1/4,'StopbandFrequency2',1/2,...
                 'StopbandAttenuation1',10,'PassbandRipple',1,...
                 'StopbandAttenuation2',10,'DesignMethod','equiripple','SampleRate',Fs);
% IIR filter
Hd2 = designfilt('bandpassiir',...
                 'StopbandFrequency1',1/60,'PassbandFrequency1',1/40,...
                 'PassbandFrequency2',1/4,'StopbandFrequency2',1/2,...
                 'StopbandAttenuation1',10,'PassbandRipple',1,...
                 'StopbandAttenuation2',10,'DesignMethod','butter','SampleRate',Fs);

[phifir, w] = phasez(Hd1,[],1);
[phiiir, w] = phasez(Hd2,[],1);
figure
plot(w,unwrap(phifir),'g',w,unwrap(phiiir),'b')
legend('fir','iir');
%% signal pass filter
yfir = filter(Hd1, y);
yiir = filter(Hd2, y);
[pxx1,f ]  = periodogram(yfir,[],length(yfir),Fs);
[pxx2,f ]  = periodogram(yiir,[],length(yiir),Fs);
figure
plot(f,10*log10(pxx2),'g')
hold on 
plot(f,10*log10(pxx1),'b')
hold off
legend('FIRfilterOutput','IIRfilterOutput')

%% Comparation plot
figure
plot(n(1:200),yfir(1:200),'g');
hold on
plot(n(1:200),yiir(1:200),'b');
hold off
axis([1 120 -2.8 2.8])
legend('FIRfilterOutput','IIRfilterOutput')
figure
plot(yfir,'g')
hold on 
plot(yiir,'b')
hold off






