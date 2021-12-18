% Sampling an image with a single pixel camera. Given by Kuusela with the
% relationship s = psi^T * x, where x is the true image, psi is a basis
% (such as DCT) s are the samples acquired by the photosensor and * is the
% matrix multiply.

load('testImages.mat')
spg_opts = spgSetParms('verbosity', 0);

rootN = 50;
N = rootN^2;
x = imresize(c2c2, [rootN rootN]);
x_flat = reshape(x, N, 1);

% Normalize
x_flat = x_flat + min(x_flat);
x_flat = x_flat / max(x_flat);

% psi = DCT-ii
Psi = dct(eye(N), 'type', 2);

% Take photosensor measurements s
s = Psi'*x_flat;

% Reconstruct from basis psi (Kuusela eqn 3)
x_hat = Psi*s;

% Are they the same? A: Yes
max(abs(x_hat-x_flat))

% Try compressive sampling
M=round(0.8*N);
%K=round(0.8*M);
K=M;
Phi=randn(M, N);
%Theta = Phi*Psi;

support = randperm(N, K);
alpha = zeros(N, 1);
alpha(support) = s(support);

% Reconstruction
y = Phi*alpha;
s_hat = spg_bp(Phi, y, spg_opts);
x_hat_flat = Psi*s_hat;
x_hat = reshape(x_hat_flat, rootN, rootN);

imagesc(x_hat);
colormap gray
axis square