function [acw_0, acw_50] = acw(x, fs, varargin)
%% Calculate ACW-0 and ACW-50
% This function doesn't follow Honey et al.'s version (averaging ACW
% values in 50% overlapping 20s segments). Instead, it's a direct version that
% is more suitable for fMRI data due to it's low temporal resolution.
% x is input time series. If 'plot' is an input, then plots ACW_0 and
% ACW_50. fs is sampling rate in seconds. if not specified, fs defaults to
% 1.
%
% Authored by Duodenum

if isempty(fs)
    fs = 1;
end

[acf, lags] = autocorr(x, 'NumLags', length(x)-1, 'NumSTD', 0);
[~, ACW_50_i] = max(acf<=0.5);
acw_50 = (2*(ACW_50_i-1)-1)/fs;
[~, ACW_0_i] = max(acf<=0);
acw_0 = (2*(ACW_0_i-1)-1)/fs;

if CheckInput(varargin,'plot')
    plot(lags/fs,acf,'k')
    xlim([0 max(lags/fs)])
    hold on
    area(lags(1:ACW_50_i)/fs, acf(1:ACW_50_i),'FaceColor','r','FaceAlpha',0.3);
    area(lags(1:ACW_0_i)/fs, acf(1:ACW_0_i),'FaceColor','m','FaceAlpha',0.3);
    title(['ACW-0 = ', num2str(ACW_0, '%.3f'), ' ACW-50 = ', num2str(ACW_50, '%.3f')])
    xlabel('Lags (s)')
    ylabel('Autocorrelation')
end
end