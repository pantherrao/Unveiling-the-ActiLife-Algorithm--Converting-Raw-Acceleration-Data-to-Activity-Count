%% Plot the mean difference +- standard deviation veruse ten Test No.
%  Copyright (c) 2015, EveryFit, Inc.
%  Author:  Zhibiao Rao
%  Title:   Machine Learning Engineer
%  Email:   zrao@qmedichealth.com
%  Date:    Aug.6, 2015
%%
clear all;close all;clc;
filename1 ={'130387641H60sec','181262504H60sec','181334802H60sec','181376491H60sec','130376709H60sec','130358515H60sec','130332731H60sec','130280262H60sec','130222768H60sec','130183854H60sec'};
filename2 = {'130387641HRAW','181262504HRAW','181334802HRAW','181376491HRAW','130376709HRAW','130358515HRAW','130332731HRAW','130280262HRAW','130222768HRAW','130183854HRAW'};

for loop = 1:length(filename1)
   % --------Loading .mat data--------------------------------------------
   tempfilename1 = strcat(filename1{loop},'.mat'); 
   loadfilename = strcat(pwd,'\',tempfilename1);
   load(loadfilename)
   %% -------------Mean and std of errors---------------------------------
   MeanErrX(loop) = mean(abs(XACount'-Xcount(1:length(XACount))));
   StdErrX(loop) = std(abs(XACount'-Xcount(1:length(XACount))));
   
   MeanErrY(loop) = mean(abs(YACount'-Ycount(1:length(YACount))));
   StdErrY(loop) = std(abs(YACount'-Ycount(1:length(YACount))));
   
   MeanErrZ(loop) = mean(abs(ZACount'-Zcount(1:length(ZACount))));
   StdErrZ(loop) = std(abs(ZACount'-Zcount(1:length(ZACount)))); 
   
   TempXAcount = sqrt(XACount.^2 +  YACount.^2 + ZACount.^2);
   TempXcount  = sqrt(Xcount.^2 +  Ycount.^2 + Zcount.^2);
   
   MaxXAcount(loop) = max(XACount);
   MaxYAcount(loop) = max(YACount);
   MaxZAcount(loop) = max(ZACount);
   MaxAcount(loop) = max(TempXAcount);
   
   MeanErr(loop) = mean(abs(TempXAcount'-TempXcount(1:length(TempXAcount))));
   StdErr(loop) = std(abs(TempXAcount'-TempXcount(1:length(TempXAcount))));
   %% -------------Plot---------------------------------------
    figure(loop) 
    set(gcf,'Position',[100,100,800,400], 'color','w');   
    plot(1:length(XACount),Xcount(1:length(XACount)),'-or');hold on;
    plot(1:length(XACount),XACount,'-*k');hold on;
    ylabel('Activity Count');xlabel('Minutes');grid on;
    %xlim([0 10]);%ylim([0 0.5]);
    legend('From Qmedic','From ActiLife','Location','northwest');improve_plot;tightfig;  

end
%% ----------------Plot Mean difference and standard deviation-------------
x = 1:10;
figure(100)
set(gcf,'Position',[100,100,800,400], 'color','w'); 
errorbar(x,MeanErrX,StdErrX,'-rx');hold on;
errorbar(x,MeanErrY,StdErrY,'-bo');hold on;
errorbar(x,MeanErrZ,StdErrZ,'-k*');hold on;
errorbar(x,MeanErr,StdErr,'-ms');hold on;
ylabel('Mean difference of count(count/min)');xlabel('Case No');grid on;
%xlim([0 10]);%ylim([0 0.5]);
legend('X direction','Y direction','Z direction','Vector Magnitude','Location','northeast');improve_plot;tightfig; 
%% ----------------Plot Mean difference and standard deviation for vector magnitude-------------
figure(102)
set(gcf,'Position',[100,100,800,400], 'color','w'); 
errorbar(x,MeanErr,StdErr,'-ms');hold on;
ylabel('Mean of count difference (count/min)');xlabel('Case No');grid on;
%xlim([0 10]);%ylim([0 0.5]);
legend('Vector Magnitude','Location','northeast');improve_plot;tightfig; 
%% ----------------Plot Mean difference and standard deviation for vector magnitude in percentage-------------
figure(103)
set(gcf,'Position',[100,100,800,400], 'color','w'); 
errorbar(x,MeanErr./MaxAcount*100,StdErr./MaxAcount*100,'-rs');hold on;
ylabel('Mean difference/max AC_{ActiLife} x%)');xlabel('Case No.');grid on;
%xlim([0 10]);%ylim([0 0.5]);
legend('Vector Magnitude','Location','northeast');improve_plot;tightfig; 