%% Run all 20-day datasets and get the activity counts from raw acceleration data
%  Copyright (c) 2015, EveryFit, Inc.
%  Author:  Zhibiao Rao
%  Title:   Machine Learning Engineer
%  Email:   zrao@qmedichealth.com
%  Date:    Aug.6, 2015
%%
clear all;close all;clc;
filename1 ={'130387641H60sec','181262504H60sec','181334802H60sec','181376491H60sec','130376709H60sec','130358515H60sec','130332731H60sec','130280262H60sec','130222768H60sec','130183854H60sec'};
filename2 = {'130387641HRAW','181262504HRAW','181334802HRAW','181376491HRAW','130376709HRAW','130358515HRAW','130332731HRAW','130280262HRAW','130222768HRAW','130183854HRAW'};

cd 'C:\Users\zhibiao\Desktop\CSV2GT3X\Many datasets'

for loop = 1:length(filename1)
   % ---Input the activity count from ActiLife--------------------------------
   tempfilename1 = strcat(filename1{loop},'.csv'); 
   filename = strcat(fileparts(pwd),'\Activity Count Output from ActiLife','\',tempfilename1);
   [YACount,XACount,ZACount,Steps1,Lux1,InclinometerOff,InclinometerStanding,InclinometerSitting,InclinometerLying] = Fun_Read_Activity_Count_From_Actilife(filename);

   %% --------raw acceleration data loading------------------
   tempfilename2 = strcat(filename2{loop}); 
   load_path = strcat(fileparts(pwd),'\Real Raw Acceleration Data','\',tempfilename2);
   [xAcc,yAcc,zAcc] = Fun_Read_Raw_Acceleration_Data(load_path);
   %% ---Converting raw data to activity counts-------------------
   [Xcount,NewXacc] = Fun_ActiLife_Filter_Parameter(xAcc,0.065,17.8); 
   [Ycount,NewYacc] = Fun_ActiLife_Filter_Parameter(yAcc,0.065,17.8);
   [Zcount,NewZacc] = Fun_ActiLife_Filter_Parameter(zAcc,0.065,17.8);
   %% -------------Mean and std of errors---------------------------------
   ErrMeanX(loop) = mean(XACount'-Xcount(1:length(XACount)));
   ErrStdX(loop) = std(XACount'-Xcount(1:length(XACount)));
   
   ErrMeanY(loop) = mean(YACount'-Ycount(1:length(YACount)));
   ErrStdY(loop) = std(YACount'-Ycount(1:length(YACount)));
   
   ErrMeanZ(loop) = mean(ZACount'-Zcount(1:length(ZACount)));
   ErrStdZ(loop) = std(ZACount'-Zcount(1:length(ZACount)));  
   %% -------------Plot---------------------------------------
    figure(loop) 
    set(gcf,'Position',[100,100,800,400], 'color','w');   
    plot(1:length(XACount),Xcount(1:length(XACount)),'-or');hold on;
    plot(1:length(XACount),XACount,'-*k');hold on;
    ylabel('Activity Count');xlabel('Minutes');grid on;
    %xlim([0 10]);%ylim([0 0.5]);
    legend('From Qmedic','From ActiLife','Location','northwest');improve_plot;tightfig;  
    %%
    filename = strcat(fileparts(pwd),filename1{loop},'.mat');
    save(filename)
end







% cd 'C:\Users\zhibiao\Desktop\CSV2GT3X\Real Data'
% filename = 'C:\Users\zhibiao\Desktop\CSV2GT3X\Real Data\ActivityCount.txt';
% % ---Input the activity count from ActiLife--------------------------------
% [FinalDay,FinalEpoch,XACount,YACount,ZACount,TotACount] = Fun_Import_ActivityCount(filename);
% NewTime = 0:length(TotACount)-1;
% %% --------raw acceleration data loading------------------
% [xAcc,yAcc,zAcc] = Fun_Raw_Acceleration_Data(file_name);
% %% --------Transfer acceleration to activity count with new filter---------
% StarMinute = 1; % 40-minute data
% EdMinute = 4730; % 40-minute data
% StarLocPoints = StarMinute*60*30;
% EdLocPoints = EdMinute*60*30;
% %[Xcount,NewYacc] = Fun_ActiLife_Filter(xAcc(StarLocPoints:EdLocPoints));
% 
% threshold = 0.08:0.001:0.1;
% scale = 18:0.1:20;
% for loop1 = 1:length(threshold)
%     for loop2 = 1:length(scale)
%         [Xcount,NewYacc] = Fun_ActiLife_Filter_Parameter(xAcc,threshold(loop1),scale(loop2));
%         
%         Error(loop1,loop2) = mean(YACount'-Xcount);
%     end
% end
% %%
% % Threshold =0.085; scale = 20;
% [r, c] = find(abs(Error) == min(min(abs(Error))));
% [Xcount,NewYacc] = Fun_ActiLife_Filter_Parameter(xAcc,threshold(r),scale(c));
% 
% figure(4) 
% set(gcf,'Position',[100,100,800,400], 'color','w');   
% plot(1:length(Xcount),Xcount,'-or');hold on;
% plot(1:length(Xcount),YACount,'-*k');hold on;
% ylabel('Activity Count');xlabel('Minutes');grid on;
% %xlim([0 10]);%ylim([0 0.5]);
% legend('From Qmedic','From ActiLife','Location','northwest');improve_plot;tightfig;  
% %%
% figure(5) 
% set(gcf,'Position',[100,100,800,400], 'color','w'); 
% surf(scale,threshold,abs(Error))
% ylabel('Threshold');xlabel('Scale');zlabel('Mean Error');improve_plot;tightfig; 
% %%
% Temp = Xcount -YACount';
% [f,x] = hist(abs(Temp),100);
% figure(6) 
% set(gcf,'Position',[100,100,800,400], 'color','w'); 
% bar(x,f/length(Xcount))
% xlabel('Activity Count Difference');ylabel('Percentage');zlabel('Mean Error');improve_plot;tightfig; 

