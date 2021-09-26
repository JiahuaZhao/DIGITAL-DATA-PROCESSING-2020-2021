%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%  EXAMPLE  %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% 01
%  Read the data in the file '10cm.dat'. 
%  Produce a scatter plot of the resistivity and analyse it. Are data uniformely distributed in space? 
%  Plot the data with 'slice' to analyse some relevant x, y and z resistivity slices. 
%  Where is the main resistivity anomaly? Which shape does it have?

clear all
close all
clc

TAB = readmatrix('10cm.dat');
x = TAB(:,1);
y = TAB(:,2);
z = TAB(:,3);
res = TAB(:,4);

figure;scatter3(x,y,z,5,res,'filled');
xlabel('X [cm]')
ylabel('Y [cm]')
zlabel('Z [cm]')
colorbar

[Xq,Yq,Zq]=meshgrid(min(x):1:max(x),min(y):1:max(y),min(z):1:max(z));
RESq=griddata(x,y,z,res,Xq,Yq,Zq);
figure;slice(Xq,Yq,Zq,RESq,25,0,-50);
xlabel('X [cm]')
ylabel('Y [cm]')
zlabel('Z [cm]')
colorbar



%% 02
%  Read the 'Test_model01.out' file and extract the information about the velocity model 
%  used for the simulation (vp(z), vs(z)). You can find this information under the section "Material properties".
%  Make a plot of both vs and vp as a function of depth (depth is on the vertical axis), add labels and title.
%  Save the extracted information in an Excel spreadsheet (first, second and third columns
%  are z, vp and vs, respectively).

clear all
close all
clc

file_name='Test_model01.out';
    
file_ID = fopen(file_name,'r');
l = 0;  % index for layer
str = fgets(file_ID);
while str~=-1     % as long as str is a string containing a line of my file
    
    str = fgets(file_ID);
    if strncmp(str,'Material Properties',19) 
        for i=1:5
            str=fgets(file_ID);
        end
        while length(str) > 2   
            l = l+1;
            data = str2num(str);
            depth(l) = data(3);
            vs(l) = data(5);
            vp(l) = data(6);
            str = fgets(file_ID);
        end
        break
    end
        
end

fclose(file_ID);

figure;plot(vs,depth,'r',vp,depth,'b');axis ij;
xlabel('Seismic velocity [m/s]')
ylabel('Depth [m]');

writematrix([depth' ,vp', vs'],'velocity_model.xlsx');


