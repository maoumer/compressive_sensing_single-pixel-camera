function [x_hat] = spc_sampling(x, rootN, M, basis, sense)
% SPC_SAMPLING Sample an image similarly to a single pixel camera

% Sampling an image with a single pixel camera. Given by Kuusela with the
% relationship s = Psi^T * x, where x is the true image, psi is a basis
% (such as DCT) s are the samples acquired by the photosensor and * is the
% matrix multiply.
% x - 2D image (generally considered square images)
% rootN - dimension of x (width or height)
% M - number of measurements desired (upper bounded by N, lower bounded by
% K). K = sparsity, N = number of pixels in image
% basis - compressive basis Psi (here used DCT or Hadamard or identity)
% sense - sensing matrix Phi (here used random bernoulli or gaussian)
% y = Phi*x = Phi*Psi*s = Theta*s where s is the K-sparse coefficient vector
% Used SPGL1 convex optimization package for the basis pursuit
tic;
spg_opts = spgSetParms('verbosity', 0);

N = rootN^2;
x = imresize(x, [rootN rootN]);
x_flat = reshape(x, N, 1);

% Normalize
x_flat = x_flat - min(x_flat);
x_flat = x_flat / max(x_flat);

% set Psi - compressive basis
if strcmp(basis, "DCT")
    Psi = dct(eye(N), 'type', 2);
elseif strcmp(basis, "hadamard")
    Psi = hadamard(N) / rootN;
else
    Psi = eye(N);
end

% Set Phi - sensing matrix
if strcmp(sense, "bernoulli")
    Phi=binornd(1, 0.5, M, N);
else
    Phi=randn(M, N);
end

% Get measurements y and matrix Theta
y = Phi*x_flat;
Theta = Phi*Psi;

% Reconstruction using basis pursuit
s = spg_bp(Theta, y, spg_opts);
x_hat_flat = Psi*s;
x_hat = reshape(x_hat_flat, rootN, rootN);
toc