close all; clear all; clc
% uses webcam package
cam = webcam;
% cam.AvailableResolutions; % to check for your device
cam.Resolution = '640x480'; % highest resolution for my device. 
self_portrait = snapshot(cam);
self_portrait = double(rgb2gray(self_portrait)); % grayscale
save self_portrait.mat;
imwrite(self_portrait, "self_portrait.png");

% test on a self portrait 
load("self_portrait.mat");

rng(3141592);
rootN=100;
N = rootN^2;
M=round(0.5*N);

self_cs = spc_sampling(self_portrait, rootN, M, "DCT", "normal");
imwrite(self_cs, "self_portrait_cs.png");

self_portrait = imresize(self_portrait, [rootN, rootN]);
mse = norm(self_cs - self_portrait) / norm(self_portrait);
psnr = 10*log10(1 / mse);

% plot images
figure()
subplot(1,2,1)
imagesc(self_portrait); axis square; colormap gray
title('Original Self Portrait');
subplot(1,2,2)
imagesc(self_cs); axis square; colormap gray
title(['Reconstructed Self Portrait. M = ' num2str(M)]);

clear('cam');