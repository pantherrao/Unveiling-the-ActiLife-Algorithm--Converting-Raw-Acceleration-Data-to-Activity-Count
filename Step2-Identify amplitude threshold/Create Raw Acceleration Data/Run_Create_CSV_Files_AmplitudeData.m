%% Generate pure sinusoidal signals with changing amplitude to identify the amplitude threshold
%  Copyright (c) 2015, EveryFit, Inc.
%  Author:  Zhibiao Rao
%  Title:   Machine Learning Engineer
%  Email:   zrao@qmedichealth.com
%  Date:    Aug.6, 2015

close all; clear all; clc;
%% Step 1: Create an artifical dataset
Amplitude = [0:0.005:0.1,0.2:0.1:1.0,1.5:0.2:10];   % Changing amplitude in g
fs = 30;                                            % Sampling frequency = 30Hz          
timesec = 0:1/fs:30*60;                             % 30-minutes data
Testnum = linspace(7000,7000+length(Amplitude)-1,length(Amplitude));

for loop = 1:length(Testnum)
    Xacc = Amplitude(loop)*sin(2*pi*0.77*timesec);  % 0.77Hz is the peak frequency
    
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

