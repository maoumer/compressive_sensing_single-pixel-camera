% Create coefficient plots with DCT and Hadamard transform for a few of the test images
% The plots give an idea of the sparsity of the sparse s obtained. Refer to
% Kuusela Single-Pixel Camera for detail description.
load("testImages.mat");

x1 = c2c2;
x2 = peppers;

rootN = 64;
N = rootN^2;
% Calculate coefficients for c2c2 test image
x = imresize(x1, [rootN rootN]);
x_flat = reshape(x, N, 1);
x_flat = x_flat - min(x_flat);
x_flat = x_flat / max(x_flat);

dct_mat = dct(eye(N), 'type', 2);
had_mat = hadamard(N) / rootN;

s_dct = dct_mat'*x_flat;
s_had = had_mat*x_flat; % Hadamard matrix is symmetric

s_dct_abs = sort(abs(s_dct), 'descend');
s_had_abs = sort(abs(s_had), 'descend');

% Create coefficient plot for c2c2
i = 1:4096;
figure;
fig=gcf;
fig.Position(3:4)=[800, 600];
semilogy(i, s_dct_abs, "k-", i, s_had_abs, "k--");
axis([-100 4096 10^-3 10^2]);
grid on;
legend("DCT", "Hadamard");
ylabel("Coefficient magnitude");
xlabel("Coefficient order from largest to smallest");
saveas(gca, "c2c2_coefficient_plot", "epsc");

% Calculate coefficients for peppers test image
x = imresize(x2, [rootN rootN]);
x_flat = reshape(x, N, 1);
x_flat = x_flat - min(x_flat);
x_flat = x_flat / max(x_flat);

s_dct = dct_mat'*x_flat;
s_had = had_mat*x_flat; % Hadamard matrix is symmetric

s_dct_abs = sort(abs(s_dct), 'descend');
s_had_abs = sort(abs(s_had), 'descend');

% Create coefficient plot for c2c2
i = 1:4096;
figure;
fig=gcf;
fig.Position(3:4)=[800, 600];
semilogy(i, s_dct_abs, "k-", i, s_had_abs, "k--");
axis([-100 4096 10^-3 10^2]);
grid on;
legend("DCT", "Hadamard");
ylabel("Coefficient magnitude");
xlabel("Coefficient order from largest to smallest");
saveas(gca, "peppers_coefficient_plot", "epsc");