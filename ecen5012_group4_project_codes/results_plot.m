% Plot c2c2, peppers and smoothIm in 3x3 subplots under different basis
load("testImages.mat");

rng(3141592);
rootN=64;
N=rootN^2;
M=200;

figure;
fig=gcf;
fig.Position(3:4)=[800, 800];

subplot(3, 3, 1);
smoothIm_resized = imresize(smoothIm, [rootN rootN]);
smoothIm_resized = smoothIm_resized - min(min(smoothIm_resized));
smoothIm_resized = smoothIm_resized / max(max(smoothIm_resized));
imagesc(smoothIm_resized);
axis square;
colormap gray;

subplot(3, 3, 2);
smoothIm_dct_norm = spc_sampling(smoothIm, rootN, M, "DCT", "normal");
imagesc(smoothIm_dct_norm);
axis square;
colormap gray;

subplot(3, 3, 3);
smoothIm_dct_bern = spc_sampling(smoothIm, rootN, M, "DCT", "bernoulli");
imagesc(smoothIm_dct_bern);
axis square;
colormap gray;

subplot(3, 3, 4);
c2c2_resized = imresize(c2c2, [rootN rootN]);
c2c2_resized = c2c2_resized - min(min(c2c2_resized));
c2c2_resized = c2c2_resized / max(max(c2c2_resized));
imagesc(c2c2_resized);
axis square;
colormap gray;

M=1000;
subplot(3, 3, 5);
c2c2_dct = spc_sampling(c2c2, rootN, M, "DCT", "normal");
imagesc(c2c2_dct);
axis square;
colormap gray;

subplot(3, 3, 6);
c2c2_had = spc_sampling(c2c2, rootN, M, "hadamard", "normal");
imagesc(c2c2_had);
axis square;
colormap gray;

subplot(3, 3, 7);
peppers_resized = imresize(peppers, [rootN rootN]);
peppers_resized = peppers_resized - min(min(peppers_resized));
peppers_resized = peppers_resized / max(max(peppers_resized));
imagesc(peppers_resized);
axis square;
colormap gray;

M=2000;
subplot(3, 3, 8);
peppers_dct = spc_sampling(peppers, rootN, M, "DCT", "normal");
imagesc(peppers_dct);
axis square;
colormap gray;

subplot(3, 3, 9);
peppers_had = spc_sampling(peppers, rootN, M, "hadamard", "normal");
imagesc(peppers_had);
axis square;
colormap gray;

saveas(gca, "simulation_results", "epsc");