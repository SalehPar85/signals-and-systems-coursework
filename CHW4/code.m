%part1_a
R_vals = [0.5, 2, 5];
L = 1;
C = 1;
w0 = 1 / sqrt(L * C);
figure;
for i = 1:length(R_vals)
    R = R_vals(i);
    num = w0^2;
    den = [1, R/L, w0^2];
    sys = tf(num, den);
    
    [mag, phase, wout] = bode(sys);
    mag_db = 20*log10(squeeze(mag));
    phase_deg = squeeze(phase);
    
    subplot(2, 1, 1);
    hold on;
    semilogx(wout, mag_db, 'LineWidth', 1.5);
    
    subplot(2, 1, 2);
    hold on;
    semilogx(wout, phase_deg, 'LineWidth', 1.5);
end

subplot(2, 1, 1);
title('Bode Plot - Magnitude');
ylabel('Magnitude (dB)');
grid on;
legend('R=0.5', 'R=2', 'R=5');

subplot(2, 1, 2);
title('Bode Plot - Phase');
xlabel('Frequency (rad/s)');
ylabel('Phase (deg)');
grid on;
legend('R=0.5', 'R=2', 'R=5');

%part2_a
numG = [1];
denG = [1, 2, 0];
G = tf(numG, denG);

figure;
rlocus(G);
hold on;

K_vals = [0.5, 1, 4, 9];
colors = ['r', 'g', 'm', 'k'];

for i = 1:length(K_vals)
    T = feedback(K_vals(i)*G, 1);
    p = pole(T);
    plot(real(p), imag(p), 'o', 'MarkerSize', 8, 'Color', colors(i), 'LineWidth', 2);
end
hold off;

%part2_c
K_vals = [1, 4, 9];
sys_list = cell(1, 3);

for i = 1:3
    sys_list{i} = feedback(K_vals(i)*G, 1);
end

figure;
step(sys_list{1}, sys_list{2}, sys_list{3});
grid on;
legend('K=1', 'K=4', 'K=9');

%part3_b
N_vals = [3, 7, 15];

figure;
for i = 1:length(N_vals)
    N = N_vals(i);
    b = ones(1, N) / N;
    a = 1;
    subplot(1, 3, i);
    zplane(b, a);
    title(['Pole-Zero N=', num2str(N)]);
end

%part3_c
figure;
for i = 1:length(N_vals)
    N = N_vals(i);
    b = ones(1, N) / N;
    a = 1;
    [h, w] = freqz(b, a, 1024);
    plot(w/pi, abs(h), 'LineWidth', 1.5);
    hold on;
end
title('Frequency Response of Moving Average Filter');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Magnitude');
legend('N=3', 'N=7', 'N=15');
grid on;

%part3_d
n = 0:200;
w_noise = randn(1, length(n));
x = sin(pi * n / 16) + 0.5 * w_noise;

b7 = ones(1, 7) / 7;
a7 = 1;
y = filter(b7, a7, x);

figure;
plot(n, x, 'Color', [0.7 0.7 0.7]);
hold on;
plot(n, y, 'r', 'LineWidth', 2);
title('Signal Filtering Application (N=7)');
xlabel('n');
ylabel('Amplitude');
legend('Original Noisy Signal', 'Filtered Signal');
grid on;

%part4_a
b = [1, -0.5];
a = [1, -1, 0.5];

figure;
zplane(b, a);
title('Pole-Zero Map of H(z)');

%part4_b
[r, p, k] = residuez(b, a);

%part4_c
syms z n
H_sym = (1 - 0.5*z^(-1)) / (1 - z^(-1) + 0.5*z^(-2));
h_n_sym = iztrans(H_sym, z, n);
disp('h[n] using iztrans:');
disp(h_n_sym);

%part4_d
n_vals = 0:30;
sys = tf(b, a, -1);
[h, t] = impulse(sys, 30);

figure;
stem(n_vals, squeeze(h), 'filled');
title('Impulse Response h[n]');
xlabel('n');
ylabel('Amplitude');
grid on;

%part5_a&b
Fs = 1000;
t = 0:1/Fs:3;
ecg_clean = zeros(size(t));
for b = 0.4:0.8:3
    ecg_clean = ecg_clean + exp(-((t-b).^2)/(2*0.005^2));
end
noise = 0.4*sin(2*pi*50*t) + 0.1*randn(size(t));
ecg_noisy = ecg_clean + noise;

figure;
plot(t, ecg_clean + 2, 'b'); hold on;
plot(t, noise - 1, 'g');
plot(t, ecg_noisy, 'r');
title('Time Domain Signals');
legend('Clean ECG (Offset)', 'Noise (Offset)', 'Noisy ECG');
xlabel('Time (s)'); 
grid on;

L = length(t);
f = Fs*(0:(L/2))/L;
Y_noisy = fft(ecg_noisy);
P2_noisy = abs(Y_noisy/L);
P1_noisy = P2_noisy(1:L/2+1);
P1_noisy(2:end-1) = 2*P1_noisy(2:end-1);

figure;
plot(f, P1_noisy);
title('FFT of Noisy Signal');
xlabel('Frequency (Hz)'); 
ylabel('Magnitude');
xlim([0 100]); 
grid on;
xline(50, 'r--', '50 Hz Noise Peak');

%part5_c&d
f0 = 50;
Q = 35;
wo = f0/(Fs/2);
bw = wo/Q;
[b_notch, a_notch] = iirnotch(wo, bw);

figure;
zplane(b_notch, a_notch);
title('Pole-Zero of Notch Filter');

ecg_filtered = filtfilt(b_notch, a_notch, ecg_noisy);

Y_filt = fft(ecg_filtered);
P2_filt = abs(Y_filt/L);
P1_filt = P2_filt(1:L/2+1);
P1_filt(2:end-1) = 2*P1_filt(2:end-1);

figure;
plot(f, P1_noisy, 'b'); hold on;
plot(f, P1_filt, 'r', 'LineWidth', 1.5);
title('FFT Comparison');
legend('Before Filtering', 'After Filtering');
xlim([0 100]); 
grid on;

figure;
Q_vals = [5, 35, 100];
for i = 1:length(Q_vals)
    bw_q = wo/Q_vals(i);
    [bq, aq] = iirnotch(wo, bw_q);
    [h_q, w_q] = freqz(bq, aq, 1024, Fs);
    plot(w_q, 20*log10(abs(h_q)), 'LineWidth', 1.5); 
    hold on;
end
title('Notch Filter Frequency Response');
xlabel('Frequency (Hz)'); 
ylabel('Magnitude (dB)');
xlim([40 60]); 
ylim([-40 5]);
legend('Q=5', 'Q=35', 'Q=100'); 
grid on;