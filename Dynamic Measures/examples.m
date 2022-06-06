%% Example script to calculate different measures
% Generate a signal
x = rand([250, 1]);

% Calculate PLE, get pdata and freq for MF calculation.
[ple, pdata, freq] = periodogram_ple(x, 0.5, 0.01, 0.2, 7);
mf = medfreq(pdata, freq);

% Calculate other measures
lzc = LZC_estimation(x);
se = sampen(x, 2, 0.5);
acw_0 = acw(x, 0.5);

% Calculate gradient index of PLE based on three generated signals
x1 = rand([250, 1]);
x2 = rand([250, 1]);
x3 = rand([250, 1]);

ple1 = periodogram_ple(x1, 0.5, 0.01, 0.2, 7);
ple2 = periodogram_ple(x2, 0.5, 0.01, 0.2, 7);
ple3 = periodogram_ple(x3, 0.5, 0.01, 0.2, 7);
ples = [ple1, ple2, ple3];

coef = polyfit(1:3, ples, 1);
gradient_ple = abs(coef(1));