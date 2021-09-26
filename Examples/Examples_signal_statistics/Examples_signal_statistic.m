%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% EXAMPLE SIGNAL STATISTICS %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% 01
%  Create a linear distribution following the relationship y=ax+b, where a=-0.4 and b=20 and x=0:100.
%  Add uniformely distributed random noise between -10 and 10 and plot the data (use line and markers).
%  Fit the data using a polynome of degree 1. Plot the fitting line over the data points.
%  Compute the R^2 parameter
x = 0:100;
a = -0.4;
b = 20;
y = a * x + b;

noise = (rand(size(x)) - 0.5) * 20;
yn = y + noise;
figure; plot(x,yn,'-b.'); xlabel('x'); ylabel('y');

c = polyfit(x,yn,1);
y_model = polyval(c,x);
hold on; plot(x,y_model,'-r.');

R2 = 1 - sum((yn - y_model).^2) / sum((yn - mean(yn)).^2);

%% 02
%  Import the noise time serie in the 10s_noise_record.mat file, containing a 10 s seismic noise record (noise vector, in m/s^2) and its sampling interval (SI).
%  Build a time vector starting at zero and plot the series.
%  Which kind of processing does this data need? Apply all the necessary operations.
%  Which is the noise level (standard deviation)? Plot the two horizontal lines delimiting the (mean-std, mean+std) interval over your data.
%  Plot the frequency histogram. Does it approximate a normal distribution? 
clear
clc

load('10s_noise_record.mat')
t = 0:SI:SI*(length(noise)-1);
figure(); plot(t,noise,'b'); xlabel('Time [s]'); ylabel('Accelerations [m/s^2]');

noise_detrend = detrend(noise,'SamplePoints',t);
figure; plot(t,noise_detrend,'b');
[noise_claen, Iout] = rmoutliers(noise_detrend,'mean','ThresholdFactor',4);
figure; plot(t(~Iout),noise_claen);

stdev = std(noise_claen);
hold on; plot(t,ones(size(t))*mean(noise_claen),'m');
hold on; plot(t,ones(size(t))*mean(noise_claen)+stdev,'m');
hold on; plot(t,ones(size(t))*mean(noise_claen)-stdev,'m');

figure; hist(noise_claen);