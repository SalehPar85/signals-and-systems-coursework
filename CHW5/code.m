%section1
t = 0:1e-4:0.1;
x = cos(2*pi*40*t) + 0.6*cos(2*pi*90*t);

figure;
plot(t, x, 'LineWidth', 1.5);
title('Original Signal x(t)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

Fs_list = [150, 200, 500];
MSE = zeros(1, 3);

for i = 1:length(Fs_list)
    Fs = Fs_list(i);
    Ts = 1/Fs;
    ts = 0:Ts:0.1;
    xs = cos(2*pi*40*ts) + 0.6*cos(2*pi*90*ts);
    
    figure;
    plot(t, x, 'LineWidth', 1.5);
    hold on;
    stem(ts, xs, 'r', 'LineWidth', 1.2);
    title(['Sampled Signal at Fs = ', num2str(Fs), ' Hz']);
    xlabel('Time (s)');
    ylabel('Amplitude');
    legend('Original x(t)', 'Samples x[n]');
    grid on;
    hold off;
    
    xr = zeros(size(t));
    for k = 1:length(ts)
        xr = xr + xs(k) * sinc((t - ts(k)) / Ts);
    end
    
    figure;
    plot(t, x, 'LineWidth', 1.5);
    hold on;
    plot(t, xr, '--r', 'LineWidth', 1.5);
    title(['Reconstructed Signal (Fs = ', num2str(Fs), ' Hz)']);
    xlabel('Time (s)');
    ylabel('Amplitude');
    legend('Original x(t)', 'Reconstructed x_r(t)');
    grid on;
    hold off;
    
    MSE(i) = mean((x - xr).^2);
end

disp('Mean Squared Errors for Fs = 150, 200, 500 Hz:');
disp(MSE);

%section2
Fs1 = 200;
t1 = 0:1/Fs1:1-1/Fs1;
x1 = cos(2*pi*30*t1) + 0.8*cos(2*pi*70*t1) + 0.5*cos(2*pi*160*t1);

N1 = length(x1);
X1 = abs(fftshift(fft(x1))) / N1;
f1 = (-N1/2:N1/2-1) * (Fs1/N1);

figure;
plot(f1, X1, 'LineWidth', 1.5);
title('Magnitude Spectrum (Fs = 200 Hz)');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
xlim([0 100]);
grid on;

Fs2 = 400;
t2 = 0:1/Fs2:1-1/Fs2;
x2 = cos(2*pi*30*t2) + 0.8*cos(2*pi*70*t2) + 0.5*cos(2*pi*160*t2);

N2 = length(x2);
X2 = abs(fftshift(fft(x2))) / N2;
f2 = (-N2/2:N2/2-1) * (Fs2/N2);

figure;
plot(f2, X2, 'LineWidth', 1.5);
title('Magnitude Spectrum (Fs = 400 Hz)');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
xlim([0 200]);
grid on;

%section3
t = 0:1e-4:0.5;
x = sin(2*pi*10*t) + 0.5*sin(2*pi*35*t);

Fs = 100;
Ts = 1/Fs;
ts = 0:Ts:0.5;
xs = sin(2*pi*10*ts) + 0.5*sin(2*pi*35*ts);

figure;
plot(t, x, 'LineWidth', 1.5);
hold on;
stem(ts, xs, 'r', 'LineWidth', 1.2);
title('Original Signal and Sampled Points');
xlabel('Time (s)');
ylabel('Amplitude');
legend('x(t)', 'x[n]');
grid on;
hold off;

xr_zoh = interp1(ts, xs, t, 'previous');

figure;
plot(t, x, 'LineWidth', 1.5);
hold on;
stem(ts, xs, 'r', 'LineWidth', 1.2);
plot(t, xr_zoh, 'w', 'LineWidth', 1.5);
title('Zero-Order Hold Reconstruction');
xlabel('Time (s)');
ylabel('Amplitude');
legend('x(t)', 'x[n]', 'ZOH');
grid on;
hold off;

xr_sinc = zeros(size(t));
for k = 1:length(ts)
    xr_sinc = xr_sinc + xs(k) * sinc((t - ts(k)) / Ts);
end

figure;
plot(t, x, 'LineWidth', 1.5);
hold on;
plot(t, xr_zoh, 'w', 'LineWidth', 1.5);
plot(t, xr_sinc, '--r', 'LineWidth', 1.5);
title('Comparison: ZOH vs Ideal Sinc');
xlabel('Time (s)');
ylabel('Amplitude');
legend('Original', 'ZOH', 'Sinc');
grid on;
hold off;

mse_zoh = mean((x - xr_zoh).^2);
mse_sinc = mean((x - xr_sinc).^2);

disp('Reconstruction Error (MSE):');
disp(['ZOH Error: ', num2str(mse_zoh)]);
disp(['Sinc Error: ', num2str(mse_sinc)]);

%section4
t = 0:1e-4:2;
x_clean = sin(2*pi*5*t) + 0.5*sin(2*pi*40*t);
noise = 0.3 * randn(size(t));
x_noisy = x_clean + noise;

figure;
subplot(3, 1, 1);
plot(t, x_clean); title('Clean Signal'); grid on;
subplot(3, 1, 2);
plot(t, noise); title('Gaussian Noise'); grid on;
subplot(3, 1, 3);
plot(t, x_noisy); title('Noisy Signal'); grid on;

Fs = 200;
Ts = 1/Fs;
ts = 0:Ts:2;
xs_clean = sin(2*pi*5*ts) + 0.5*sin(2*pi*40*ts);
noise_s = 0.3 * randn(size(ts));
xs = xs_clean + noise_s;

figure;
stem(ts, xs, 'MarkerSize', 3);
title('Sampled Noisy Sequence x[n]');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

N_fft = length(xs);
X = abs(fftshift(fft(xs))) / N_fft;
f = (-N_fft/2:N_fft/2-1) * (Fs/N_fft);

figure;
plot(f, X);
title('FFT Magnitude of Sampled Noisy Signal');
xlabel('Frequency (Hz)');
xlim([-100 100]);
grid on;

y3 = filter(ones(1, 3)/3, 1, xs);
y7 = filter(ones(1, 7)/7, 1, xs);
y15 = filter(ones(1, 15)/15, 1, xs);

figure;
subplot(3, 1, 1);
stem(ts, y3, 'MarkerSize', 3); title('Filtered with N=3'); grid on;
subplot(3, 1, 2);
stem(ts, y7, 'MarkerSize', 3); title('Filtered with N=7'); grid on;
subplot(3, 1, 3);
stem(ts, y15, 'MarkerSize', 3); title('Filtered with N=15'); grid on;

yr3 = zeros(size(t));
for k = 1:length(ts)
    yr3 = yr3 + y3(k) * sinc((t - ts(k)) / Ts);
end

figure;
plot(t, x_clean);
hold on;
plot(t, yr3, 'r', 'LineWidth', 1.5);
title('Reconstructed Signal (Sinc from N=3 filtered samples)');
legend('Clean Original', 'Reconstructed Filtered');
grid on;
hold off;

%section5
Fs = 200;
t = 0:1e-4:1;
x = sin(2*pi*20*t) + 0.7*sin(2*pi*180*t);

ts = 0:1/Fs:1;
xs = sin(2*pi*20*ts) + 0.7*sin(2*pi*180*ts);

N = length(xs);
Xs = abs(fftshift(fft(xs))) / N;
f_s = (-N/2:N/2-1) * (Fs/N);

figure;
plot(f_s, Xs, 'LineWidth', 1.5);
title('FFT of Sampled Signal (Without Anti-Aliasing)');
xlabel('Frequency (Hz)');
grid on;

Fc = 90;
Fs_sim = 10000;
[b, a] = butter(5, Fc / (Fs_sim/2), 'low');
x_filtered = filtfilt(b, a, x);

xs_aa = interp1(t, x_filtered, ts);

Xs_aa = abs(fftshift(fft(xs_aa))) / N;

figure;
plot(f_s, Xs_aa, 'LineWidth', 1.5);
title('FFT of Sampled Signal (WITH Anti-Aliasing Filter)');
xlabel('Frequency (Hz)');
grid on;