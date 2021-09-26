function [amplitude_1side,frequency_1side]=compute_spectra_new(y,SI,NFFT)

    % Function to compute and plot amplitude and phase spectra of 1D signals.
    % Input data must be regularly sampled in time.
    %
    % INPUT DATA:
    % y => data vector containing the raw data (1 x n. samples)
    % SI => sampling interval (in seconds)
    % NFFT => transform length
    %
    % OUTPUT DATA:
    % amplitude_1side => vector containing the one-sided amplitude spectrum
    % frequency_1side => frequency vector (in Hz)

    fNY = 1/(2*SI);
    frequency = -fNY:2*fNY/(NFFT-1):fNY;
    spectrum = fftshift(fft(y,NFFT));
    amplitude = abs(spectrum)/length(y);
    phase=angle(spectrum);
    frequency_1side = frequency(floor(NFFT/2)+1:end);
    amplitude_1side = 2*amplitude(floor(NFFT/2)+1:end);

end