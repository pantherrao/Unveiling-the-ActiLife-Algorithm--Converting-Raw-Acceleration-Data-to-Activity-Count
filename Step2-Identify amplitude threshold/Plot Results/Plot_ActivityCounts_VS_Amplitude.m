%% Plot the activity count from ActiLife versus its input amplitude to find the amplitude threshold
%  Copyright (c) 2015, EveryFit, Inc.
%  Author:  Zhibiao Rao
%  Title:   Machine Learning Engineer
%  Email:   zrao@qmedichealth.com
%  Date:    Aug.6, 2015

close all; clear all; clc;
%% Step 1: Input the test name
Amplitude = [0:0.005:0.1,0.2:0.1:1.0,1.5:0.2:10];   % Changing amplitude in g
fs = 30;                                            % Sampling frequency = 30Hz          
Testnum = linspace(7000,7000+length(Amplitude)-1,length(Amplitude));

%%
for loop = 1:length(Testnum)
    File_Name = strcat('TestNo',num2str(Testnum(loop)),'60sec.csv');
    filename = strcat(fileparts(pwd),'\Activity Count Output from ActiLife','\',File_Name);
    [YACount,XACount,ZACount,Steps1,Lux1,InclinometerOff,InclinometerStanding,InclinometerSitting,InclinometerLying] = Fun_Read_Activity_Count_From_Actilife(filename);
 
    FinalActivityCount(loop) = mean(XACount(2:end));
end
%%
figure(1) 
set(gcf,'Position',[100,100,800,400], 'color','w');
plot(Amplitude,FinalActivityCount,'-k'); hold on;
plot([0.065 0.065],[0 7e4],'--r')
xlim([0, 7])
xlabel('Amplitude (g)'); ylabel('Activity Counts (count/min)'); grid on;
%legend('Original AC','location','southeast');
