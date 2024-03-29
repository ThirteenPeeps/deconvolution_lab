N_SAMP = 1024;

w = linspace(0, 2 * pi * (1 - 1 / N_SAMP), N_SAMP); 

h_n = zeros(N_SAMP, 1);
h_n(1 : 11) = 1;

x_n = zeros(N_SAMP, 1);
x_n(N_SAMP / 2 - 50 : N_SAMP / 2 + 50) = 1;

y_n = conv(x_n, h_n);
y_noise = y_n;
noise = y_n;

for i = 0:N_SAMP
noise(i+1) = 0.01*randn();
y_noise(i + 1) = y_n(i + 1) + noise(i+1);
end

noise_jw = fft(noise, N_SAMP);
Y_jw = fft(y_noise, N_SAMP);

H_jw = fft(h_n, N_SAMP);

H_jw_inv = 1 ./ H_jw;

deconv = ifft(noise_jw .* H_jw_inv);

figure(1)
plot(x_n, 'Marker', 'o', 'LineStyle', 'none');

figure(2)
plot(h_n, 'Marker', 'o', 'LineStyle', 'none');

figure(3)
plot(y_n, 'Marker', 'o', 'LineStyle', 'none');

figure(4)
plot(deconv, 'Marker', 'o', 'LineStyle', 'none');
