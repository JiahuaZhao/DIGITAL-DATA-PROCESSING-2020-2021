%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% EXERCISE 01 %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% 01 
% Write a script that computes the area, perimeter and diagonal of a rectangle with sides a = 2 and b = 5.
% Write a function that makes the same computation and run it for a = 2 and b = 5.
% N.B. +, -, *, / and ^ are the symbols for sum, difference, product, division and power. The square root is computed through the sqrt() function. 
clear
clc

a = 2;
b = 5;
area = a * b;
perimeter = 2 * (a + b);
diagonal = sqrt(a^2 + b^2);
% function
[A,P,D] = cal_rectangle(a,b);

if [A,P,D] == [area,perimeter,diagonal]
    disp('Correct!');
end