clear; close all; clc

% figure(1)
% [y, Fs] = audioread('GNR.m4a');
% tr_gnr = length(y)/Fs; % record time in seconds
% plot((1:length(y))/Fs,y);
% xlabel('Time [sec]'); ylabel('Amplitude');
% title('Sweet Child O'' Mine');
% p8 = audioplayer(y,Fs); playblocking(p8);



% Guitar part for GNR -----------------------------------------------------
% Define domain
% [y, Fs] = audioread('GNR.m4a');
% tr_gnr = length(y)/Fs; % record time in seconds
% v = y';
% n = length(v);
% t2 = linspace(0, tr_gnr, n+1);
% t = t2(1:n);
% k = (2*pi/tr_gnr)*[0:n/2-1 -n/2:-1];
% ks = fftshift(k);
% 
% a = 1500;
% d_tau = 0.2;
% 
% tspan = 0:d_tau:tr_gnr;
% spect_guitar = zeros(length(tspan), n);
% guitar_note = zeros(1, length(tspan));
% 
% 
% for i = 1:length(tspan)
%     f = exp(-a*(t - tspan(i)).^2);
%     window = f .* v;
%     window_f = fft(window);
%     [M, I] = max(window_f);  % find the maximum frequency
%     guitar_note(1, i) = abs(k(I))/(2*pi);
%     spect_guitar(i, :) = fftshift(abs(window_f));
% end
% 
% figure(1)
% pcolor(tspan, (ks/(2*pi)), spect_guitar.'),
% shading interp
% ylim([0 1000])
% colormap hot
% title("GNR")
% xlabel('Time in sec'), ylabel('Frequency in Hz')
% 
% 
% figure(2)
% plot(tspan, guitar_note, 'o', 'MarkerFaceColor', 'b');
% yticks([277.18,369.99, 415.30, 554.37, 698.46, 739.99]); 
% yticklabels({'C#4','F#4','G#4', 'C#5', 'F5', 'F#5'});
% ylim([200 900])
% title('GNR music score for guitar');
% xlabel('Time (s)');
% ylabel("Note");

% Bass part for Floyd -----------------------------------------------------
% Define domain
[y, Fs] = audioread('Floyd.m4a');
tr_floyd = length(y)/Fs; % record time in seconds
v = y';
n = length(v);
t2 = linspace(0, tr_floyd, n+1);
t = t2(1:n);
k = (2*pi/tr_floyd)*[0:(n-1)/2 -(n-1)/2:-1];
ks = fftshift(k);

% a = 1500;
% d_tau = 0.3;
% 
% tspan = 0:d_tau:tr_floyd;

% For smaller range spectrogram
a = 200;
d_tau = 0.5;
tspan = 0:d_tau:23;

spect_bass = zeros(length(tspan), n);
bass_note = zeros(1, length(tspan));

for i = 1:length(tspan)
    f = exp(-a*(t - tspan(i)).^2);
    window = f .* v;
    window_f = fft(window);
    [M, I] = max(window_f);  % find the maximum frequency
    bass_note(1, i) = abs(k(I))/(2*pi);
    spect_bass(i, :) = fftshift(abs(window_f));
end

figure(3)
pcolor(tspan, (ks/(2*pi)), spect_bass.'),
shading interp
ylim([0 250])
colormap hot
title("Floyd")
xlabel('Time in sec'), ylabel('Frequency in Hz')

% figure(4)
% plot(tspan, bass_note, 'o', 'MarkerFaceColor', 'b');
% yticks([77.782, 97.999, 110.00, 123.47, 164.81, 185.00, 246.94]); 
% yticklabels({'D#2','G2','A2', 'B2', 'E3', 'F#3', 'B3'});
% ylim([0 250])
% title('Floyd music score for bass');
% xlabel('Time (s)');
% ylabel("Note");
% 
% figure(5)
% plot(tspan, bass_note, 'o', 'MarkerFaceColor', 'b');
% yticks([261.63, 329.63, 369.99, 493.88, 587.33, 659.26, 739.99, 783.99]); 
% yticklabels({'C4','E4','F#4', 'B4', 'D5', 'E5', 'F#5', 'G5'});
% ylim([250 800])
% title('Floyd music score for guitar');
% xlabel('Time (s)');
% ylabel("Note");
% 

