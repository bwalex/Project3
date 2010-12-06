%% ADC only
% Convert adc_data to mV
d1 = adc_data_triangle_1MHz * 2200/2^14;

d1 = d1(1:2048);

% Create time line
t = (0:1/(105e6):0.001);
t = (0:9.52381e-9:0.001);
t = t(1:length(d1));

figure();
plot(t, d1, 'k-');
grid on; hold on;

XTicks = get(gca, 'Xtick');
set(gca, 'Xtick', XTicks);
[XTicks, prefix] = ImproveValues(XTicks);

set(gca, 'Xticklabel', str2num(num2str(XTicks, 3)));
xlabel(['Time / $' prefix ' s$'],'FontSize',11, 'Interpreter', 'none');

ylabel('Amplitude / $mV$','FontSize',11);


%
figure();

%windowing
window = hann(length(d1));
window = window';
d2 = d1.*window;


fft1 = fft(d1);
fft2 = fft(d2);


afft1 = abs(fft1)./length(fft1);
afft2 = abs(fft2)./length(fft2);




%ahann = zeros(length(afft1));
%for i=2:length(afft1)-1
%    ahann(i) = 0.5*(afft1(i) - 0.5*afft1(i-1) + afft1(i+1));
%end
%afft1 = ahann;
%ahann = conv(afft1, [0.25 0.5 0.25], 'same');
%afft1 = ahann;





a = ampl(afft1);
a2 = ampl(afft2);
f = faxis(105e6, length(fft1));
%If doing dB
plot(f, 20*log10(a/1000), 'k-.', 'DisplayName', 'Rectangular windowing');
hold on;
plot(f, 20*log10(a2/1000), 'k-', 'DisplayName', 'Hann windowing');

ylim([-100 -20]);
xlim([0e6 14e6]);

% If doing dB
ylabel('Magnitude / $dB$','FontSize',11, 'Interpreter', 'none');


XTicks = get(gca, 'Xtick');
XTicks = sort([XTicks 1000e3 5000e3 3000e3]); % add +-250 kHz
set(gca, 'Xtick', XTicks);
[XTicks, prefix] = ImproveValues(XTicks);

grid on;

set(gca, 'Xticklabel', str2num(num2str(XTicks, 3)));
xlabel(['Frequency / $' prefix 'Hz$'],'FontSize',11, 'Interpreter', 'none');




%%
figure();
%x = ones([1 2048]);
x = hann(2048)';

figure();
plot(x);

%
fft1 = fft(x)/2048;
afft1 = abs(fft1);
a = ampl(afft1);
afft1 = 20*log10(a);

plot(afft1);

%f = faxis(105e6, 2048); % 105 MSPS

%fft1 = conv(afft1, x);
%plot(a);


%%
N=128;
k=0:N-1;
 
dr = 100;
w = ones(1,N);
%w = hann(N)';
%w = 0.5 - 0.5*cos(2*pi*k/(N-1));

 
%B = N*sum(w.^2)/sum(w)^2;   % noise bandwidth (bins)
 
H = abs(fft([w zeros(1,7*N)]));
H = fftshift(H);
H = H/max(H);
H = 20*log10(H);
H = max(0,dr+H);

figure()
%plot(([1:(8*N)]-1-4*N)/8,H)
w = conv(ones(1, 8*128), H);
plot(w)
%stem(([1:(8*N)]-1-4*N)/8,H,'-');
set(findobj('Type','line'),'Marker','none','Color',[.871 .49 0])

xlim([-4*N 4*N]/8)


%% FFT
figure();
exp = 6;
fft1 = fft_real_sqw + j.*fft_im_sqw;
fft1d = fft1.*(2^exp) * 2200/2^14/2048 * 2;
afft1 = abs(fft1d);
%ahann = conv(afft1, [0.25 0.5 0.25], 'same');
%afft1 = ahann;

% kinda works
%afft1 = afft1*2200/2^14/65536*1000;


%afft1 = afft1*2.2/2^14*65536
a = ampl(afft1);

f = faxis(105e6, 2048); % 105 MSPS


% If doing mV
%plot(f, a);

%If doing dB
plot(f, 20*log10(a/1000), 'k');

xlim([0e6 14e6]);

% If doing mV
%ylabel('Amplitude / mV','FontSize',11);
%YTicks = get(gca, 'Ytick');
%YTicks = sort([YTicks 110]); % add +-250 kHz
%set(gca, 'Ytick', YTicks);

% If doing dB
ylabel('Magnitude / $dB$','FontSize',11);


XTicks = get(gca, 'Xtick');
XTicks = sort([XTicks 1e6 3e6 5e6]); % add +-250 kHz
set(gca, 'Xtick', XTicks);
[XTicks, prefix] = ImproveValues(XTicks);

grid on;

set(gca, 'Xticklabel', str2num(num2str(XTicks, 3)));
xlabel(['Frequency / $' prefix 'Hz$'],'FontSize',11);
