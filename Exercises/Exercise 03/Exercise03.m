%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% EXERCISE 03 %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% 01 
%  Import a 24 h temperature time series from temperature_24h.mat file.
%  Temperatures are in Celsius degrees and are rounded to the closest integer (T vector).
%  Times are in datetime format (time_vec vector).
%  Make a plot of the temperature time series and adjust its appearance (line color, axis labels, title, etc.)
%  Plot a frequency histogram to analyse the statistical distribution of temperatures (set an appropriate number of intervals).
%  Compute the mean, median and mode of the distribution. Is this a normal distribution? Why?






%% 02
%  Load the glacier.mat file: the "z" vector contains the vertical ground movements 
%  recorded by a GPS positioned next to the Skagway glacier (in mm). The "t" vector
%  contains the time of each measure (in days). Plot the data.
%  1)  Detrend the data and compute mean (mu) and standard deviation (sigma). 
%  2)  Plot the lines corresponding to mu, mu+3*sigma and mu-3*sigma over your data.
%  2)  Identify the outliers in the detrended data and remove them from the original data (not detrended).
%  3)  Compute a linear regression over the raw (not detrended) data without outliers. Plot the data and 
%      the fitting line on the same figure to check your regression. Which is the average lifting rate 
%      per year based on your regression (in mm/year)? 


