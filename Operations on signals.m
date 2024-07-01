Fs = input('Enter the sampling frequency of the signal:');
Start_time = input('Enter the start time of the time scale:');
End_time = input('Enter the end time of the time scale:');
Breakpoints = input('Enter the number of breakpoints: ');

Position=zeros(1,Breakpoints);
if (Breakpoints == 0)
    Position = [];
else 
   for i = 1:Breakpoints
    Position(i) = input(['Enter position of breakpoint (', num2str(i), '):' ]);
   end
end

disp('1-DC signal');
disp('2-Ramp signal');
disp('3-General order polynomial');
disp('4-Exponential signal');
disp('5-sinusoidal signal');
disp('6-sinc function');
disp('7-triangle pulse');

T = linspace(Start_time,End_time,(End_time-Start_time)*Fs);
Y = [];

z = [Start_time Position End_time];
 
for i = 1: Breakpoints + 1
    signal_type = input(['Enter the number of the type of signal (' num2str(i) '): ']);

    t = linspace(z(i),z(i+1),(z(i+1)-z(i))*Fs);
    
    switch signal_type
        case 1
            amplitude = input('Enter the amplitude: ');
             y = amplitude*ones(1,(z(i+1)- z(i))*Fs);
             
        case 2
            slope = input('Enter the slope: ');
            intercept = input('Enter the intercept: ');
            y = slope*t + intercept;
            
        case 3
            amplitude = input('Enter the amplitude: ');     
            power = input('Enter the power: ');
            intercept = input('Enter the intercept: ');
             y = amplitude*(t.^power)+ intercept;
             
        case 4
            amplitude = input('Enter the amplitude: ');
            exponent = input('Enter the exponent: ');
            y = amplitude*exp(exponent*t);
        case 5
            amplitude = input('Enter the amplitude: ');
            frequency = input('Enter the frequency: ');
            phase = input('Enter the phase: ');
            y = amplitude*sin((2*pi*frequency*t)+phase);            
        case 6
            amplitude = input('Enter the amplitude: ');
            center_shift = input('Enter the center shift: ');
             y =amplitude * sinc(t - center_shift);
        case 7
            amplitude = input('Enter the amplitude: ');
            center_shift = input('Enter the center shift: ');
            width = input('Enter the width: ');
            y = amplitude * tripuls(t- center_shift, width);

        otherwise
            error('Invalid signal type');
    end
        Y = [Y y] ;
end 

figure;
plot(T,Y)   
grid on

while true
    disp('1-amplitude Scaling');
    disp('2-time reversal');
    disp('3-time shift');
    disp('4-time Scale (Expanding & Compressing the signal)');
    disp('5-clipping the signal');
    disp('6-the first derivative of the signal');
    disp('7-None');

    operation_number = input('Enter the number of the operation to be perform on the signal');
    
    switch operation_number
        case 1
            Amplitude_scaling = input('Enter the scale value: ');
            Ynew = Y*Amplitude_scaling;
            figure;
            plot(T,Ynew)
            grid on
        case 2
            Tnew = T*-1;
            figure;
            plot(Tnew,Y)
            grid on
        case 3
            Time_shift = input('Enter the shift value: ');
            Tnew = T+Time_shift;
            figure;
            plot(Tnew,Y)
            grid on
            
        case 4
            scaling_value = input('Enter the scaling value:  ');
            Tnew = T/scaling_value;
            figure;
            plot(Tnew,Y)
            grid on
        case 5
            Upper = input('upper clipping value :  ');
            Lower = input('lower clipping value :  ');
            IU=find(Y>Upper);
            Y(IU)= Upper;
            IL=find(Y<Lower);
            Y(IL)= Lower;
            figure;
            plot(T,Y)
            grid on
        case 6
            Ynew = Fs*diff(Y);
            figure;
            plot(Ynew)
            grid on
         case 7
             break
    end

end
