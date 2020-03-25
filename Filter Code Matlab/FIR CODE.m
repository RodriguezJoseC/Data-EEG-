%% Programacion del filtro digital de blackman %%
% Orden 81 

%% load Data %%
load ('k3b.mat');    %% Mention Name of Data
 trial = HDR.TRIG;
 Fs = 250;           %% Sample Rate
 O = 79;             %% Orden Filter
 
%% Channel EEG  %%
C4 = s(:,34);

%% Design Of Filter Blackman 

h = fir1(O,[8 13]/(Fs/2),blackman(O+1))
figure(22),freqz(h,1,Fs,Fs);

trial = HDR.TRIG;
for i=2:2 %length(trial)               
   
   CC3 = C3( trial(i) : trial(i) + 7*Fs-1  );
   
   %%CC3 = C4( trial(i) : trial(i) + 7*Fs-1  );
   
    if isnan(sum(CC3))==1, disp('hay un NaN'),end
    
    fc3 = filter( h , 1, CC3 );
    N = power(2,11);
    grid on 
    
    
    tc3 = abs( fft ( CC3 , N )) / N;
    tfc3 = abs( fft ( fc3 , N )) / N;
    F = linspace(0,Fs,N);
    
    figure(11), subplot(211),  plot(F,tc3); 
    grid on
    xlabel('Frecuencia(Hz)')
    ylabel('Potencia')
    figure(11), subplot(212), plot(F,tfc3)
     grid on
    xlabel('Frecuencia(Hz)')
    ylabel('Potencia')

     t = linspace(0,7,7*Fs);
    figure(1), subplot(211),  plot(t,CC3); 
     xlabel('Tiempo (s)')
     ylabel('Amplitud del Canal C4 ')
     grid on
    figure(1), subplot(212), plot(t,fc3);
     xlabel('Tiempo (s)')
     ylabel('Amplitude del Canal C4') 
     grid on  
    
end