% This function is converts Farenheit to Celsius
% Based on C = 5 / 9 * (F - 32)
% Input: Temp. of Farenheit
% Onput: Celsius

function Temp_C = F2C(Temp_F)
    Temp_C = 5 / 9 * (Temp_F - 32);
end