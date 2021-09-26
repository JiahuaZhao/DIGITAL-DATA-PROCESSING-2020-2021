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





