function y = CASE(A1,f1,Phi1,A2,f2,Phi2,A3,f3,Phi3,SI,T,t)
    % Function to build, compute and plot the amplitude and phase spectra 
    % of 1D signals by using compute_spectra.m.
    % Input data must be regularly sampled in time.
    %
    % INPUT DATA:
    % A => the amplitude of 1D signal
    % f => the frequency of 1D signal
    % Phi => the phase of 1D signal
    % SI => sampling interval (in seconds)
    % T => total length of time
    % t => discretization time
    %
    % OUTPUT DATA:
    % y => the 1D signal, data vector containing the raw data

    f = @(t) A1 * sin(2*pi*f1*t + Phi1) + A2 * cos(2*pi*f2*t + Phi2) ...
    + A3 * sin(2*pi*f3*t + Phi3);
    y = f(t);

    figure(); subplot(2,1,1); fplot(f,[0 T]); ylim([-300 300]);
    xlabel('Times [s]'); ylabel('Amplitude');
    subplot(2,1,2); plot(t,y); ylim([-300 300]);
    xlabel('Times [s]'); ylabel('Amplitude');

    NFFT = 2^nextpow2(length(y));
    compute_spectra(y,SI,NFFT);
end