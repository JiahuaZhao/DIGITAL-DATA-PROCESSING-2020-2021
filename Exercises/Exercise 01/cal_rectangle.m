% This function is computes the area, perimeter and diagonal of a rectangle
% Input: the sides of a rectangle
% Onput: the area, perimeter and diagonal of a rectangle

function [area_f,perimeter_f,diagonal_f] = cal_rectangle(a_f,b_f)
    area_f = a_f * b_f;
    perimeter_f = 2 * (a_f + b_f);
    diagonal_f = sqrt(a_f^2 + b_f^2);
end