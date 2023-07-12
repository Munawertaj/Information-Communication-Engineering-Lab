clc;
clear all;
close all;

bits = [1 0 0 1 0 1 1 0 1 1 1 0];
bitrate = 1;
voltage = 5;

sampling_rate = 1000;
sampling_time = 1/sampling_rate;

start_time = 0;
end_time = length(bits)/bitrate;
time = start_time:sampling_time:end_time;

#Original Signal
index = 1;
for i = 1: length(time)
	if bits(index) == 1
		signal(i) = voltage;
	else
		signal(i) = 0;
	endif
	if time(i)*bitrate >= index
		index+=1;
	endif
endfor

subplot(3,1,1);
plot(time , signal, 'linewidth', 1);
axis([0 end_time -voltage-5 voltage+5]);
line([0 end_time], [0,0]);
title('Original Signal');
xlabel('Time');
ylabel('Amplitude');
grid on;

#Carrier Signal

a = 3; #Amplitude
f = 2; #Frequency
carrier = a*sin(2*pi*f*time);

subplot(3,1,2);
plot(time , carrier, 'linewidth', 1);
axis([0 end_time -a-2 a+2]);
line([0 end_time], [0,0]);
title('Carier Signal');
xlabel('Time');
ylabel('Amplitude');
grid on;

#MODULATION

index = 1;
modulation = carrier;

for i = 1:length(time)
    if bits(index) == 0
        modulation(i) = 0;
    endif
    if time(i)*bitrate >= index
        index = index+1;
    endif
endfor

subplot(3,1,3);
plot(time , modulation, 'linewidth', 1);
axis([0 end_time -a-2 a+2]);
line([0 end_time], [0,0]);
title('Modulated Signal');
xlabel('Time');
ylabel('Amplitude');
grid on;


#DEMODULATION
index = 1;

for i = 1:length(modulation)
    if modulation(i) != 0
        demodultaion(index) = 1;
    else
        demodultaion(index) = 0;
    endif
    if time(i)*bitrate >= index
        index = index+1;
    endif
endfor

disp(demodultaion);



