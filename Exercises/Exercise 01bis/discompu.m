% This function is computes the distance between two points of a plane.
% Input: the location (x,y) of two points
% Onput: the distance between two points

function distance = discompu(x1,y1,x2,y2)
    distance = sqrt((x1 - x2)^2 + (y1 - y2)^2);
end