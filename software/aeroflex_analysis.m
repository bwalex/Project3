%% only f
f = abs(i(44000:51999)+1i*q(44000:51999));
%f = abs(i(44000:44100)+1i*q(44000:44100));
%f = f(44000:51999);
%f = f(44000:45000);
%f = f-mean(f);
%f = f(1:100000);
figure(); plot(f);

%% FFT magic
%f = x-mean(x);
%f = x(1000:5000)-mean(x(1000:5000));
%f = f-mean(f);
ft = fft(f);
ftabs = abs(ft);

ax = ampl(ftabs);
fx = faxis(1.5e7, length(ax));

figure(); plot(fx, ax); hold on;
xlim([-5e6 5e6]);
ylim([0, 70]);

% If doing dB
%ylabel('Magnitude / dB');


XTicks = get(gca, 'Xtick');
set(gca, 'Xtick', XTicks);
[XTicks, prefix] = ImproveValues(XTicks);

grid on;

set(gca, 'Xticklabel', str2num(num2str(XTicks, 3)));
xlabel(['Frequency / ' prefix 'Hz'],'FontSize',11);

%% FFT magic
ft = fft(f);
ftabs = abs(ft);

ax = ampl(ftabs);
fx = faxis(1.5e7, length(ax));

figure(); plot(fx, ax); hold on;
xlim([-5e6 5e6]);
ylim([0, 70]);

% If doing dB
%ylabel('Magnitude / dB');


XTicks = get(gca, 'Xtick');
set(gca, 'Xtick', XTicks);
[XTicks, prefix] = ImproveValues(XTicks);

grid on;

set(gca, 'Xticklabel', str2num(num2str(XTicks, 3)));
xlabel(['Frequency / ' prefix 'Hz'],'FontSize',11);

%%
f = abs(i+1i*q);
t = 0:1/1.5e+07:(length(f)-1)*1/1.5e+07;
t = t';
iq = i+1i*q;
tf = [t(1:1000000) iq(1:1000000)];

%% Receiver
clear y
clear yt
clear Bit_stream
MC(1,1:32)= [3 1 1 0 0 0 0 0 0 1 1 1 0 1 1 1 1 0 1 0 1 1 1 0 0 1 1 0 1 1 0 0];
MC(2,1:32)= [3 1 0 0 1 1 1 0 0 0 0 0 0 1 1 1 0 1 1 1 1 0 1 0 1 1 1 0 0 1 1 0];
MC(3,1:32)= [3 1 1 0 1 1 0 0 1 1 1 0 0 0 0 0 0 1 1 1 0 1 1 1 1 0 1 0 1 1 1 0];
MC(4,1:32)= [3 1 1 0 0 1 1 0 1 1 0 0 1 1 1 0 0 0 0 0 0 1 1 1 0 1 1 1 1 0 1 0];
MC(5,1:32)= [3 0 1 0 1 1 1 0 0 1 1 0 1 1 0 0 1 1 1 0 0 0 0 0 0 1 1 1 0 1 1 1];
MC(6,1:32)= [3 1 1 1 1 0 1 0 1 1 1 0 0 1 1 0 1 1 0 0 1 1 1 0 0 0 0 0 0 1 1 1];
MC(7,1:32)= [3 1 1 1 0 1 1 1 1 0 1 0 1 1 1 0 0 1 1 0 1 1 0 0 1 1 1 0 0 0 0 0];
MC(8,1:32)= [3 0 0 0 0 1 1 1 0 1 1 1 1 0 1 0 1 1 1 0 0 1 1 0 1 1 0 0 1 1 1 0];
MC(9,1:32)= [3 0 0 1 1 1 1 1 1 0 0 0 1 0 0 0 0 1 0 1 0 0 0 1 1 0 0 1 0 0 1 1];
MC(10,1:32)=[3 0 1 1 0 0 0 1 1 1 1 1 1 0 0 0 1 0 0 0 0 1 0 1 0 0 0 1 1 0 0 1];
MC(11,1:32)=[3 0 0 1 0 0 1 1 0 0 0 1 1 1 1 1 1 0 0 0 1 0 0 0 0 1 0 1 0 0 0 1];
MC(12,1:32)=[3 0 0 1 1 0 0 1 0 0 1 1 0 0 0 1 1 1 1 1 1 0 0 0 1 0 0 0 0 1 0 1];
MC(13,1:32)=[3 1 0 1 0 0 0 1 1 0 0 1 0 0 1 1 0 0 0 1 1 1 1 1 1 0 0 0 1 0 0 0];
MC(14,1:32)=[3 0 0 0 0 1 0 1 0 0 0 1 1 0 0 1 0 0 1 1 0 0 0 1 1 1 1 1 1 0 0 0];
MC(15,1:32)=[3 0 0 0 1 0 0 0 0 1 0 1 0 0 0 1 1 0 0 1 0 0 1 1 0 0 0 1 1 1 1 1];
MC(16,1:32)=[3 1 1 1 1 0 0 0 1 0 0 0 0 1 0 1 0 0 0 1 1 0 0 1 0 0 1 1 0 0 0 1];

OC(1, 1:32)=[1 1 0 1 1 0 0 1 1 1 0 0 0 0 1 1 0 1 0 1 0 0 1 0 0 0 1 0 1 1 1 0];
OC(2, 1:32)=[1 1 1 0 1 1 0 1 1 0 0 1 1 1 0 0 0 0 1 1 0 1 0 1 0 0 1 0 0 0 1 0];

SC(1,1:4)=[0 0 0 0];
SC(2,1:4)=[0 0 0 1];
SC(3,1:4)=[0 0 1 0];
SC(4,1:4)=[0 0 1 1];
SC(5,1:4)=[0 1 0 0];
SC(6,1:4)=[0 1 0 1];
SC(7,1:4)=[0 1 1 0];
SC(8,1:4)=[0 1 1 01];
SC(9,1:4)=[1 0 0 0];
SC(10,1:4)=[1 0 0 1];
SC(11,1:4)=[1 0 1 0];
SC(12,1:4)=[1 0 1 1];
SC(13,1:4)=[1 1 0 0];
SC(14,1:4)=[1 1 0 1];
SC(15,1:4)=[1 1 1 0];
SC(16,1:4)=[1 1 1 1];

OFF = 7;
iq = i(43700:56000)+1i*q(43700:56000);

figure();
plot(real(iq), 'b');
hold on;
plot(imag(iq), 'r');
plot(abs(iq), 'k');

figure();
plot(angle(iq));

%

clear iqn;
m = 1;
for n=1:11000
    iqn(n) = iq(m);
    if mod(m, 15) == 0
        iqn(n) = mean(iq(m:m+1));
        m = m+1;
    end
    
    m = m+1;
end
iq = iqn;
start = OFF*10;


% XXX
% iq= Chip32(:,1)+ 1i*Chip32(:,2);
% OFF = 16;
% start=289;



yt = zeros(length(iq),1);
d2=[-1/10 1/9 -1/8 1/7 -1/6 1/5 -1/4 1/3 -1/2 1 0 -1 1/2 -1/3 1/4 -1/5 1/6 -1/7 1/8 -1/9 1/10];
% Demodulate
for n=start:length(iq)
    %yt(n) = imag(iq(n)*conj(iq(round(n-OFF))));
    % Polar discriminator
    %yt(n) = angle(iq(round(n))*conj(iq(n-OFF)));
    yt(n) = angle(iq(round(n-OFF))*conj(iq(n)));
    %yt(n) = angle(iq(n));
end

figure();
plot(yt);

% 
% yt = yt(start:length(yt));
% foo = conv(yt, d2, 'same');
% 
% y(1)=2;
% for n=1:round(length(yt)/OFF)-2
%     temp(n)=sum(foo(1+round(OFF*n):round(OFF*(n+1))));
%     if temp(n) > 0
%         y(n+1) = 1;
%     else
%         y(n+1) = 0;
%     end
% end

y(1)=2;
for n=1:round(length(yt)/OFF)-2
  temp(n)=sum(yt(1+round(OFF*n):round(OFF*(n+1))));
  if temp(n)>OFF
      y(n+1)=0;
  elseif temp(n)<-OFF
      y(n+1)=1;
  else
      y(n+1)=~y(n);% turn around the value of last chip
  end
end


%now decoding the bit stream.
%find the first 0 in all the secquence, and then use that index as the
%start index for the following decoding.
Start_index = 1
for n=1:length(y)-32
    tmp = y(n:n+32);
    cor(n) = dot(tmp(2:32),MC(1,2:32));
    if cor(n)>15
        Start_index = n
        break;
    end
end
%Start_index = 1
%%
clear cor
clear Bit_stream
%decoding all the following bit stream.
b=1;
bit_index = 1;
for m=Start_index:32:length(y)-32
    for n = 1:16
        cor(n) = dot(y(m+1:m+31),MC(n,2:32));
    end
    %cor
    [maxd,index]=max(cor);
    Bit_stream(bit_index:bit_index+3)= SC(index, 1:4);
    %Bit_stream(b)= index-1;

    bit_index = bit_index+4;
    b=b+1;
end



%% some random PLL stuff
Signal = abs(Rsc);

clear vco;
clear phi_hat;
clear e;

fc=2e9;%Carrier frequency
fs=32e9;%Sample frequency

%Initilize PLL Loop 
phi_hat(1)=30; 
e(1)=0; 
phd_output(1)=0; 
vco(1)=0; 
%Define Loop Filter parameters(Sets damping)
kp=0.15; %Proportional constant 
ki=0.1; %Integrator constant 
%PLL implementation

for n=2:length(Signal) 
    vco(n)=conj(exp(j*(2*pi*n*fc/fs+phi_hat(n-1))));%Compute VCO 
    phd_output(n)=imag(Signal(n)*vco(n));%Complex multiply VCO x Signal input 
    e(n)=e(n-1)+(kp+ki)*phd_output(n)-ki*phd_output(n-1);%Filter integrator 
    phi_hat(n)=phi_hat(n-1)+e(n);%Update VCO 
end;

%%
CS(1, 1:32) =[1 1 0 1 1 0 0 1 1 1 0 0 0 0 1 1 0 1 0 1 0 0 1 0 0 0 1 0 1 1 1 0];
CS(2, 1:32) =[1 1 1 0 1 1 0 1 1 0 0 1 1 1 0 0 0 0 1 1 0 1 0 1 0 0 1 0 0 0 1 0];
CS(3, 1:32) =[0 0 1 0 1 1 1 0 1 1 0 1 1 0 0 1 1 1 0 0 0 0 1 1 0 1 0 1 0 0 1 0];
CS(4, 1:32) =[0 0 1 0 0 0 1 0 1 1 1 0 1 1 0 1 1 0 0 1 1 1 0 0 0 0 1 1 0 1 0 1];
CS(5, 1:32) =[0 1 0 1 0 0 1 0 0 0 1 0 1 1 1 0 1 1 0 1 1 0 0 1 1 1 0 0 0 0 1 1];
CS(6, 1:32) =[0 0 1 1 0 1 0 1 0 0 1 0 0 0 1 0 1 1 1 0 1 1 0 1 1 0 0 1 1 1 0 0];
CS(7, 1:32) =[1 1 0 0 0 0 1 1 0 1 0 1 0 0 1 0 0 0 1 0 1 1 1 0 1 1 0 1 1 0 0 1];
CS(8, 1:32) =[1 0 0 1 1 1 0 0 0 0 1 1 0 1 0 1 0 0 1 0 0 0 1 0 1 1 1 0 1 1 0 1];
CS(9, 1:32) =[1 0 0 0 1 1 0 0 1 0 0 1 0 1 1 0 0 0 0 0 0 1 1 1 0 1 1 1 1 0 1 1];
CS(10, 1:32)=[1 0 1 1 1 0 0 0 1 1 0 0 1 0 0 1 0 1 1 0 0 0 0 0 0 1 1 1 0 1 1 1];
CS(11, 1:32)=[0 1 1 1 1 0 1 1 1 0 0 0 1 1 0 0 1 0 0 1 0 1 1 0 0 0 0 0 0 1 1 1];
CS(12, 1:32)=[0 1 1 1 0 1 1 1 1 0 1 1 1 0 0 0 1 1 0 0 1 0 0 1 0 1 1 0 0 0 0 0];
CS(13, 1:32)=[0 0 0 0 0 1 1 1 0 1 1 1 1 0 1 1 1 0 0 0 1 1 0 0 1 0 0 1 0 1 1 0];
CS(14, 1:32)=[0 1 1 0 0 0 0 0 0 1 1 1 0 1 1 1 1 0 1 1 1 0 0 0 1 1 0 0 1 0 0 1];
CS(15, 1:32)=[1 0 0 1 0 1 1 0 0 0 0 0 0 1 1 1 0 1 1 1 1 0 1 1 1 0 0 0 1 1 0 0];
CS(16, 1:32)=[1 1 0 0 1 0 0 1 0 1 1 0 0 0 0 0 0 1 1 1 0 1 1 1 1 0 1 1 1 0 0 0];


clear NOC;
clear f;

for n=1:16
    for m=1:32
        if CS(n, m) == 0
            CS(n, m) = -1;
        end
    end
end
        
for n=1:16
    f(n, 1) = NaN;
    for m=2:32
        f(n, m) = CS(n, m)*CS(n, m-1)*(-1)^(m);
        if f(n, m) == -1
            f(n, m) = 0;
        end
    end
end

f







































%% Receiver
clear y
clear yt
clear Bit_stream
MC(1,1:32)= [3 1 1 0 0 0 0 0 0 1 1 1 0 1 1 1 1 0 1 0 1 1 1 0 0 1 1 0 1 1 0 0];
MC(2,1:32)= [3 1 0 0 1 1 1 0 0 0 0 0 0 1 1 1 0 1 1 1 1 0 1 0 1 1 1 0 0 1 1 0];
MC(3,1:32)= [3 1 1 0 1 1 0 0 1 1 1 0 0 0 0 0 0 1 1 1 0 1 1 1 1 0 1 0 1 1 1 0];
MC(4,1:32)= [3 1 1 0 0 1 1 0 1 1 0 0 1 1 1 0 0 0 0 0 0 1 1 1 0 1 1 1 1 0 1 0];
MC(5,1:32)= [3 0 1 0 1 1 1 0 0 1 1 0 1 1 0 0 1 1 1 0 0 0 0 0 0 1 1 1 0 1 1 1];
MC(6,1:32)= [3 1 1 1 1 0 1 0 1 1 1 0 0 1 1 0 1 1 0 0 1 1 1 0 0 0 0 0 0 1 1 1];
MC(7,1:32)= [3 1 1 1 0 1 1 1 1 0 1 0 1 1 1 0 0 1 1 0 1 1 0 0 1 1 1 0 0 0 0 0];
MC(8,1:32)= [3 0 0 0 0 1 1 1 0 1 1 1 1 0 1 0 1 1 1 0 0 1 1 0 1 1 0 0 1 1 1 0];
MC(9,1:32)= [3 0 0 1 1 1 1 1 1 0 0 0 1 0 0 0 0 1 0 1 0 0 0 1 1 0 0 1 0 0 1 1];
MC(10,1:32)=[3 0 1 1 0 0 0 1 1 1 1 1 1 0 0 0 1 0 0 0 0 1 0 1 0 0 0 1 1 0 0 1];
MC(11,1:32)=[3 0 0 1 0 0 1 1 0 0 0 1 1 1 1 1 1 0 0 0 1 0 0 0 0 1 0 1 0 0 0 1];
MC(12,1:32)=[3 0 0 1 1 0 0 1 0 0 1 1 0 0 0 1 1 1 1 1 1 0 0 0 1 0 0 0 0 1 0 1];
MC(13,1:32)=[3 1 0 1 0 0 0 1 1 0 0 1 0 0 1 1 0 0 0 1 1 1 1 1 1 0 0 0 1 0 0 0];
MC(14,1:32)=[3 0 0 0 0 1 0 1 0 0 0 1 1 0 0 1 0 0 1 1 0 0 0 1 1 1 1 1 1 0 0 0];
MC(15,1:32)=[3 0 0 0 1 0 0 0 0 1 0 1 0 0 0 1 1 0 0 1 0 0 1 1 0 0 0 1 1 1 1 1];
MC(16,1:32)=[3 1 1 1 1 0 0 0 1 0 0 0 0 1 0 1 0 0 0 1 1 0 0 1 0 0 1 1 0 0 0 1];

OC(1, 1:32)=[1 1 0 1 1 0 0 1 1 1 0 0 0 0 1 1 0 1 0 1 0 0 1 0 0 0 1 0 1 1 1 0];
OC(2, 1:32)=[1 1 1 0 1 1 0 1 1 0 0 1 1 1 0 0 0 0 1 1 0 1 0 1 0 0 1 0 0 0 1 0];

SC(1,1:4)=[0 0 0 0];
SC(2,1:4)=[0 0 0 1];
SC(3,1:4)=[0 0 1 0];
SC(4,1:4)=[0 0 1 1];
SC(5,1:4)=[0 1 0 0];
SC(6,1:4)=[0 1 0 1];
SC(7,1:4)=[0 1 1 0];
SC(8,1:4)=[0 1 1 01];
SC(9,1:4)=[1 0 0 0];
SC(10,1:4)=[1 0 0 1];
SC(11,1:4)=[1 0 1 0];
SC(12,1:4)=[1 0 1 1];
SC(13,1:4)=[1 1 0 0];
SC(14,1:4)=[1 1 0 1];
SC(15,1:4)=[1 1 1 0];
SC(16,1:4)=[1 1 1 1];

OFF = 7;
iq = i(43700:56000)+1i*q(43700:56000);
%iq = awgn(iq, 20);

figure();
plot(real(iq), 'b');
hold on;
plot(imag(iq), 'r');
%plot(abs(iq), 'k');

%figure();
%plot(angle(iq));

% Decimate
clear iqn;
m = 1;
for n=1:11000
    iqn(n) = iq(m);
    if mod(m, 15) == 0
        iqn(n) = mean(iq(m:m+1));
        m = m+1;
    end
    
    m = m+1;
end
iq = iqn;
start = OFF*10;



yt = zeros(length(iq),1);

% Demodulate
for n=start:length(iq)
    % normalize

    prev = iq(round(n-OFF));
    i_1 = real(prev);
    q_1 = imag(prev);
    i_2 = real(iq(n));
    q_2 = imag(iq(n));
    
    x = (i_1 * i_2 + q_1 * q_2);
    y = (i_2 * q_1 - i_1 * q_2);
    x = double(fi(x, 1, 4, 3));
    y = double(fi(y, 1, 4, 3));
    y_abs = abs(y);

    if (x) > 0
        % for Quadrant 1
        %r = (i_1*i_2 + q_1*q_2 - i_2*q_1 + i_1*q_2) / (i_1*i_2 + q_1*q_2 + i_2*q_1 - i_1*q_2);
        r = (x-y_abs)/(x+y_abs);
        yt(n) = pi/4 - pi/4*r;
        % Q4
        if (y) < 0
            yt(n) = -yt(n);
        end
    else
        % for Quadrant 2
        %r = (i_1*i_2 + q_1*q_2 + i_2*q_1 - i_1*q_2) / (i_2*q_1 - i_1*q_2 - i_1*i_2 - q_1*q_2);
        r = (x+y_abs)/(y_abs-x);
        yt(n) = 3*pi/4 - pi/4*r;
        % Q3
        if (y) < 0
            yt(n) = -yt(n);
        end
    end
    yt(n) = atan2(y, x);
end

figure();
plot(yt);
%ylim([-3 3]);



y(1)=2;
for n=1:round(length(yt)/OFF)-2
  temp(n)=sum(yt(1+round(OFF*n):round(OFF*(n+1))));
  if temp(n)>OFF
      y(n+1)=0;
  elseif temp(n)<-OFF
      y(n+1)=1;
  else
      y(n+1)=~y(n);% turn around the value of last chip
  end
end


%now decoding the bit stream.
%find the first 0 in all the secquence, and then use that index as the
%start index for the following decoding.
Start_index = 1
for n=1:length(y)-32
    tmp = y(n:n+32);
    cor(n) = dot(tmp(2:32),MC(1,2:32));
    if cor(n)>15
        Start_index = n
        break;
    end
end
%Start_index = 1
%%
clear cor
clear Bit_stream
%decoding all the following bit stream.
b=1;
bit_index = 1;
for m=Start_index:32:length(y)-32
    for n = 1:16
        cor(n) = dot(y(m+1:m+31),MC(n,2:32));
    end
    %cor
    [maxd,index]=max(cor);
    Bit_stream(bit_index:bit_index+3)= SC(index, 1:4);
    %Bit_stream(b)= index-1;

    bit_index = bit_index+4;
    b=b+1;
end






























%% Receiver (all-in-one)
clear y
clear yt
clear Bit_stream
MC(1,1:32)= [3 1 1 0 0 0 0 0 0 1 1 1 0 1 1 1 1 0 1 0 1 1 1 0 0 1 1 0 1 1 0 0];
MC(2,1:32)= [3 1 0 0 1 1 1 0 0 0 0 0 0 1 1 1 0 1 1 1 1 0 1 0 1 1 1 0 0 1 1 0];
MC(3,1:32)= [3 1 1 0 1 1 0 0 1 1 1 0 0 0 0 0 0 1 1 1 0 1 1 1 1 0 1 0 1 1 1 0];
MC(4,1:32)= [3 1 1 0 0 1 1 0 1 1 0 0 1 1 1 0 0 0 0 0 0 1 1 1 0 1 1 1 1 0 1 0];
MC(5,1:32)= [3 0 1 0 1 1 1 0 0 1 1 0 1 1 0 0 1 1 1 0 0 0 0 0 0 1 1 1 0 1 1 1];
MC(6,1:32)= [3 1 1 1 1 0 1 0 1 1 1 0 0 1 1 0 1 1 0 0 1 1 1 0 0 0 0 0 0 1 1 1];
MC(7,1:32)= [3 1 1 1 0 1 1 1 1 0 1 0 1 1 1 0 0 1 1 0 1 1 0 0 1 1 1 0 0 0 0 0];
MC(8,1:32)= [3 0 0 0 0 1 1 1 0 1 1 1 1 0 1 0 1 1 1 0 0 1 1 0 1 1 0 0 1 1 1 0];
MC(9,1:32)= [3 0 0 1 1 1 1 1 1 0 0 0 1 0 0 0 0 1 0 1 0 0 0 1 1 0 0 1 0 0 1 1];
MC(10,1:32)=[3 0 1 1 0 0 0 1 1 1 1 1 1 0 0 0 1 0 0 0 0 1 0 1 0 0 0 1 1 0 0 1];
MC(11,1:32)=[3 0 0 1 0 0 1 1 0 0 0 1 1 1 1 1 1 0 0 0 1 0 0 0 0 1 0 1 0 0 0 1];
MC(12,1:32)=[3 0 0 1 1 0 0 1 0 0 1 1 0 0 0 1 1 1 1 1 1 0 0 0 1 0 0 0 0 1 0 1];
MC(13,1:32)=[3 1 0 1 0 0 0 1 1 0 0 1 0 0 1 1 0 0 0 1 1 1 1 1 1 0 0 0 1 0 0 0];
MC(14,1:32)=[3 0 0 0 0 1 0 1 0 0 0 1 1 0 0 1 0 0 1 1 0 0 0 1 1 1 1 1 1 0 0 0];
MC(15,1:32)=[3 0 0 0 1 0 0 0 0 1 0 1 0 0 0 1 1 0 0 1 0 0 1 1 0 0 0 1 1 1 1 1];
MC(16,1:32)=[3 1 1 1 1 0 0 0 1 0 0 0 0 1 0 1 0 0 0 1 1 0 0 1 0 0 1 1 0 0 0 1];

OC(1, 1:32)=[1 1 0 1 1 0 0 1 1 1 0 0 0 0 1 1 0 1 0 1 0 0 1 0 0 0 1 0 1 1 1 0];
OC(2, 1:32)=[1 1 1 0 1 1 0 1 1 0 0 1 1 1 0 0 0 0 1 1 0 1 0 1 0 0 1 0 0 0 1 0];

SC(1,1:4)=[0 0 0 0];
SC(2,1:4)=[0 0 0 1];
SC(3,1:4)=[0 0 1 0];
SC(4,1:4)=[0 0 1 1];
SC(5,1:4)=[0 1 0 0];
SC(6,1:4)=[0 1 0 1];
SC(7,1:4)=[0 1 1 0];
SC(8,1:4)=[0 1 1 01];
SC(9,1:4)=[1 0 0 0];
SC(10,1:4)=[1 0 0 1];
SC(11,1:4)=[1 0 1 0];
SC(12,1:4)=[1 0 1 1];
SC(13,1:4)=[1 1 0 0];
SC(14,1:4)=[1 1 0 1];
SC(15,1:4)=[1 1 1 0];
SC(16,1:4)=[1 1 1 1];

OFF = 7;
iq = i(43700:56000)+1i*q(43700:56000);
%iq = awgn(iq, 20);

figure();
plot(real(iq), 'b');
hold on;
plot(imag(iq), 'r');
%plot(abs(iq), 'k');

%figure();
%plot(angle(iq));

% Decimate
clear iqn;
m = 1;
for n=1:11000
    iqn(n) = iq(m);
    if mod(m, 15) == 0
        iqn(n) = mean(iq(m:m+1));
        m = m+1;
    end
    
    m = m+1;
end
iq = iqn;
start = OFF*8;



yt = zeros(length(iq),1);
yo(1)=2;
m = 1;

Start_index = 0;

% Demodulate
for n=start:length(iq)
    % normalize

    prev = iq(round(n-OFF));
    i_1 = real(prev);
    q_1 = imag(prev);
    i_2 = real(iq(n));
    q_2 = imag(iq(n));
    
    x = (i_1 * i_2 + q_1 * q_2);
    y = (i_2 * q_1 - i_1 * q_2);
    % Trim to fixed-point precision (1QN with 3 bits of fractional
    % precision)
    x = double(fi(x, 1, 4, 3));
    y = double(fi(y, 1, 4, 3));
    y_abs = abs(y);

    yt(n) = atan2(y, x);

    if mod(n, OFF) == 0
        if n > start+OFF
            temp = sum(yt(n-OFF:n));
            disp 'Foo1'
            if (temp > OFF)
                yo(m+1) = 0;
            elseif (temp < -OFF)
                yo(m+1) = 1;
            else
                yo(m+1) = ~yo(m);
            end
            
            m = m + 1;
            
            % Find preamble
            if (m > 32)
                tmp = yo(m-32:m);
                cor = dot(tmp(2:32), MC(1, 2:32));
                if cor > 15
                    if Start_index == 0
                        Start_index = m-32;
                    end
                end
            end
            
        end
    end
end

y = yo;
figure();
plot(yt);
%ylim([-3 3]);


%%
clear cor
clear Bit_stream
%decoding all the following bit stream.
b=1;
bit_index = 1;
for m=Start_index:32:length(y)-32
    for n = 1:16
        cor(n) = dot(y(m+1:m+31),MC(n,2:32));
    end
    %cor
    [maxd,index]=max(cor);
    Bit_stream(bit_index:bit_index+3)= SC(index, 1:4);
    %Bit_stream(b)= index-1;

    bit_index = bit_index+4;
    b=b+1;
end