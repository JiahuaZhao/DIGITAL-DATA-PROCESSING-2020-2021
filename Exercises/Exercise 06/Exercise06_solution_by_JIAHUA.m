%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% EXERCISE 06 %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% 01
%  Build a discrete signal (sampling interval SI = 100 ms, total length T = 10 s) which is the sum of two sine waves with the following characteristics:
%  - A1 = 10, frequency f1 = 0.2 Hz, and phase Phi1 = 0;
%  - A2 = 5, frequency f2 = 2 Hz, and phase Phi2 = -pi/2.
%  Convolve it with a filter whose impulse response is [1/5,1/5,1/5,1/5,1/5] and output the result with the same shape of the input vector. 
%  Plot both the input function and the convolved function on the same figure (use subplot). 
%  Which mathematical operation does this filter apply? Which is the effect on your signal? 
%  To support your conclusions, compute the amplitude spectrum of both the input and the filtered vectors and compare them 
%  (use the compute_spectra function).
clear; clc;

T = 10; SI = 0.1; t = 0:SI:T;
A1 = 10; f1 = 0.2; phi1 = 0;
A2 = 5; f2 = 2; phi2 = -pi / 2;
y1 = A1 * sin(2*pi*f1*t + phi1);
y2 = A2 * sin(2*pi*f2*t + phi2);
y = y1 + y2;

fliter = [1/5,1/5,1/5,1/5,1/5];
y_conv = conv(y,fliter,'same');

[amplitude,frequency] = compute_spectra_new(y,SI,2^nextpow2(length(y)));
[amplitude_conv,frequency_conv] = compute_spectra_new(y_conv,SI,2^nextpow2(length(y_conv)));

figure;
subplot(2,2,1);
plot(t,y,'r'); xlabel('Time [s]'); ylabel('Amplitude');
ylim([-15 15]); title('Original Raw Trace');
subplot(2,2,2);
plot(t,y_conv,'b'); xlabel('Time [s]'); ylabel('Amplitude');
ylim([-15 15]); title('After Convolution');
subplot(2,2,3);
plot(frequency,amplitude); xlabel('Frequency [Hz]'); ylabel('Amplitude');
xlim([0 5]); ylim([0 8]); title('Original Spectrum');
subplot(2,2,4);
plot(frequency_conv,amplitude_conv); xlabel('Frequency [Hz]'); ylabel('Amplitude');
xlim([0 5]); ylim([0 8]); title('After Convolution Spectrum');

% This fliter applies convolution (resampling), which makes the signal curve 
% more 'smooth' (it's like a low-pass filter from the spectra, retains the 
% main frequency). In other words, we can think that this fliter can
% convolute five sample points at the same time (calculate the sum of these 
% points and take the average: 1/5 * (y1 + y2 + y3 + y4 + y5)), which can
% reduce difference between each two points. Therefore, we can see a smooth 
% curve after convolution. In fact, this is a smooth operation of 1D
% signal, which highlights the main part and low-frequency components of 
% the signal, or suppress the noise and high-frequency components, 
% reduce the mutation gradient, so that the signal becomes smooth.

%% 02
%  Read a picture of your choice (you can use "IM01.jpg"). Plot the  matrix as image.
%  Convolve it with a 5-by-5 matrix filled with 1/25.
%  Plot the convolved matrix: what do you observe? Which operation did the filter perform?
%  NB: Note the similarity with the previous exercise.
clear; clc;

img = imread('IM01.jpg');
figure(1);imshow(img);

filter = (1/25) * ones(5);
img_new = uint8(zeros(size(img)));
for i = 1:size(img,3)
    img_new(:,:,i) = conv2(img(:,:,i),filter,'same');
end

figure(2);imshow(img_new);

% I can see a blurry image, the filter blurs the image. In details, this is
% a Blur (Averaging) operation, which is to sum the values of a central
% pixel and its surrounding 8 pixels in the image, calculate the average 
% value of the sum (of these 9 pixels), and then change the value of the
% central pixel to the average value. After convolution (like previous 
% exercise), the 'dfference value' of each pixel in the image is reduced 
% (the central pixel has lost the details), each pixel is more smooth, so 
% each pixel in the image is more 'fuzzy' which we can see in the graphics.

%% 03
%  A seismic impulse is recorded by two stations, ST01 and ST02 (read "stations.mat" with the two traces and the time vector in seconds).
%  The distance between the two stations is 105 m. Plot the two traces with the same scale using subplot.
%  Use cross-correlation to find the travel time of the impulse from ST01 to ST02 and its apparent velocity.
%  Now filter both ST01 and ST02 traces between 10 Hz and 50 Hz (use the bandpass function with a steepness of 0.7).
%  Plot the two filtered traces with the same scale using subplot. Which is the effect of filtering?
clear; clc;

load('stations.mat')
SI = time(2) - time(1);
[amplitude01,frequency01] = compute_spectra_new(ST01,SI,2^nextpow2(length(ST01)));
[amplitude02,frequency02] = compute_spectra_new(ST02,SI,2^nextpow2(length(ST02)));

figure(1);
subplot(2,2,1);
plot(time,ST01,'r'); xlabel('Time [s]'); ylabel('Amplitude');
ylim([-20 20]); title('Original Raw Trace (ST01)');
subplot(2,2,2);
plot(time,ST02,'b'); xlabel('Time [s]'); ylabel('Amplitude');
ylim([-20 20]); title('Original Raw Trace (ST02)');
subplot(2,2,3);
plot(frequency01,amplitude01); xlabel('Frequency [Hz]'); ylabel('Amplitude');
xlim([0 250]); ylim([0 0.4]); title('Original Spectrum (ST01)');
subplot(2,2,4);
plot(frequency02,amplitude02); xlabel('Frequency [Hz]'); ylabel('Amplitude');
xlim([0 250]); ylim([0 0.4]); title('Original Spectrum (ST02)');

D = 105; % The distance between the two stations [m]
% c01_02 = xcorr(ST01,ST02);
c01_02 = xcorr(ST01,ST02,'normalized');
% c01_02 = c01_02 ./ sqrt(sum(ST01(:).^2) * sum(ST02(:).^2));
tp = time; tn = flip(-time); tn(tn==0) = []; tc = [tn,tp]; % Rebuild the x-coordinates (time)
[m,i] = max(c01_02);
travel_time = -tc(i); vapp = D / travel_time; % m/s
fprintf('The travel time of the impulse from ST01 to ST02 is %f s. \nIts apparent velocity is %f m/s. \n',...
    travel_time,vapp);

ST01_band = bandpass(ST01,[10 50],1/SI,'Steepness',0.7);
ST02_band = bandpass(ST02,[10 50],1/SI,'Steepness',0.7);
[amplitude01_band,frequency01_band] = compute_spectra_new(ST01_band,SI,2^nextpow2(length(ST01_band)));
[amplitude02_band,frequency02_band] = compute_spectra_new(ST02_band,SI,2^nextpow2(length(ST02_band)));

figure(2);
subplot(2,2,1);
plot(time,ST01_band,'r'); xlabel('Time [s]'); ylabel('Amplitude');
ylim([-20 20]); title('Bandpass 10 - 50 Hz (ST01)');
subplot(2,2,2);
plot(time,ST02_band,'b'); xlabel('Time [s]'); ylabel('Amplitude');
ylim([-20 20]); title('Bandpass 10 - 50 Hz (ST02)');
subplot(2,2,3);
plot(frequency01_band,amplitude01_band); xlabel('Frequency [Hz]'); ylabel('Amplitude');
xlim([0 250]); ylim([0 0.4]); title('Bandpass Spectrum (ST01)');
subplot(2,2,4);
plot(frequency02_band,amplitude02_band); xlabel('Frequency [Hz]'); ylabel('Amplitude');
xlim([0 250]); ylim([0 0.4]); title('Bandpass Spectrum (ST02)');

figure(3);
plot(tc,c01_02,'b',tc,flip(c01_02),'r'); xlabel('Time [s]'); ylabel('Amplitude');
title('Cross Correlation between ST01 and ST02'); legend('ST01 - ST02','ST02 - ST01');

% The Bandpass filter can suppress the noise effectively and keep the
% seismic impulse (10 Hz - 50 Hz) (we can clearly observe this phenomenon 
% in the spectra).