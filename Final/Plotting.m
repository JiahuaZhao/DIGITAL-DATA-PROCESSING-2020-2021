function Plotting(time,dtime,vdis,idx)
    c = polyfit(time,vdis,1);
    vdis_polyval = polyval(c,time);

    figure(); scatter(dtime,vdis,'c','filled'); hold on; plot(dtime,vdis,'k');
    plot(dtime,vdis_polyval,'--r','LineWidth',2); grid on; grid minor;
    xlabel('Time [day]'); ylabel('Vertical [mm]');
    title('VERTICAL POSITION - SERMERSOOQ, GREENLAND (STATION HEL2)');
    if idx == 1
        subtitle('Original data');
    elseif idx == 2
        subtitle('After linear interpolation');
    elseif idx == 3
        subtitle('After linear interpolation and detrend');
    elseif idx == 4
        subtitle('After linear interpolation, detrend and movmean');
    elseif idx == 5
        subtitle('After linear interpolation, detrend and convolution');
    end
    xlim([min(dtime)-365 max(dtime)+365]); 
    legend('Daily position','Continuous line','Polynomial curve fitting','Location','northwest');
    hold off;
end