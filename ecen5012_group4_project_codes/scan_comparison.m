% Compare raster scan vs basis scan vs compressive sensing on two sets of images
load("testImages.mat")
% raster scan
tic;
x = peppers;
x = imresize(x, [rootN rootN]);
x_flat = reshape(x, N, 1);
Phi = eye(N);
Psi = eye(N);
y = Phi*x_flat;
x_hat_flat = Phi'*y;
x_hat = reshape(x_hat_flat, rootN, rootN);

figure()
subplot(2,3,1)
imagesc(x_hat);
colormap gray
axis square

mse1 = norm(x_flat-x_hat_flat)/norm(x_flat);
psnr1 = 10*log10(1/mse1);
toc

% basis scan
tic;
x = peppers;
x = imresize(x, [rootN rootN]);
x_flat = reshape(x, N, 1);
Phi = dct(eye(N), 'type', 2);
Psi = eye(N);
y = Phi*x_flat;
x_hat_flat = Phi'*y;
x_hat = reshape(x_hat_flat, rootN, rootN);

subplot(2,3,2)
imagesc(x_hat);
colormap gray
axis square

mse2 = norm(x_flat-x_hat_flat)/norm(x_flat);
psnr2 = 10*log10(1/mse2);
toc

% cs
tic;
x = peppers;
[x_hat, x_hat_flat] = spc_sampling(x, rootN, 2048, "DCT", "gaussian");

x = imresize(x, [rootN rootN]);
x_flat = reshape(x, N, 1);

subplot(2,3,3)
imagesc(x_hat);
colormap gray
axis square

mse3 = norm(x_flat-x_hat_flat)/norm(x_flat);
psnr3 = 10*log10(1/mse3);
toc

% c2c2 raster scan
tic;
x = c2c2;
x = imresize(x, [rootN rootN]);
x_flat = reshape(x, N, 1);
Phi = eye(N);
Psi = eye(N);
y = Phi*x_flat;
x_hat_flat = Phi'*y;
x_hat = reshape(x_hat_flat, rootN, rootN);

subplot(2,3,4)
imagesc(x_hat);
colormap gray
axis square

mse4 = norm(x_flat-x_hat_flat)/norm(x_flat);
psnr4 = 10*log10(1/mse4);
toc

% basis scan
tic;
x = c2c2;
x = imresize(x, [rootN rootN]);
x_flat = reshape(x, N, 1);
Phi = dct(eye(N), 'type', 2);
Psi = eye(N);
y = Phi*x_flat;
x_hat_flat = Phi'*y;
x_hat = reshape(x_hat_flat, rootN, rootN);

subplot(2,3,5)
imagesc(x_hat);
colormap gray
axis square

mse5 = norm(x_flat-x_hat_flat)/norm(x_flat);
psnr5 = 10*log10(1/mse5);
toc

% cs
tic;
x = c2c2;
[x_hat, x_hat_flat] = spc_sampling(x, rootN, 2048, "DCT", "gaussian");

x = imresize(x, [rootN rootN]);
x_flat = reshape(x, N, 1);

subplot(2,3,6)
imagesc(x_hat);
colormap gray
axis square

mse6 = norm(x_flat-x_hat_flat)/norm(x_flat);
psnr6 = 10*log10(1/mse6);
toc

saveas(gcf, "RCvsBCvsCS.png")