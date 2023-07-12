clc;
clear all;
close all;

bits = [1 0 0 1 0 1 0];

bitrate = 1;
voltage = 5;

sampling_rate = 1000;
sampling_time = 1/sampling_rate;

start_time = 0;
end_time = length(bits)/bitrate;
time = start_time : sampling_time : end_time;

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

subplot(2,1,1);
plot(time , signal, 'linewidth', 1);
axis([0 end_time -voltage-5 voltage+5]);
line([0 end_time], [0,0]);
title('Original Signal');
xlabel('Time');
ylabel('Amplitude');
grid on;


#Modulation

index = 1;

for i = 1 :length(time)
	if bits(index) == 0
		modulation(i) = voltage;
	else
		modulation(i) = (-1)*voltage;
	endif
	if time(i)*bitrate >= index
		index+=1;
	endif
endfor

subplot(2,1,2);
plot(time , modulation, 'linewidth', 1);
axis([0 end_time -voltage-5 voltage+5]);
line([0 end_time], [0,0]);
title('Modulated Signal');
xlabel('Time');
ylabel('Amplitude');
grid on;

#Demodulation

index = 1;

for i = 1: length(modulation)
	if modulation(i) == voltage
		demodulation(index) = 0;
	else
		demodulation(index) = 1;
	endif
	if time(i)*bitrate >= index
		index+=1;
	endif
endfor

disp(demodulation);

