%% Example script for linearly interpolating censored time points

% Generate data with censored time points
x = rand([250 1]);
x([3, 6,7,8, 54, 248]) = 0;

interpolated_x = interpolate(x);