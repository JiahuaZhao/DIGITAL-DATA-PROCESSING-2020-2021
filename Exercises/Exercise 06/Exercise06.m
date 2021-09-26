%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% EXERCISE 06 %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% 01
%  Build a discrete signal (sampling interval SI = 100 ms, total length T = 10 s) which is the sum of two sine waves with the following characteristics:
%  - A1 = 10, frequency f1 = 0.2 Hz, and phase Phi1 = 0;
%  - A2 = 5, frequency f2 = 2 Hz, and phase Phi2 = -pi/2.
%  Convolve it with a filter whose impulse response is [1/5,1/5,1/5,1/5,1/5] and output the result with the same shape of the input vector. 
%  Plot both the input function and the convolved function on the same figure (use subplot). 
%  Which mathematical operation does this filter apply? Which is the effect on your signal? 
%  To support your conclusions, compute the amplitude spectrum of both the input and the filtered vectors and compare them 
%  (use the compute_spectra function).




%% 02
%  Read a picture of your choice (you can use "IM01.jpg"). Plot the  matrix as image.
%  Convolve it with a 5-by-5 matrix filled with 1/25.
%  Plot the convolved matrix: what do you observe? Which operation did the filter perform?
%  NB: Note the similarity with the previous exercise.




%% 03
%  A seismic impulse is recorded by two stations, ST01 and ST02 (read "stations.mat" with the two traces and the time vector in seconds).
%  The distance between the two stations is 105 m. Plot the two traces with the same scale using subplot.
%  Use cross-correlation to find the travel time of the impulse from ST01 to ST02 and its apparent velocity.
%  Now filter both ST01 and ST02 traces between 10 Hz and 50 Hz (use the bandpass function with a steepness of 0.7).
%  Plot the two filtered traces with the same scale using subplot. Which is the effect of filtering?







