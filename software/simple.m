%% ADC only
% Convert adc_data to mV
d1 = adc_data * 2200/2^14;

% Create time line
t = (0:9.52381e-9:0.001);
t = t(1:length(adc_data));

figure();
plot(t, d1);
grid on;
XTicks = get(gca, 'Xtick');
set(gca, 'Xtick', XTicks);
[XTicks, prefix] = ImproveValues(XTicks);

set(gca, 'Xticklabel', str2num(num2str(XTicks, 3)));
xlabel(['Time / ' prefix 's'],'FontSize',11);

ylabel('Amplitude / mV');

%% FFT
exp = 7;
fft1 = fft_real + j.*fft_im;
fft1d = fft1.*exp;
afft1 = abs(fft1d);
afft1 = afft1*2200/2^14/65536*1000;
%afft1 = afft1*2.2/2^14*65536
a = ampl(afft1);

f = faxis(105e6); % 105 MSPS


% If doing mV
plot(f, a);

%If doing dB
%plot(f, 20*log10(a/1000));

xlim([-3e6 3e6]);

% If doing mV
ylabel('Amplitude / mV');
YTicks = get(gca, 'Ytick');
YTicks = sort([YTicks 110]); % add +-250 kHz
set(gca, 'Ytick', YTicks);

% If doing dB
%ylabel('Magnitude / dB');


XTicks = get(gca, 'Xtick');
XTicks = sort([XTicks 250e3 500e3 -250e3 -500e3 1.5e6 -1.5e6 2.5e6 -2.5e6]); % add +-250 kHz
set(gca, 'Xtick', XTicks);
[XTicks, prefix] = ImproveValues(XTicks);

grid on;

set(gca, 'Xticklabel', str2num(num2str(XTicks, 3)));
xlabel(['Frequency / ' prefix 'Hz'],'FontSize',11);
