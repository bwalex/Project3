% Convert adc_data to mV
d1 = adc_data * 2200/2^14;

% Create time line
t = (0:9.52381e-9:0.001);
t = t(1:length(adc_data));

plot(t, d1);
grid on;
XTicks = get(gca, 'Xtick');
set(gca, 'Xtick', XTicks);
[XTicks, prefix] = ImproveValues(XTicks);

set(gca, 'Xticklabel', str2num(num2str(XTicks, 3)));
xlabel(['Time / ' prefix 's'],'FontSize',11);

ylabel('Amplitude / mV');