%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% EXERCISE 01 %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% 04
%  Write a function that converts temperatures from Farenheit to Celsius.
%  Write a script that reads the temperature_F.mat file, containing a series of temperatures
%  in Farenheit, and converts it to Celsius using your function.
clear
clc

load temperature_F.mat;
Temp_F = Temp;
Temp_C = F2C(Temp_F);