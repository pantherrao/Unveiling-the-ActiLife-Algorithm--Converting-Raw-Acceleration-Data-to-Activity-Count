%% Plot the activity count from ActiLife versus its input frequency
%  Copyright (c) 2015, EveryFit, Inc.
%  Author:  Zhibiao Rao
%  Title:   Machine Learning Engineer
%  Email:   zrao@qmedichealth.com
%  Date:    Aug.6, 2015

close all; clear all; clc;
%% Step 1: Input the test name
freq = 0:1/30:5;
Testnum = linspace(5000,5000+length(freq)-1,length(freq));
%%
for loop = 1:length(freq)
    File_Name = strcat('TestNo',num2str(Testnum(loop)),'60sec.csv');
    filename = strcat(fileparts(pwd),'\Activity Count Output from ActiLife','\',File_Name);
    [YACount,XACount,ZACount,Steps1,Lux1,InclinometerOff,InclinometerStanding,InclinometerSitting,InclinometerLying] = Fun_Read_Activity_Count_From_Actilife(filename);
 
    FinalActivityCount(loop) = mean(XACount(2:end));
end
%%
figure(1) 
set(gcf,'Position',[100,100,800,400], 'color','w');
plot(freq,FinalActivityCount/max(FinalActivityCount),'-k'); hold on;
xlim([0, 6])
xlabel('Frequency (Hz)'); ylabel('Normalized Activity Counts (counts/min)'); grid on;
%legend('Original AC','location','southeast');
