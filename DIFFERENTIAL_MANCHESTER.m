#Differential Manchester= 0-->inversion  1-->No inversion
clc;
clear all;
close all;

bits = [1 0 1 1 0 0 1];

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


#modulation

index = 1;

#Assuming previous state was positive
sign = 1;

if bits(1) == 0
	sign = -1*sign;
endif

for i = 1 : length(time)
	if time(i)*bitrate < index-(bitrate/2)
		modulation(i) = sign*voltage;
	else
		modulation(i) = -sign*voltage;
	endif

	if time(i)*bitrate >= index
		index+=1;
		if index <= length(bits) && bits(index) == 1
			sign=-1*sign;
		endif
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
last = voltage;

for i = 1 : length(modulation)
	if time(i)*bitrate < index-(bitrate/2)
		if modulation(i) == last
			demodulation(index) = 1;
		else
			demodulation(index) = 0;
		endif
	endif

	if time(i)*bitrate >= index
		last = modulation(i);
		index+=1
	endif
endfor

disp(demodulation);






