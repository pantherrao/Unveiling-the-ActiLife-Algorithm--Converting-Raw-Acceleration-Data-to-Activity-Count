%% Apply the unveiled algorithm to the real acceleration data
%  Copyright (c) 2015, EveryFit, Inc.
%  Author:  Zhibiao Rao
%  Title:   Machine Learning Engineer
%  Email:   zrao@qmedichealth.com
%  Date:    Aug.6, 2015
%%
clear all;close all;clc;
% -----Loading Activity Count from ActiLife--------------------------------
Test_Name = strcat('320009309W60sec.csv');
filename = strcat(fileparts(pwd),'\Activity Count Output from ActiLife','\',Test_Name);
[YACount,XACount,ZACount,Steps1,Lux1,InclinometerOff,InclinometerStanding,InclinometerSitting,InclinometerLying] = Fun_Read_Activity_Count_From_Actilife(filename);
%% --------Read raw acceleration data------------------
load_path = strcat(fileparts(pwd),'\Real Raw Acceleration Data','\','320009309WRAW.csv');
[xAcc,yAcc,zAcc] = Fun_Read_Raw_Acceleration_Data(load_path);
%% --------Convert raw acceleration data to activity count with unveiled algorithm------

threshold = 0.065;
scale = 16:0.1:26;
for loop1 = 1:length(threshold)
    for loop2 = 1:length(scale)
        [Xcount,NewXacc] = Fun_ActiLife_Filter_Parameter(xAcc,threshold(loop1),scale(loop2));
        
        Error(loop1,loop2) = mean(XACount'-Xcount);
    end
end
%%  --------Plot the mean difference versus the weighting factor-----------
figure(1) 
set(gcf,'Position',[100,100,800,400], 'color','w');   
plot(scale,abs(Error),'-k');hold on;
ylabel('Mean difference of count(count/min)');xlabel('Weighting factor');grid on;
%xlim([0 10]);improve_plot;tightfig; 
ylim([-1 20]);improve_plot;tightfig; 
%legend('From Qmedic','Location','northwest');
%%  --------Compare the activity count from ActiLife and unveiled algorithm-----------
[Xcount,NewXacc] = Fun_ActiLife_Filter_Parameter(xAcc,threshold(1),17.8);
figure(2) 
set(gcf,'Position',[100,100,800,400], 'color','w');   
plot(1:length(Xcount),Xcount,'-or');hold on;
plot(1:length(Xcount),XACount,'-*k');hold on;
ylabel('Count/min in x-direction');xlabel('Minutes');grid on;
%xlim([0 10]);%ylim([0 0.5]);
legend('Present','From the ActiLife software','Location','northwest');improve_plot;tightfig;  

