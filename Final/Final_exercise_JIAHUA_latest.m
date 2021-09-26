%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% FINAL EXERCISE %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% 01
%  Build a continuous signal which is the sum of:
%  - A sine wave with A1 = 101, frequency f1 = 50 Hz and phase Phi1 = -pi/3 rad;
%  - A cosine wave with A2 = 56, frequency f2 = 60 Hz and phase Phi2 = 0 rad;
%  - A sine wave with A3 = 98, frequency f3 = 125 Hz, and phase Phi3 = pi.
%
%  CASE 1: Sample your signal with a sampling interval of SI = 5 ms and a total length of 1 s.
%  Plot the continuous signal and the sampled signal on the same figure to compare them (use subplot).
%  Plot the amplitude spectrum using the "compute_spectra" function.
%  What do you observe? How do you explain it? Discuss your conclusions.
%
%  CASE 2: Sample your signal with a sampling interval of SI = 1 ms and a total length of 0.1 s.
%  Plot the continuous signal and the sampled signal on the same figure to compare them (use subplot).
%  Plot the amplitude spectrum using the "compute_spectra" function.
%  What do you observe in this case? How do you explain it? Discuss your conclusions.
%
%  Which is the minimum required bit-resolution given the characteristic of your signal and supposing
%  that the full scale is FS = 120? Choose a value among 8,10,12,14,16,18,20,22,24.
clear; clc;

A1 = 101; f1 = 50; Phi1 = -pi/3;
A2 = 56; f2 = 60; Phi2 = 0;
A3 = 98; f3 = 125; Phi3 = pi;

% CASE 1
SI1 = 5e-3; T1 = 1; t1 = 0:SI1:T1;
CASE1 =  CASE(A1,f1,Phi1,A2,f2,Phi2,A3,f3,Phi3,SI1,T1,t1);
% I can observe that there is a big gap between the sampled signal and the 
% original signal, and there are three frequency peaks in amplitude 
% specturm. The position of two of peaks are closed to the right one (f1 = 
% 50 Hz and f2 = 60 Hz), but the third peak is only closed to 75 Hz (wrong 
% one, f3 = 125 Hz). This shows that the third frequency peak has aliasing 
% effect. In fact, because the sampling frequency fs = 1/SI = 200 Hz, 
% the maximum frequency of the signal fmax = f3 = 125 Hz, fs < 2*fmax. 
% According to Nyquist-Shannon sampling theorem, the sampling frequency fs 
% must be greater than or equal to twice the maximum frequency fmax of 
% signal, otherwise the signal will be aliased. Therefore, aliased 
% frequency f3_alias in the amplitude spectrum are mirrored with respect to 
% the Nyquist frequency fNY = fs/2 = 100 Hz (f3_alias = fs - f3). For the 
% another frequency peaks, because f1 & f2 < fNY, they do not be aliased.

% CASE 2
SI2 = 1e-3; T2 = 0.1; t2 = 0:SI2:T2;
CASE2 = CASE(A1,f1,Phi1,A2,f2,Phi2,A3,f3,Phi3,SI2,T2,t2);
% I can observe that the sampled signal is close to the original signal,
% which shows that the aliasing effect has disappeared. In details, the
% sampling frequency fs = 1/SI = 1000 Hz, and fNY = fs/2 = 500 Hz, f1 & f2
% & f3 < fNY, hence the singal can be sampled correctly. However,the three 
% frequency peaks are not obvious (not narrower) in amplitude specturm, 
% even if they are closed to the right frequencies (In fact, they are 
% further away from the right one, the peak of f3 even reached 130 Hz). 
% That is because of taking a shorter time window to sample in the time 
% domain, thus the resolution in the frequency domain decreases, which 
% results the distortion of the signal. In conclusion, if we want to sample 
% the signal reliably and correctly, we should not only ensure that the 
% sampling frequency conforms to Nyquist-Shannon sampling theorem, but also 
% ensure that the sampling time window is long enough in the time domain.

% Bit-resolution
% As we can see from the above cases, if we want to sample correctly, 
% we need to ensure that the sampling rate and the total sampling time 
% window are the appropriate values.So before we solve the bit-resolution, 
% we can reconstruct the new sampling rate and new sampling time window, 
% here we take SI = 1 ms and a total length of 1 s.
SI3 = 1e-3; T3 = 1; t3 = 0:SI3:T3;
CASE3 = CASE(A1,f1,Phi1,A2,f2,Phi2,A3,f3,Phi3,SI3,T3,t3);
% We can get the more clear, complete and correct sampled signal, then we
% can think about bit-resolution.
FS = 120; Amax = (max(abs(CASE3))); Amin = min(abs(CASE3)); 
% The min (max) amplitude is the smallest (largest) with respect to y = 0, 
% so we need to take the absolute value of the signal.
% Note that here we need to compare the value of FS and Amax, and we can 
% see that Amax (254.0051) is higher than FS (120). When the amplitude to 
% be recorded is higher than the full scale (FS), the signal is saturated 
% (clipping), and clipped amplitudes cannot be recovered. Therefore, we 
% need to suppress the signal as a whole before the signal passes through 
% the A/D converter, as follows:
reCASE3 = CASE3.*0.472; reAmax = (max(abs(reCASE3))); reAmin = min(abs(reCASE3)); 
% In order to prevent signal saturation, the expected maximum amplitudes 
% also can be modified according to the fixed full scale. When we compress 
% the signal, the Amax of new signal is 119.8904 that very close to FS
% (120) (of course, for simplicity we can just use CASE3.*0.5, and result 
% is the same), now we can compute bit-resolution. 
Res = log2(reAmax/reAmin) + 3;
n = ceil(Res);

nrf = [8,10,12,14,16,18,20,22,24]; % The reference values of bit-resolution
% To compare and determine which is the minimum required bit-resolution
for i = 1:length(nrf)
    if nrf(i) - n >= 0
        nmin = nrf(i);
        break;
    end
end
fprintf('The minimum required bit-resolution is %d. \n',nmin);
fprintf('That means we need at least a %d bit A/D converter. \n',nmin);
%% 02
%  In this exercise you will analyse a GPS dataset acquired by a station near Helheim Glacier, in Greenland.
%  In this case you will focus your attention on the seasonal variations instead of the general trend.
%  NB:  These are daily measures, therefore you will work with VERY LOW frequencies, don't worry about it!
%  NB2: You can work with datetime vectors EXACTLY as if they were numeric vectors (example: if "t" is your time vector
%       in datetime format, SI = t(2)- t(1)).
%
%  1) Load your data from the Excel file "3.3_glaciers-activity-HEL2.xlsx".
%     Extract the time vector from column A (remember to apply a conversion from Excel format to datetime format) and the vertical
%     displacement vector from column K. Plot your time series, add labels to the axes, a title, etc.
%     Take some time to analyse the dataset. Is this data regularly sampled? Which is the sampling interval?
%     Is there any trend and/or periodicity in the data?
%
%  2) Do you observe any clear outlier? Prove it by using an outlier detection threshold of 4*sigma (sigma = standard deviation).
%
%  3) Apply all the necessary processing steps to retrieve a clean (no outliers, if any), detrended and
%     regularly-sampled (constant sampling interval, no holes in the data) dataset. Plot the processed time series.
%
%  4) Use the compute_spectra function to display the amplitude spectrum of your processed dataset
%     (REMEMBER TO EXPRESS THE SAMPLING INTERVAL IN SECONDS, AS REQUIRED BY THE FUNCTION!).
%     You should observe a peak in the very low frequencies: which is its frequency?
%     What is it linked to? Prove it numerically.
%
%  5) Apply a smoothing to your processed time series by using a moving average (use a window length of 15 days).
%    For the moving average you can either use convolution, as in EXERCISE06, or the movmean function
%    - type "help movmean" to display its documentation). Plot the smoothed time-series.
%    Compute and display its amplitude spectrum: which is the effect of the moving average in the frequency domain?
clear; clc;

% 1)
time = readmatrix('3.3_glaciers-activity-HEL2.xlsx','Sheet','HEL2 GPS','DataRange','A13:A3742');
vdis = readmatrix('3.3_glaciers-activity-HEL2.xlsx','Sheet','HEL2 GPS','DataRange','K13:K3742');
SI = time(2) - time(1); % day
dtime = datetime(time,'ConvertFrom','excel');

Plotting(time,dtime,vdis,1);
% From the Excel file and figure, this data is basically regularly sampled, 
% and the sampling interval SI is 1 day (or 24 hours in 'datatime'). 
% However, from the details, this data exists a gap between 2013-05-15 and 
% 2013-08-06, so it is not a perfect regular sampling. From the whole 
% recording period, the data shows a linear (increasing) trend; from a 
% period of time window, the data shows a certain periodic change (like 
% cycling or small regular oscillations).

% 2)
findout = isoutlier(vdis,'mean','ThresholdFactor',4);
outid = find(findout);
if size(outid,1) == 0
    fprintf('There is %d clear outlier.\n', size(outid,1));
else
    fprintf('There are %d clear outliers.\n', size(outid,1));
end

% 3)
Time = (min(time):SI:max(time))'; % Regularly-sampled
Dtime = (min(dtime):SI:max(dtime))';

vdis_fillout = filloutliers(vdis,'linear','mean','ThresholdFactor',4); % If any, our case has no outliers

vdis_lin = interp1q(time,vdis_fillout,Time); % Linear interpolation
Plotting(Time,Dtime,vdis_lin,2);

vdis_lin_detrended = detrend(vdis_lin,'SamplePoints',Dtime);
Plotting(Time,Dtime,vdis_lin_detrended,3);

% 4)
NFFT1 = 2^nextpow2(length(vdis_lin_detrended));
[amp1,phase1,freq1] = compute_spectra(vdis_lin_detrended,SI*86400,NFFT1);
[m1,idx1] = max(amp1); lfreq1 = freq1(idx1); lt1 = (1 / lfreq1) / 86400;
fprintf('The main low frequency is %d Hz, the corresponding period is %d days. \n', lfreq1, round(lt1));
% In fact we can observe three local maxima amp. in the amplitude spectrum, 
% of which the largest (and global maxima) amp. represents the frequency of
% 3.250350e-08 Hz (the main frequency component of data), and it represents 
% about 356 days numerically in the time domain. This actually represents the 
% periodic change of temperature throughout a year (the seasonal cycle), we 
% can also easily get this rule from figure 3: in summer, the temperature is 
% high and the ice sheet is thin, so the relative vertical position is less 
% than 0 mm; In winter, the temperature is low and the ice sheet is thick, so the 
% relative vertical position is greater than 0 mm. The other local maximum 
% amp. frequency is 6.35938e-08 Hz (about 182 days), which represents the period 
% change of temperature for half a year (like summer - winter). What 
% interests me most is actually the third frequency component: 7.06598e-09 
% Hz (about 4.5 years), I am not sure what this cycle is related to at present. 
% Maybe it is small-scale climatic oscillation, which is worthy of further 
% study. In short, the vertical displacement of the ice sheet varies with 
% the main period of quasi one year and the sub periods of quasi 4.5 years 
% and quasi half a year.

% 5)
w = 15; W = w * SI;
vdis_lin_detrended_movmean = movmean(vdis_lin_detrended,W);

Plotting(Time,Dtime,vdis_lin_detrended_movmean,4);
NFFT2 = 2^nextpow2(length(vdis_lin_detrended_movmean));
[amp2,phase2,freq2] = compute_spectra(vdis_lin_detrended_movmean,SI*86400,NFFT2);
[m2,idx2] = max(amp2); lfreq2 = freq2(idx2); lt2 = (1 / lfreq2) / 86400;
fprintf('The main low frequency is %d Hz, the corresponding period is %d days (movmean). \n', lfreq2, round(lt2));

% Convolution
fliter = 1/15 * ones(1,15);
vdis_lin_detrended_conv = conv(vdis_lin_detrended,fliter,'same');

Plotting(Time,Dtime,vdis_lin_detrended_conv,5);
NFFT3 = 2^nextpow2(length(vdis_lin_detrended_conv));
[amp3,phase3,freq3] = compute_spectra(vdis_lin_detrended_conv,SI*86400,NFFT3);
[m3,idx3] = max(amp3); lfreq3 = freq3(idx3); lt3 = (1 / lfreq3) / 86400;
fprintf('The main low frequency is %d Hz, the corresponding period is %d days (convolution). \n', lfreq3, round(lt3));
% The moving average means to take the average value of a sample point p and 
% k (the length of moving time windows) adjacent points centered on the point p 
% in the signal. In the frequency domain, the moving average is essentially 
% a low-pass filter, which purpose is to filter out the high-frequency 
% disturbance and retain the useful low-frequency component in time series.