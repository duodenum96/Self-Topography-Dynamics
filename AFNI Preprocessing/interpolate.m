function [int_ts] = interpolate(ts)
%% Interpolate Time Series
% This function interpolates censored time points. It was written with
% preprocessing via AFNI in mind, use with caution. This is a very lazily 
% written script using lots of for-loops and brute force, a more clever implementation
% is possible.
% I wrote this to account for 10 consecutive censored time points, but it's
% actually too much. I wouldn't recommend using it for, 5-6 consecutive
% points. Why would you keep a subject that can't sit still for 20 seconds
% anyway!
%
% Authored by: Yasir Çatal a.k.a. The One With the Green Cardigan

if ts(1) == 0
    ts(1) = mean(ts);
end

if ts(end) == 0
    ts(end) = mean(ts);
end

for i = 1:length(ts)
    if ts(i) == 0
        if ts(i+1) == 0
            if ts(i+2) == 0
                if ts(i+3) == 0
                    if ts(i+4) == 0
                        if ts(i+5) == 0
                            if ts(i+6) == 0
                                if ts(i+7) == 0
                                    if ts(i+8) == 0
                                        if ts(i+9) == 0
                                            x = (ts(i+10) - ts(i-1))/11;
                                            for y = 0:9
                                                ts(i+y) = ts(i-1) + x*(y+1);
                                            end
                                        end
                                        x = (ts(i+9) - ts(i-1))/10;
                                        for y = 0:8
                                            ts(i+y) = ts(i-1) + x*(y+1);
                                        end
                                    end
                                    x = (ts(i+8) - ts(i-1))/9;
                                    for y = 0:7
                                       ts(i+y) = ts(i-1) + x*(y+1);
                                    end
                                end
                                x = (ts(i+7) - ts(i-1))/8;
                                for y = 0:6
                                    ts(i+y) = ts(i-1) + x*(y+1);
                                end
                            end
                            x = (ts(i+6) - ts(i-1))/7;
                            for y =0:5
                               ts(i+y) = ts(i-1) + x*(y+1);
                            end
                        end
                        x = (ts(i+5) - ts(i-1))/6;
                            for y =0:4
                               ts(i+y) = ts(i-1) + x*(y+1);
                            end
                        end
                        x = (ts(i+4) - ts(i-1))/5;
                        for y = 0:3
                            ts(i+y) = ts(i-1) + x*(y+1);
                        end
                        end
                x = (ts(i+3) - ts(i-1))/4;
                for y = 0:2
                    ts(i+y) = ts(i-1) + x*(y+1);
                end
            end
            x = (ts(i+2) - ts(i-1))/3;
            for y = 0:1
                ts(i+y) = ts(i-1) + x*(y+1);
            end
        end
    x = (ts(i+1) - ts(i-1))/2;
    for y = 0
       ts(i+y) = ts(i-1) + x*(y+1);
    end
end

int_ts = ts;
end
end