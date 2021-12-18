% different tests on 2 images for basis and sensing matrix test and plot
% their respective psnr. images = smoothIm, c2c2

load("testImages.mat");

rng(3141592);
rootN=64;
N=rootN^2;
M=200;

% smoothIm with DCT and Hadamard bases
smoothIm_dct_norm = spc_sampling(smoothIm, rootN, M, "DCT", "normal");
imwrite(smoothIm_dct_norm, "smoothIm_dct_norm.png");

smoothIm_dct_bern = spc_sampling(smoothIm, rootN, M, "DCT", "bernoulli");
imwrite(smoothIm_dct_bern, "smoothIm_dct_bern.png");

% c2c2 with DCT and Hadamard bases
M=1000;
c2c2_dct = spc_sampling(c2c2, rootN, M, "DCT", "normal");
imwrite(c2c2_dct, "c2c2_dct.png");

c2c2_had = spc_sampling(c2c2, rootN, M, "hadamard", "normal");
imwrite(c2c2_had, "c2c2_had.png");

c2c2_eye = spc_sampling(c2c2, rootN, M, "eye", "normal");
imwrite(c2c2_eye, "c2c2_eye.png");

indices = 1:9;
M_values = round(0.1*indices*N);
c2c2_resized = imresize(c2c2, [rootN rootN]);
c2c2_resized = c2c2_resized - min(min(c2c2_resized));
c2c2_resized = c2c2_resized / max(max(c2c2_resized));
dct_psnr = zeros(1, length(indices));
had_psnr = zeros(1, length(indices));
for i = indices
    M = M_values(i);
    c2c2_dct = spc_sampling(c2c2_resized, rootN, M, "DCT", "normal");
    mse = norm(c2c2_dct - c2c2_resized) / norm(c2c2_resized);
    dct_psnr(i) = 10*log10(1/mse);

    c2c2_had = spc_sampling(c2c2_resized, rootN, M, "hadamard", "normal");
    mse = norm(c2c2_had - c2c2_resized) / norm(c2c2_resized);
    had_psnr(i) = 10*log10(1/mse);
end

figure;
fig=gcf;
fig.Position(3:4)=[800, 600];
plot(M_values, dct_psnr, 'b-.', M_values, had_psnr, 'r-.');
xlabel("M");
ylabel("PSNR (dB)")
legend("DCT", "Hadamard");
grid on;
saveas(gca, "c2c2_psnr_plot", "epsc");
