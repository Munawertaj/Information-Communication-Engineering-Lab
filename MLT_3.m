# MLT-3
# 0--> no change
# 1--> (Case-1: currently positive or negative--> back to zero)
#      (Case-2: currently 0--> (previous positive--> go to negative)
#      (Case-2: currently 0--> (previous negative--> go to positive)

clc;
clear all;
close all;

bits = [0 1 0 1 1 0 1 1];
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
index = 1;
#Assuming last state was zero and previous non zero was negative
sign = 0;
last = -1;
#For last state was positive --> sign=1 ,last=1
#For last state was negative --> sign=1 ,last=1
if bits(1) == 1
	if sign==0
		last=-1*last;
		sign=last;
	else
		sign=0;
	endif
endif

for i = 1 : length(time)

	modulation(i) = sign*voltage;

	if time(i)*bitrate >= index
		index+=1;
		if index <= length(bits) && bits(index)== 1
			if sign==0
				last=-1*last;
				sign=last;
			else
				sign=0;
			endif
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

#DEMODULATION
index = 1;
last = 0;

for i = 1:length(modulation)
    if modulation(i) == last
        demodultaion(index) = 0;
    else
        demodultaion(index) = 1;
    endif
    if time(i)*bitrate >= index
        index = index+1;
        last = modulation(i);
    endif
endfor

disp(demodultaion);

