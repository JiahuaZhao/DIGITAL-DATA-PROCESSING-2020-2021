%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% EXERCISE 05 %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% 01 
%  Create a continuous wave which is the sum of a sine wave with amplitude A1 = 5 and frequency f1 = 0.25 Hz and a cosine wave 
%  with amplitude A2 = 10 and frequency f2 = 0.6 Hz. Define it between 0 and 10 s.
%  Sample your wave with a sampling interval SI = 0.1 s. Plot both the continuous wave and the sampled wave on the same figure (use subplot).
%  Use the function "compute_spectra" provided to compute and plot the single-sided amplitude and phase spectra of the sampled wave.
%  Now extend the length of the wave to 100 s and sample it (SI = 0.1 s). Compute and plot the amplitude and phase spectra.
%  What do you observe in terms of both shape and position of the amplitude peaks in the frequency domain? Why?
clear all; clc;

SI = 0.1;
t = 0:SI:10;
A1 = 5; f1 = 0.25;
A2 = 10; f2 = 0.6;
y1 = A1*sin(2*pi*f1*t);
y2 = A2*cos(2*pi*f2*t);
y = y1 + y2;

figure(1)
subplot(2,1,1);
fplot(@(t) A1*sin(2*pi*f1*t)+A2*cos(2*pi*f2*t),[0 10]);
ylim([-20 20]);
subplot(2,1,2);
plot(t,y,'-.');
ylim([-20 20]);

compute_spectra(y,SI,2^nextpow2(length(y)));

t_e = 0:SI:100;
y1_e = A1*sin(2*pi*f1*t_e);
y2_e = A2*cos(2*pi*f2*t_e);
y_e = y1_e + y2_e;

compute_spectra(y_e,SI,2^nextpow2(length(y_e)));

% The peaks shape is sharp and the position is close to 0.25 Hz and 0.6 Hz respectively. 
% Because the original signal is composed of a sine wave with frequency = 0.25 Hz and 
% a cosine signal with frequency = 0.6 Hz, when the signal is processed by Fourier transform, 
% there will be two amplitude peaks in the frequency domain.
%% 02 
%  Sample the 100 s periodic wave of the previous exercise with SI = 1 s. 
%  Plot the continuous signal and the new sampled signal on the same figure (use subplot).
%  Plot the single-sided amplitude and phase spectra.
%  What do you observe? How do you explain it?
SI_2 = 1;
t_2 = 0:SI_2:100;
y1_2 = A1*sin(2*pi*f1*t_2);
y2_2 = A2*cos(2*pi*f2*t_2);
y_2 = y1_2 + y2_2;

figure(4)
subplot(2,1,1);
fplot(@(t) A1*sin(2*pi*f1*t)+A2*cos(2*pi*f2*t),[0 100]);
ylim([-20 20]);
subplot(2,1,2);
plot(t_2,y_2,'-.');
ylim([-20 20]);

compute_spectra(y_2,SI_2,2^nextpow2(length(y_2)));

% I found that the position of the maximum amplitude peak in the frequency domain changed (0.6 Hz to 0.4 Hz).
% According to Nyquist-Shannon sampling theorem, the sampling frequency fs must be greater than or equal to
% twice the maximum frequency fmax of signal, otherwise the signal will be aliased. In exercise02, because
% the sampling frequency fs = 1 Hz, the maximum frequency of the signal
% fmax = 0.6 Hz, fs < 2*fmax. Therefore, aliased frequencies in the amplitude spectrum are mirrored 
% with respect to the Nyquist frequency fNY = fs/2 = 0.5 Hz. That's why the
% maximum amplitude peak changed from 0.6 Hz to 0.4 Hz in the frequency
% domain. For the second amplitude peak fmax2 = 0.25 Hz, because fs > 2*fmax2, it does not change.