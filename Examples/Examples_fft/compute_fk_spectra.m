function [fk_ampl,frequencies,ks]=compute_fk_spectra(traces,dX,SI,kmax,fmax)

    % Function to compute and plot amplitude f-k spectra from seismograms.
    % Input data must be regularly sampled both in space and time.
    %
    % INPUT DATA:
    % traces => data matrix containing the raw data (n. samples x n. receivers)
    % dX => receiver spacing (in m)
    % SI => sampling interval (in seconds)
    % kmax => maximum wavenumber for display (in rad/m)
    % fmax => maximum frequency for display (in Hz)
    %
    % OUTPUT DATA:
    % fk_ampl => matrix containing the f-k one-sided amplitude spectrum
    % frequencies => frequency vector (in Hz)
    % ks => wavenumber vector (in rad/m)

    NFFT = 2^nextpow2(size(traces,1));
    ks = linspace(-0.5/dX,0.5/dX,NFFT);  % in 1/m
    ks = ks*2*pi;  % in rad/m
    frequencies = linspace(0,0.5/SI,NFFT/2);  % in Hz

    fk = fftshift(fft2(traces,NFFT,NFFT));
    fk = flipud(fk(1:NFFT/2,:));
    fk_ampl = 2*abs(fk)/(numel(traces));

    % I plot the f-k amplitude spectrum
    figure;
    imagesc(ks,frequencies,fk_ampl);
    axis xy
    xlabel('k [rad/m]')
    ylabel('frequency [Hz]')
    title('f-k spectrum')
    xlim([-kmax kmax]);ylim([0 fmax]);
    colormap jet;colorbar;

end