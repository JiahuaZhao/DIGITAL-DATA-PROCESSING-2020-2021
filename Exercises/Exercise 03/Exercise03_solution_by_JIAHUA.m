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
clear
clc

load('temperature_24h.mat');
figure(1); plot(time_vec,T,'-r.');
title('A 24-h temperature time series','FontSize',16)
xlabel('Time [10s]','FontSize',14)
ylabel('Temperature [Celsius Degree]','FontSize',14)
ylim([0 30]); grid on; grid minor;

figure(2); histogram(T,min(T):max(T));

Mean = mean(T); Median = median(T); Mode = mode(T);
message1 = ['The mean, median and mode of above distribution are ',num2str(Mean),', ',num2str(Median), ...
    ' and ',num2str(Mode),' respectively.'];
disp(message1);
disp('This is not a normal distribution, because the histogram does not show symmetry, and the mean, median and mode are different from each other.');

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
load('glacier.mat');
figure(3); 
plot(t,z,'-bo'); 
title('Vertical Position - Skagway Glacier','Original Data', ...
    'Color','blue','FontSize',16,'FontAngle','italic'); 
xlabel('Time [days]','FontSize',14); ylabel('Vertical Ground Movement [mm]','FontSize',14);
grid on; grid minor;

z_detrend = detrend(z,'SamplePoints',t); z_detrend_mu = mean(z_detrend); z_detrend_sigma = std(z_detrend);
figure(4); plot(t,z_detrend,'-bo');title('Vertical Position - Skagway Glacier','Detrended', ...
    'Color','blue','FontSize',16,'FontAngle','italic'); grid on; grid minor; 
xlabel('Time [days]','FontSize',14); ylabel('Vertical Ground Movement [mm]','FontSize',14);
hold on; plot(t,ones(size(t))*z_detrend_mu,'m','LineWidth',2);
hold on; plot(t,ones(size(t))*z_detrend_mu+3*z_detrend_sigma,'--k','LineWidth',2);
hold on; plot(t,ones(size(t))*z_detrend_mu-3*z_detrend_sigma,'--r','LineWidth',2);
legend('Original Data','mu','mu + 3*sigma','mu - 3*sigma','Location','southwest','NumColumns',2);

Iout = find(isoutlier(z_detrend,'mean','ThresholdFactor',3)==1); z(Iout) = []; t(Iout) = [];

m = polyfit(t,z,1); y_model = polyval(m,t);
figure(5); plot(t,z,'-bo'); hold on; plot(t,y_model,'-r','LineWidth',2); 
title('Vertical Position - Skagway Glacier','Removed Outliers', ...
    'Color','blue','FontSize',16,'FontAngle','italic'); grid on; grid minor;
xlabel('Time [days]','FontSize',14); ylabel('Vertical Ground Movement [mm]','FontSize',14);
legend('Original Data','Linear Regression');
message2 = ['The average lifting rate is ',num2str(m(1)),' per year based on regression (in mm/year).'];
disp(message2);