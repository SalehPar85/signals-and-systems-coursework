%part1_a
load splat
y = y(1:8192);
N = 8192;
fs = 8192;
Y = fftshift(fft(y));
w = [-pi:2*pi/N:pi-pi/N]*fs;
figure;
plot(w, abs(Y));
title('Magnitude of CTFT of y(t)');
xlabel('Frequency (rad/s)');
ylabel('|Y(j\omega)|');

%part1_b
Y1 = conj(Y);
y1 = real(ifft(fftshift(Y1)));
sound(y1, fs);
pause(2);

%part1_d&e
Y2 = abs(Y);
y2 = real(ifft(fftshift(Y2)));
sound(y2, fs);

pause(2);

Y3 = exp(1j * angle(Y));
y3 = real(ifft(fftshift(Y3)));
sound(y3, fs);
pause(2);

%part1_g&h
y4 = zeros(N, 1);
y4(1:N/2) = y(1:2:N);
sound(y4, fs);
pause(2);

Y4 = fftshift(fft(y4));
figure;
plot(w, abs(Y4));
title('Magnitude of CTFT of y_4(t) = y(2t)');
xlabel('Frequency (rad/s)');
ylabel('|Y_4(j\omega)|');

%part_i&j&k
x = zeros(2*N, 1);
x(1:2:end) = y(:); 

h = [1 2 1]/2;
y5 = filter(h, 1, x);

sound(y5, fs);
pause(2);

Y5 = fftshift(fft(y5));

w_new = [-pi : 2*pi/(2*N) : pi - 2*pi/(2*N)] * fs;

figure;
plot(w_new, abs(Y5));
title('Magnitude of CTFT of y_5(t) = y(t/2)');
xlabel('Frequency (rad/s)');
ylabel('|Y_5(j\omega)|');


%part2_a
load ctftmod.mat

z = [dash dash dot dot];
tz = t(1:length(z));
figure;
plot(tz, z);
title('Morse Code for Letter Z');
xlabel('Time (s)');
ylabel('Amplitude');

%part2_b
figure;
freqs(bf, af);
title('Frequency Response of Lowpass Filter');

%part2_c
ydash = lsim(bf, af, dash, t(1:length(dash)));
ydot = lsim(bf, af, dot, t(1:length(dot)));

figure;
subplot(2,1,1);
plot(t(1:length(dash)), dash, 'b', t(1:length(dash)), ydash, 'r--');
title('Original and Filtered Dash');
legend('Original', 'Filtered');

subplot(2,1,2);
plot(t(1:length(dot)), dot, 'b', t(1:length(dot)), ydot, 'r--');
title('Original and Filtered Dot');
legend('Original', 'Filtered');

%part2_d
y_mod = dash .* cos(2*pi*f1*t(1:length(dash)));
y0 = lsim(bf, af, y_mod, t(1:length(dash)));

figure;
subplot(2,1,1);
plot(t(1:length(dash)), y_mod);
title('Modulated Signal y(t)');

subplot(2,1,2);
plot(t(1:length(dash)), y0);
title('Filtered Modulated Signal y_0(t)');

%part2_f
v1 = x .* cos(2*pi*f1*t);
m1_filtered = lsim(bf, af, v1, t);
m1 = 2 * m1_filtered;

figure;
plot(t, m1);
title('Demodulated Message m_1(t)');
xlabel('Time (s)');
ylabel('Amplitude');

%part2_g
v2 = x .* sin(2*pi*f2*t);
m2_filtered = lsim(bf, af, v2, t);
m2 = 2 * m2_filtered;

v3 = x .* sin(2*pi*f1*t);
m3_filtered = lsim(bf, af, v3, t);
m3 = 2 * m3_filtered;

figure;
subplot(2,1,1);
plot(t, m2);
title('Demodulated Message m_2(t)');

subplot(2,1,2);
plot(t, m3);
title('Demodulated Message m_3(t)');