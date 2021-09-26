%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% EXERCISE 04 %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% 01
%  Read the 'Test_model01.out' file and extract the frequency-wavenumber
%  information (dispersion curve) for the Rayleigh wave fundamental mode.
%  Save the extracted data to a two-column file (e.g., an Excel spreadsheet).
%  Plot the dispersion curve and save it in .fig format.
clear;
clc;

fileID = fopen('Test_model01.out','r');
str = fgets(fileID);
nline = 0;

while str ~= -1
    str = fgets(fileID);
    if strncmp(str,'        Rayleigh modes',22)
        nline = nline + 1;
        freq(nline) = str2num(str(39:48));
        for j=1:3
            str = fgets(fileID);
        end
        wavenum(nline) = str2num(str(4:13));
    end
end
fclose(fileID);

FW = zeros(length(freq),2);
FW(:,1) = freq'; FW(:,2) = wavenum';
writematrix(FW, 'Frequency-Wavenumber.txt','Delimiter','space');

figure(1); plot(wavenum',freq','r-','LineWidth',2);
title('The Dispersion Curve (F-K Domain)','FontSize',16)
xlabel('Wavenumber (K) [rad/m]','FontSize',14)
ylabel('Frequency (F) [Hz]','FontSize',14)
ylim([0 60]); grid on; grid minor;
text(0.5697,25,'Rayleigh Wave Fundamental Mode');
saveas(gcf,'The dispersion curve.fig');
%% 02
%  Read the 'DT0083_ago19-sept20.xlsx' Excel spreadsheet and produce a 2D color plot
%  of the temperature as a function of time (on the x-axis) and depth (on the y-axis).
%  Add labels, a title and a colorbar. Set the colormap to 'jet'.
%  Do you observe a different temperature behaviour at the surface rather than 
%  at greater depths? What could be the reason? 
%  Save your plot in .fig format.
Temp = readmatrix('DT0083_ago19-sept20.xlsx','Sheet',1,'DataRange','E11:AE38480');
Time = readmatrix('DT0083_ago19-sept20.xlsx','Sheet',1,'DataRange','A11:A38480');
Depth = readmatrix('DT0083_ago19-sept20.xlsx','Sheet',1,'DataRange','E9:AE9');

n = find(isnan(Depth));
Depth(n) = []; Temp(:,n) = [];
Time = datenum(datetime(Time,'ConvertFrom','excel'));
Timediff = Time(:) - Time(1);

figure(2); imagesc(Timediff,abs(fliplr(Depth)),flip(Temp'));
%figure(2); imagesc(Time,abs(fliplr(Depth)),flip(Temp'));
title('Temperature Series Measured in a Well','FontSize',16);
xlabel('Time [days (normalization)]','FontSize',14);
ylabel('Depth (BGS) [m]','FontSize',14);
c = colorbar; c.Label.FontSize = 14;
c.Label.String='Temperature [℃]'; colormap('jet');
saveas(gcf,'DT0083_ago19-sept20.fig');

fprintf('Yes, the change of surface temperature is more obvious than that at greater depths.\n');
fprintf('Because the surface is in contact with the air, and the influence of the temperature difference between summer and winter,\nthe surface temperature changes greatly; Because of the geothermal gradient and low heat transfer efficiency, \nthe temperature at greater depths will not change with the temperature difference of different seasons.\nTherefore, the temperature change at greater depths is not obvious.');
