function [ple,pdata,freq] = periodogram_ple(time_series,fs,low_range,high_range,smoothn, varargin)
% periodogram_ple is a modification of Jianfeng Zhang's JF_power_law which was a modification of JF_power_law_nfft1024
% script for calculating the power-law exponent based on Welch's power
% spectral density estimate. The modifications include automatically
% setting the Welch window based on the lowest frequency in the data, and
% adding the option to plot the power spectrum and fit. I removed the Welch
% method and added the smoothing. This is the same method in AFNI routine.
% 3dPeriodogram + 3dTsmooth - Hamming n.
% Modified by Yasir Çatal aka Duodenum the Omnicelestial
% Original script taken from dynameas package of Soren Wainio-Theberge
% https://github.com/SorenWT/dynameas/
% 
% Input arguments: 
%    time_series: a vector containing the time series of interest
%    fs: the sampling rate of data
%    low_range: the lowest frequency to be included in the fit
%    high_range: the highest frequency to be included in the fit
%   smoothn: The window length of the Hamming window used for smoothing.
% 
% Optional key-value pairs: 
%    'plot': plots the power spectrum and the power-law fit
%
% Outputs: 
%    ple: the power-law exponent
%    pdata: the power spectrum
%    freq: the frequencies from the power spectrum estimation
%% Calculate the PSD

nfft = 2^nextpow2((3/low_range)*fs);

if nfft > length(time_series) || nfft/(2*fs) < 1
   nfft = []; % if nfft is too large or too small, just use the default Welch window
end

[pdataorig,freq] = periodogram(time_series,[],nfft,fs); %want 3 cycles of lowest frequency in window
pdata = zeros([length(pdataorig) 1]);

%% Smooth data
% Determine indices at the start and end of the pdata
startid = ceil(smoothn/2);
endid = length(pdataorig) - ceil(smoothn/2) + 1;                            % Do it for maximum number of frequency points
pdata(1:startid-1) = pdataorig(1:startid-1);
pdata(endid+1:end) = pdataorig(endid+1:end);

% Do the smoothing
for i = startid:endid                                                       
    pdata(i) = sum(pdataorig(i-ceil(smoothn/2)+1:i+floor(smoothn/2)) .* hamming2(smoothn));
end
    
%% Calculate PLE
slope_index = find(freq > low_range & freq < high_range);
%freq = freq(slope_index)';
if CheckInput(varargin,'interp') && EasyParse(varargin,'interp','off')
    linfreq = log10(freq(slope_index));
    fitdata = log10(pdata(slope_index));
else
    fitfreq = log10(freq(slope_index));
    fitdata = log10(pdata(slope_index));
    linfreq = linspace(min(fitfreq),max(fitfreq),length(fitfreq));
    fitdata = interp1(fitfreq,fitdata,linfreq);
end

p = polyfit(vert(linfreq),vert(fitdata),1);
ple = -p(1);

%% Plot if you're into that type of thing
if CheckInput(varargin,'plot')
    y = p(2) + p(1)*log10(freq(slope_index));
    loglog(freq(slope_index),pdata(slope_index));
    hold on;
    loglog(freq(slope_index),10.^y,'r--');
    xlabel('Log Frequency')
    ylabel('Log Power')
    title(['Estimated PLE is ' num2str(ple)])
end
