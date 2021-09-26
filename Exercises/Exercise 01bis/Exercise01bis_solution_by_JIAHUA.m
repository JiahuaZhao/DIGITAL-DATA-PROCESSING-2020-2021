%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% EXERCISE 01bis %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% 01 
%  Write a function that computes the distance between two points of a plane whose coordinates are P1=(x1,y1) and P2=(x2,y2).
%  Load the COORD matrix in coordinates.mat, containing a list of UTM East (first column) and North (second column) 
%  coordinates for ten different sites (the elevation is assumed = 0 for all points).
%  Use your function to compute the distance between the 1st and 5th point and between the 3rd and 10th point. 
clear
clc
% the 1st and 5th points
load coordinates.mat;
x1 = COORD(1,1);
x5 = COORD(5,1);
y1 = COORD(1,2);
y5 = COORD(5,2);
d_1_5 = discompu(x1,x5,y1,y5);
% the 3rd and 10th points
x3 = COORD(3,1);
x10 = COORD(10,1);
y3 = COORD(3,2);
y10 = COORD(10,2);
d_3_10 = discompu(x3,x10,y3,y10);
%% 02
%  Load the A matrix in matrix.mat. 
%  Write a script that asks the user a number of row (i) and a number of column (j) and returns a message with the content of A(i,j).
%  Use the "input" and "disp" functions. 
load matrix.mat;

i = input('Please enter a number of row (i): \n');
j = input('and a number of column (j): \n');
message = ['The content of A(',num2str(i),',',num2str(j),') is ',num2str(A(i,j)),'.'];
disp(message);
%% 03 
%  Create a 10-by-10 matrix filled with random values. Remove all odd columns.
m = randi([1 100],10,10);
m_orig = m;
disp(m_orig);
m(:,[1 3 5 7 9]) = [];
disp(m);