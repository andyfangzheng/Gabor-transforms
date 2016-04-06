clear all; close all; clc

tr_piano=16; % record time in seconds
y=wavread('music1'); Fs=length(y)/tr_piano;
y=y';
L=length(y)/Fs;
n=length(y);
t2=(1:length(y))/Fs; t=t2(1:n);
k=(1/L)*[0:n/2-1 -n/2:-1]; ks=fftshift(k);
figure(1),plot(t,y);
xlabel('Time [sec]'); ylabel('Amplitude');
title('Mary had a little lamb (piano)'); drawnow
%% filter
figure(2)
spec=[];
tslide=0:0.2:t(end);
for j=1:length(tslide)
    g=exp(-80*(t-tslide(j)).^2);
    subplot(3,1,1)
    plot(t,y,'k',t,g,'r','Linewidth',[2]);
    yf=g.*y;
    yft=fft(yf);
    spec=[spec; abs(fftshift(yft))];
    subplot(3,1,2)
    plot(t,yf);
    subplot(3,1,3)
    plot(ks,abs(fftshift(yft))/max(abs(yft)),'k');
    drawnow
end
%% spectrogram
figure(3)
pcolor(tslide,ks,abs(spec).'), shading interp
set (gca,'Ylim',[0,500],'fontsize',[14]);
colormap(hot);




% p8 = audioplayer(y,Fs); playblocking(p8);


% figure(2)
% tr_rec=14; % record time in seconds
% y=wavread('music2'); Fs=length(y)/tr_rec;
% plot((1:length(y))/Fs,y);
% xlabel('Time [sec]'); ylabel('Amplitude');
% title('Mary had a little lamb (recorder)');
% p8 = audioplayer(y,Fs); playblocking(p8);
