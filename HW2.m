clear all; close all; clc

load handel;
v = y'/2;
L=length(v)/Fs;
n=length(v)-1; %n becomes and even number
t2=linspace(0,L,n+1); t=t2(1:n);
v=v(1:n);%throwing away the last film
k=(2*pi/L)*[0:n/2-1 -n/2:-1]; ks=fftshift(k);
figure(1),plot(t,v);%original frequency picture
xlabel('Time [sec]'); ylabel(       'Amplitude');
title('Signal of Interest, v(n)');
%% filter
figure(2)
spec=[];%start creating spectrogram
tslide=0:0.1:9;%filter different area by time
for j=1:length(tslide)
    g=heaviside(t-tslide(j)) - heaviside(t-tslide(j)-1); % Gabor
    subplot(3,1,1)
    plot(t,v,'k',t,g,'r','Linewidth',[2]);%frequency and filter
    vf=g.*v;
    vft=fft(vf);
    spec=[spec; abs(fftshift(vft))];%adding filter to spectrogram
    subplot(3,1,2)
    plot(t,vf);%filtered frequency
    subplot(3,1,3)
    plot(ks,abs(fftshift(vft))/max(abs(vft)),'k');%frequency range
    drawnow
end
%% spectrogram
figure(3)
pcolor(tslide,ks,abs(spec).'), shading interp
colormap(hot);

    
    
    


