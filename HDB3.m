# Substitute 4 consecutive zeros with--"B00V" for even and "000V" for odd number of 1's count
clc;
clear all;
close all;

bits = [1 1 0 0 0 0 1 0 0 0 0 0 1 0 1 0];
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

subplot(2,1,1);
plot(time , signal, 'linewidth', 1);
axis([0 end_time -voltage-5 voltage+5]);
line([0 end_time], [0,0]);
title('Original Signal');
xlabel('Time');
ylabel('Amplitude');
grid on;

#MODULATION

count0 = 0;
count1 = 0;
for i = 1: length(bits)
	if bits(i)==0
		count0+=1;
	else
		count0=0;
		count1+=1;
	endif
	if count0==4
		bits(i) = -1;
		count0 = 0;
		if rem(count1, 2) == 0
			bits(i-3) = 1;
		endif
	endif
endfor

index = 1;
#Assuming previous state was positive
sign = 1;
if bits(1)==1
	sign=-1*sign;
endif

for i=1:length(time)

	if bits(index)==0
		modulation(i) = 0;
	else
		modulation(i) = voltage*sign;
	endif
	if time(i)*bitrate>=index
		index+=1;
		if index<= length(bits) && bits(index)== 1
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

#Initializing
index = 1;
for i = 1 : length(modulation)
	demodulation(index) = modulation(i)/voltage;
	if time(i)*bitrate >= index
		index+=1;
	endif
endfor

index=1;
last=1;
for i=1:length(bits)
	if demodulation(i)!=0
		if demodulation(i)==last
			demodulation(i) = 0;
			demodulation(i-3) = 0;
		else
			last = demodulation(i);
		endif
	endif
endfor

demodulation=abs(demodulation);
disp(demodulation);



