%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% EXERCISE 01 %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% 02
%  Write a script that asks the user to input a matrix and returns a message with its size. 
clear
clc

prompt = 'Please enter a matrix: \n';
x = input(prompt);
size = size(x);

message = ['The size of the matrix is ', num2str(size(1)), '-by-', num2str(size(2)), '.'];
disp(message);
%% 03 
%  Load the A matrix in matrix.mat.
%  Identify all null rows and columns. Create a new matrix without those rows/columns, transpose it and save it in new_matrix.mat.
load matrix.mat;
[Amax, Imax] = max(max(A));
A(:,Imax) = [];
new_A = A';
save new_matrix.mat new_A