%% Simulation for confirmation of network analysis

% Generate 1000 samples of 250 time points
white = rand(250, 1000);
pink = pinknoise(250, 1000);

for i = 1:1000
    [ple_w(:,i), pxx, freq] = periodogram_ple(white(:,i), 0.5, 0.01, 0.2, 7);
    mf_w(:,i) = medfreq(pxx,freq);
    se_w(:,i) = sampen(white(:,i), 2, 0.5);
    lzc_w(:,i) = LZC_estimation(white(:,i));
    acw_w(:,i) = acw(white(:,i), 0.5);
    
    [ple_p(:,i), pxx, freq] = periodogram_ple(pink(:,i), 0.5, 0.01, 0.2, 7);
    mf_p(:,i) = medfreq(pxx,freq);
    se_p(:,i) = sampen(pink(:,i), 2, 0.5);
    lzc_p(:,i) = LZC_estimation(pink(:,i));
    acw_p(:,i) = acw(pink(:,i), 0.5);
end

whitemeasures = [ple_w', mf_w', se_w', acw_w', lzc_w'];
pinkmeasures = [ple_p', mf_p', se_p', acw_p', lzc_p'];
cd C:\Users\user\Desktop\brain_stuff\Shangai_MATLABScripts\cn_simulation\figures\Supplementary\ple_confirmation\network_analysis\confirmatory
save('simulated.mat', 'whitemeasures', 'pinkmeasures')
