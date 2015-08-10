%% Generate pure sinusoidal signals with 1g amplitude but with changing frequency to identify the filter shape
%  Copyright (c) 2015, EveryFit, Inc.
%  Author:  Zhibiao Rao
%  Title:   Machine Learning Engineer
%  Email:   zrao@qmedichealth.com
%  Date:    Aug.6, 2015
close all; clear all; clc;
%% Step 1: Create pure sinusoidal artifical dataset
freq = 0:1/30:5;            % 151 frequencies
fs = 30;                    % Sampling frequency = 30Hz          
timesec = 0:1/fs:30*60;     % 30-minute long data
Testnum = linspace(5000,5000+length(freq)-1,length(freq));

for loop = 1:length(Testnum)
    Xacc = sin(2*pi*freq(loop)*timesec);
    File_Name = strcat('TestNo',num2str(Testnum(loop)),'.csv');
    %% -----------------Title of the data--------------------------------------
    fileID = fopen(File_Name, 'w') ;
    fprintf(fileID,'%6s\n','------------ Data File Created By ActiGraph GT3X+ ActiLife v6.11.8 Firmware v3.2.1 date format M/d/yyyy at 30 Hz  -----------');
    fprintf(fileID,'%6s\n','Serial Number: NEO1C04110486');
    fprintf(fileID,'%6s\n','Start Time 00:00:00');
    fprintf(fileID,'%6s\n','Start Date 11/19/2013');
    fprintf(fileID,'%6s\n','Epoch Period (hh:mm:ss) 00:00:00');
    fprintf(fileID,'%6s\n','Download Time 11:00:51');
    fprintf(fileID,'%6s\n','Download Date 7/27/2015');
    fprintf(fileID,'%6s\n','Current Memory Address: 0');
    fprintf(fileID,'%6s\n','Current Battery Voltage: 3.22     Mode = 12');
    fprintf(fileID,'%6s\n','--------------------------------------------------');
    fprintf(fileID,'%6s\n','Accelerometer X,Accelerometer Y,Accelerometer Z');
    %% -------------------Write the data to the .csv file----------------------  
    for loopfile = 1:length(Xacc)     
        fprintf(fileID,'%6.4f,%6.4f,%6.4f\n',Xacc(loopfile),0,0);          
    end
    fclose(fileID); 
end

