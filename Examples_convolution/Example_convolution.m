%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% EXAMPLE CONVOLUTION %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% 01 
%  Given the x and y vectors below, convolve y with the signal [1,-1] and output the result with the same size of y. 
%  Plot both the input vector and the convolved vector as a function of x (use subplot). 
%  What does the convolved function represent (with respect to the input function)? 

clear all

x = 0:100;
y = mexihat(-10,10,101);

filter = [1,-1];
y_filt = conv(y,filter,'same');
figure;
subplot(2,1,1);plot(x,y);
xlabel('x');ylabel('y')
subplot(2,1,2);plot(x,y_filt);
xlabel('x');ylabel('y filtered')



%% 02
%  Read the picture "IM01.jpg". Plot the  matrix as image.
%  Convolve it with a 3-by-3 filter of this type:
%        -1 -1 -1
%        -1  9 -1
%        -1 -1 -1
%  Plot the convolved matrix: what do you observe? Which operation did we perform?

clear all 

% I read the image
RGB = imread('IM01.jpg');
figure;imshow(RGB)

% I filter the data
filter = -1*ones(3);filter(2,2)=9;
RGB_filt = nan(size(RGB));
for i = 1:size(RGB,3)
    RGB_filt(:,:,i) = conv2(RGB(:,:,i),filter,'same');
end

figure;imshow(uint8(RGB_filt))


%% 03
%  Load the seismic.mat file containing a seismic trace and its sampling interval. 
%  Plot the seismic trace and its amplitude and phase spectrum (use the "compute_spectra" function).
%  Apply a highpass filter at f = 15 Hz with a steepness of 0.6. Plot the filtered trace and its spectrum.
%  Change the steepness value to 0.95 and plot the again the filtered trace and its spectrum.
%  Can you describe and explain the effects of the two designed filters?

clear all

load seismic.mat
time = 0:SI:SI*(length(seismic_trace)-1);
figure;plot(time,seismic_trace)
xlabel('Time [s]')
ylabel('Amplitude')
title('Raw trace')
compute_spectra(seismic_trace,SI,2^nextpow2(length(seismic_trace)))

f_cut = 15;
seismic_trace_high = highpass(seismic_trace,f_cut,1/SI,'Steepness',0.6);
figure;plot(time,seismic_trace_high)
xlabel('Time [s]')
ylabel('Amplitude')
title('Filtered trace - Steepness = 0.6')
NFFT = 2^nextpow2(length(seismic_trace_high));
compute_spectra(seismic_trace_high,SI,NFFT)

seismic_trace_high2 = highpass(seismic_trace,f_cut,1/SI,'Steepness',0.95);
figure;plot(time,seismic_trace_high2)
xlabel('Time [s]')
ylabel('Amplitude')
title('Filtered trace - Steepness = 0.95')
compute_spectra(seismic_trace_high2,SI,NFFT)




