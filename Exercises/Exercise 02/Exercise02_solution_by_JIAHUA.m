%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% EXERCISE 02 %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% 01
%  The maximum amplitude of a signal is 0.4 mV, while its minimum significant
%  oscillation has an amplitude of 0.001 mV. Which is the minimum required 
%  bit resolution for this signal? Which is the corresponding elementary 
%  amplitude interval (dA) in which the Full Scale (FS) is divided (suppose that FS = Amax)? 
clear;
clc;
% Bit resolution and amplitude interval (dA)
Amax = 0.4;
FS = 0.4;
Amin = 0.001;
Bit_V = [2,4,8,16,32];
n =  log2(Amax / Amin) + 3;
for i = 1:length(Bit_V)
   if Bit_V(i) > n
       dA = FS / 2^Bit_V(i); % signed
       p1 = ['01: The minimum required bit resolution for this signal is ',num2str(Bit_V(i)),'-bit.'];
       p2 = [ '01: The corresponding elementary amplitude interval (dA) is ',num2str(dA),'.'];
       disp(p1);
       disp(p2);
       break;
   end
end
%% 02
% Plot a continuous sinusoidal signal with A = 3, f = 3 Hz and Phi = 0. Set x axis between 0 s and 1 s.
% Add labels to both x and y axes.
A_2 = 3;
f_2 = 3;
Phi_2 = 0;
x_2 = 0:0.05:1;
y_2 = A_2*sin(2*pi*f_2*x_2 + Phi_2);

figure(02);
plot(x_2,y_2);
xlabel('Time [s]');
ylabel('Amplitude');
%% 03
%  Sample the sinusoidal signal in exercise 02 with a sampling interval SI = 0.01 s.
%  Plot it over the previous one with a different appearance (use line and markers).
%  Verify the Nyquist-Shannon theorem.
A_3 = 3;
f_3 = 3;
Phi_3 = 0;
SI_3 = 0.01;
x_3 = 0:SI_3:1;
y_3 = A_3*sin(2*pi*f_3*x_3 + Phi_3);

figure(03);
plot(x_3,y_3,'r-*');
xlabel('Time [s]');
ylabel('Amplitude');

% Verify
Fs_3 = 1 / SI_3;
FNY_3 = 0.5 * Fs_3;
%FNY_3 > f_3;
if FNY_3 > f_3
    disp("03: Sampling conforms to Nyquist-Shannon theorem");
else
    disp("03: Sampling doesn't conform to Nyquist-Shannon theorem");
end
%% 04
%  Sample the same sinusoidal signal in exercise 02 with SI = 0.25 s.
%  Plot it over the previous one with a different appearance (use line and markers).
%  Verify the Nyquist-Shannon theorem. Which frequency are you observing?
A_4 = 3;
f_4 = 3;
Phi_4 = 0;
SI_4 = 0.25;
x_4 = 0:SI_4:1;
y_4 = A_4*sin(2*pi*f_4*x_4 + Phi_4);

figure(04);
plot(x_4,y_4,'g-o');
xlabel('Time [s]');
ylabel('Amplitude');

% Verify
Fs_4 = 1 / SI_4;
FNY_4 = 0.5 * Fs_4;
%FNY_4 > f_4;
if FNY_4 > f_4
    disp("04: Sampling conforms to Nyquist-Shannon theorem");
else
    F_mirrored = abs(FNY_4 - f_4);
    disp("04: Sampling doesn't conform to Nyquist-Shannon theorem");
    p3 = ['04: We should observe a signal with the frequency of ',num2str(F_mirrored),' Hz.'];
    disp(p3);
end
%% 05 
%  Play with the appearance of your plot interactively (add a title, add a legend, add a grid, etc.).
%  Save it both in .fig and .png formats.
figure(05);
plot(x_2,y_2,x_3,y_3,'r-*',x_4,y_4,'g-o');
title('A continuous sinusoidal signal with A = 3, f = 3 Hz, Phi = 0 and different SI');
xlabel('Time [s]');
ylabel('Amplitude');
legend('SI = 0.05 s','SI = 0.01 s','SI = 0.25 s');
grid on;
set(gcf,'position',[0,0,1000,500]);
saveas(gcf,'Figure.fig');
saveas(gcf,'Figure.png');
