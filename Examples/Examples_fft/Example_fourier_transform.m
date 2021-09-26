%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% EXAMPLE FFT %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 01
%  Generate a signal spanning from -1 s to 1 s, with a 0.2 s box function centered at zero. Sample the signal with SI = 0.01 s.
%  Plot the amplitude and phase spectra (use the "compute_spectra" function).
%  Which kind of function do you obtain for the amplitude spectrum?
%  Shift the impulse in time by +0.2 s. Plot amplitude and phase spectra and compare them to the previous spectra.
%  Which property of the Fourier transform are we observing?

SI = 0.01;  
t = -1:SI:1;
w = 0.2;
y = rectpuls(t,w);
figure;plot(t,y);
xlabel('Time [s]')
ylabel('Amplitude')
compute_spectra(y,SI,2^nextpow2(length(y)));

y_shift = rectpuls(t-0.2,w);
figure;plot(t,y_shift)
xlabel('Time [s]')
ylabel('Amplitude')
compute_spectra(y_shift,SI,2^nextpow2(length(y_shift)));


%% 02
%  Generate a sawtooth signal with frequency f = 20 Hz and length T = 1 s. Sample the signal at 1 kHz and plot it.
%  Considering this is a periodic function, which characteristic should the amplitude spectrum have?
%  Verify your answer by computing and plotting the amplitude and phase spectra (use the function from exercise 02).

fs=1000;
t=0:1/fs:100;
y=sawtooth(2*pi*20*t);
figure;plot(t,y)
xlabel('Time [s]')
ylabel('Amplitude')
compute_spectra(y,1/fs,2^nextpow2(length(y)));


%% 03
%  Load the seismic shot gather in the shot_gather.mat file: TIME is the time vector,
%  OFFSET is the vector containing the source-receiver distances of all traces and TRACES is the data vector.
%  Plot the seismogram in gray scale, adjust the limits of the colorscale, add labels, etc.
%  Select the trace corresponding with an offset of about 100 m and plot it. Use the "compute_spectra" function
%  to plot the amplitude and phase spectra of that trace. Which is the frequency content (range) of your trace?
%  Use the "compute_fk_spectra" function to plot the f-k spectrum of the whole seismogram.
%  Now select only the first 100 traces and compute the f-k spectrum again.
%  What do you observe? How is this spectrum different from the previous one?
%  Now select 1 trace every 10 and compute the f-k spectrum again. What do you observe?

load shot_gather.mat

figure;imagesc(OFFSET,TIME,TRACES);colormap('gray')
colorbar
xlabel('Offset [m]')
ylabel('Time [s]')
caxis([-100 100])

[~,I] = min(abs(OFFSET-100));
trace = TRACES(:,I);
figure;plot(TIME,trace);
xlabel('Time [s]')
ylabel('Amplitude')

SI = mean(diff(TIME));
NFFT = length(TIME);
compute_spectra(trace,SI,NFFT);
% Higher amplitudes are observed between 3 Hz and 15 Hz. This is the frequency range of surface waves.

DX = mean(diff(OFFSET));
compute_fk_spectra(TRACES,DX,SI,1,15)

figure;imagesc(OFFSET(1:100),TIME,TRACES(:,1:100));colormap('gray')
colorbar
xlabel('Offset [m]')
ylabel('Time [s]')
xlim([0 OFFSET(end)]);caxis([-100 100])
compute_fk_spectra(TRACES(:,1:100),DX,SI,1,15)
% In this case the spectral resolution decreases.

figure;imagesc(OFFSET(1:10:end),TIME,TRACES(:,1:10:end));colormap('gray')
colorbar
xlabel('Offset [m]')
ylabel('Time [s]')
xlim([0 OFFSET(end)]);caxis([-100 100])
compute_fk_spectra(TRACES(:,1:10:end),10*DX,SI,1,15)
% In this case I reduce the Nyquist wavenumber, thus I observe spatial aliasing.


