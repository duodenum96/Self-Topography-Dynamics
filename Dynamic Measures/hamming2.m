function wt = hamming2(ntap)
% Hamming smoothing function
% As implemented in AFNI 3dTsmooth
% ntap is the number of points in the hamming window

nt2 = floor((ntap-1)/2);
wt  = zeros([ntap 1]);
tau = nt2 + 1;
sumx = 0; % To avoid confusion with the internal matlab function

for i = 0:2*nt2
    t = pi*(i-nt2)/tau;
    wt(i+1) = 0.54 + 0.46*cos(t);
    sumx = sumx + wt(i+1);
end

sumx = 1/sumx;

for i = 0:ntap-1
    wt(i+1) = wt(i+1) * sumx;
end

end