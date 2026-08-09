%section1
N_test = 256;
x_test = randn(1, N_test) + 1i * randn(1, N_test);

X_loop = myDFTLoop(x_test);
X_mat = myDFTMatrix(x_test);
X_fft = fft(x_test);

err_loop = norm(X_loop - X_fft);
err_mat = norm(X_mat - X_fft);
disp(err_loop);
disp(err_mat);

N_vals = [64, 128, 256, 512, 1024, 2048];
time_loop = zeros(1, length(N_vals));
time_mat = zeros(1, length(N_vals));
time_fft = zeros(1, length(N_vals));

for idx = 1:length(N_vals)
    N_current = N_vals(idx);
    x_rand = randn(1, N_current) + 1i * randn(1, N_current);
    
    tic;
    myDFTLoop(x_rand);
    time_loop(idx) = toc;
    
    tic;
    myDFTMatrix(x_rand);
    time_mat(idx) = toc;
    
    tic;
    fft(x_rand);
    time_fft(idx) = toc;
end

results_table = table(N_vals', time_loop', time_mat', time_fft', ...
    'VariableNames', {'N', 'Loop_Time', 'Matrix_Time', 'FFT_Time'});
disp(results_table);

figure;
loglog(N_vals, time_loop, '-o', 'LineWidth', 2);
hold on;
loglog(N_vals, time_mat, '-s', 'LineWidth', 2);
loglog(N_vals, time_fft, '-^', 'LineWidth', 2);
hold off;
legend('Loop \mathcal{O}(N^2)', 'Matrix \mathcal{O}(N^2)', 'FFT \mathcal{O}(N \log N)');
xlabel('Sequence Length (N)');
ylabel('Execution Time (Seconds)');
title('DFT Execution Time Profiling');
grid on;

%section2_1
fs = 1000;
f1 = 100;
f2 = 105;

T1 = 0.1;
t1 = 0:1/fs:T1-1/fs;
x1 = cos(2*pi*f1*t1) + 0.5*cos(2*pi*f2*t1);
N1 = length(x1);
X1 = fft(x1);
f_axis1 = (0:N1-1)*(fs/N1);

figure;
subplot(3,1,1);
plot(f_axis1, abs(X1), 'LineWidth', 1.5);
title('DFT: T = 0.1s');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
xlim([0 fs/2]);
grid on;

N_pad = 1024;
X1_pad = fft(x1, N_pad);
f_axis_pad = (0:N_pad-1)*(fs/N_pad);

subplot(3,1,2);
plot(f_axis_pad, abs(X1_pad), 'LineWidth', 1.5);
title('DFT: T = 0.1s, Zero-padded to 1024');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
xlim([0 fs/2]);
grid on;

T2 = 0.5;
t2 = 0:1/fs:T2-1/fs;
x2 = cos(2*pi*f1*t2) + 0.5*cos(2*pi*f2*t2);
N2 = length(x2);
X2 = fft(x2);
f_axis2 = (0:N2-1)*(fs/N2);

subplot(3,1,3);
plot(f_axis2, abs(X2), 'LineWidth', 1.5);
title('DFT: T = 0.5s');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
xlim([0 fs/2]);
grid on;

%section2_2
f2_new = 123.5;
T3 = 0.2;
t3 = 0:1/fs:T3-1/fs;
x3 = cos(2*pi*f1*t3) + 0.5*cos(2*pi*f2_new*t3);
N3 = length(x3);

win_rect = rectwin(N3)';
win_hann = hann(N3)';
win_hamm = hamming(N3)';

X3_rect = fft(x3 .* win_rect, 1024);
X3_hann = fft(x3 .* win_hann, 1024);
X3_hamm = fft(x3 .* win_hamm, 1024);
f_axis3 = (0:1023)*(fs/1024);

figure;
plot(f_axis3, abs(X3_rect), 'LineWidth', 1.5);
hold on;
plot(f_axis3, abs(X3_hann), 'LineWidth', 1.5);
plot(f_axis3, abs(X3_hamm), 'LineWidth', 1.5);
hold off;
title('Spectral Leakage and Windowing');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
legend('Rectangular', 'Hann', 'Hamming');
xlim([80 150]);
grid on;


%section3
n_x = 0:15;
x_seq = n_x .* (n_x >= 0 & n_x <= 7);
n_h = 0:15;
h_seq = (0.8).^n_h .* (n_h >= 0 & n_h <= 5);

x_trim = x_seq(1:8);
h_trim = h_seq(1:6);

y_lin = conv(x_trim, h_trim);

N_8 = 8;
X_8 = fft(x_trim, N_8);
H_8 = fft(h_trim, N_8);
y_circ_8 = ifft(X_8 .* H_8);

N_14 = 14;
X_14 = fft(x_trim, N_14);
H_14 = fft(h_trim, N_14);
y_circ_14 = ifft(X_14 .* H_14);

figure;
subplot(3,1,1);
stem(0:length(y_lin)-1, y_lin, 'filled', 'LineWidth', 1.5);
title('Linear Convolution');
xlabel('n'); ylabel('Amplitude');

subplot(3,1,2);
stem(0:N_8-1, y_circ_8, 'filled', 'r', 'LineWidth', 1.5);
title('Circular Convolution (N = 8) - Aliasing');
xlabel('n'); ylabel('Amplitude');

subplot(3,1,3);
stem(0:N_14-1, y_circ_14, 'filled', 'g', 'LineWidth', 1.5);
title('Circular Convolution (N = 14)');
xlabel('n'); ylabel('Amplitude');


%section4
fs_dtmf = 8000;
t_dtmf = 0:1/fs_dtmf:0.15-1/fs_dtmf;
f_row_8 = 852;
f_col_8 = 1336;

signal_8 = sin(2*pi*f_row_8*t_dtmf) + sin(2*pi*f_col_8*t_dtmf);

figure;
plot(t_dtmf(1:200), signal_8(1:200), 'LineWidth', 1.5);
title('Waveform of DTMF Digit "8"');
xlabel('Time (s)'); ylabel('Amplitude');

N_dtmf = 2048;
X_dtmf = fftshift(fft(signal_8, N_dtmf));
f_axis_dtmf = linspace(-fs_dtmf/2, fs_dtmf/2, N_dtmf);

figure;
plot(f_axis_dtmf, abs(X_dtmf), 'LineWidth', 1.5);
title('Magnitude Spectrum of Digit "8"');
xlabel('Frequency (Hz)'); ylabel('Magnitude');
xlim([-2000 2000]);


%section5_1
img_lines = repmat([zeros(256, 4), ones(256, 4)], 1, 32);
IMG_lines_fft = fftshift(fft2(img_lines));

figure;
subplot(1,2,1);
imshow(img_lines);
title('Spatial Pattern: Bars');
subplot(1,2,2);
imagesc(log(1 + abs(IMG_lines_fft))); colormap gray;
title('2D DFT Magnitude');

img_square = zeros(256, 256);
img_square(113:144, 113:144) = 1;
IMG_square_fft = fftshift(fft2(img_square));

figure;
subplot(1,2,1);
imshow(img_square);
title('Spatial Pattern: Square');
subplot(1,2,2);
imagesc(log(1 + abs(IMG_square_fft))); colormap gray;
title('2D DFT Magnitude');

%section5_2
img_orig = imread('peppers.png');
img_gray = im2double(rgb2gray(img_orig));
img_gray = imresize(img_gray, [256 256]); 

[X_grid, Y_grid] = meshgrid(1:256, 1:256);
u0 = 0.15; v0 = 0.15;
noise_pattern = 0.4 * cos(2*pi*(u0*X_grid + v0*Y_grid));
img_noisy = img_gray + noise_pattern;

IMG_noisy_fft = fftshift(fft2(img_noisy));

figure;
surf(log(1 + abs(IMG_noisy_fft)), 'EdgeColor', 'none');
title('3D Magnitude Spectrum of Noisy Image');

notch_mask = ones(256, 256);
[M, N] = size(img_noisy);
center_u = M/2 + 1;
center_v = N/2 + 1;
noise_u = round(u0 * M);
noise_v = round(v0 * N);

notch_radius = 5;
for i = 1:M
    for j = 1:N
        dist1 = sqrt((i - (center_u + noise_u))^2 + (j - (center_v + noise_v))^2);
        dist2 = sqrt((i - (center_u - noise_u))^2 + (j - (center_v - noise_v))^2);
        if dist1 < notch_radius || dist2 < notch_radius
            notch_mask(i, j) = 0;
        end
    end
end

IMG_filtered = IMG_noisy_fft .* notch_mask;
img_restored = real(ifft2(ifftshift(IMG_filtered)));

figure;
subplot(1,3,1); imshow(img_gray); title('Original');
subplot(1,3,2); imshow(img_noisy); title('Corrupted');
subplot(1,3,3); imshow(img_restored); title('Restored');

%functions
function X = myDFTLoop(x)
    N = length(x);
    X = zeros(1, N);
    for k = 0:N-1
        for n = 0:N-1
            X(k+1) = X(k+1) + x(n+1) * exp(-1i * 2 * pi * k * n / N);
        end
    end
end

function X = myDFTMatrix(x)
    N = length(x);
    n = 0:N-1;
    k = 0:N-1;
    W = exp(-1i * 2 * pi / N * (k' * n));
    x_col = x(:);
    X_col = W * x_col;
    X = reshape(X_col, size(x));
end
