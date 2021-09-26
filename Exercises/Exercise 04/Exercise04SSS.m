%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% EXERCISE 04 %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% 01
%  Read the 'Test_model01.out' file and extract the frequency-wavenumber
%  information (dispersion curve) for the Rayleigh wave fundamental mode.
%  Save the extracted data to a two-column file (e.g., an Excel spreadsheet).
% %  Plot the dispersion curve and save it in .fig format.
% clear all 
% clc
% 
% fileID = fopen('Test_model01.out','r');
% str = fgets(fileID);
% Layern = 0; 
% while str ~= -1
%     str = fgets(fileID);
%     if strncmp(str,'        Rayleigh modes',22) % p1 
%         Layern = Layern + 1;
%         Freq(Layern) = str2num(str(39:48));
%         for i = 1:3
%             str = fgets(fileID);
%         end
%         wavenum(Layern) = str2num(str(4:13)); % p2
%     end
% end
% 
% fclose(fileID);
% figure;plot(wavenum,Freq,'m-')
% title('The Dispersion Curve')
% xlabel('Wavenum [rad/m]')
% ylabel('Frequency [Hz]')
% writematrix([wavenum' ,Freq'],'The Dispersion-curve.xlsx');
% saveas(gcf,'The Dispersion Curve.fig'); % p3

%% 02
%  Read the 'DT0083_ago19-sept20.xlsx' Excel spreadsheet and produce a 2D color plot
%  of the temperature as a function of time (on the x-axis) and depth (on the y-axis).
%  Add labels, a title and a colorbar. Set the colormap to 'jet'.
%  Do you observe a different temperature behaviour at the surface rather than 
%  at greater depths? What could be the reason? 
%  Save your plot in .fig format.


clear all
clc

Table = readmatrix('DT0083_ago19-sept20.xlsx','Sheet',1,'DataRange','A9:A38480');
Depth = Table(1,5:2:31);
Time = Table(3:end,1);
Time2 = datetime(Time,'ConvertFrom','excel');
Temp = Table(3:end,5:2:31);
[Time-1,Depth-1]=meshgrid(Time2,Depth);
figure;s = pcolor(Time-1,Depth-1,Temp');
colorbar;
colormap ('jet')
title('Temperature Changes')
xlabel('Time')
ylabel('Depth [m]')
saveas ('Figure.fig')




