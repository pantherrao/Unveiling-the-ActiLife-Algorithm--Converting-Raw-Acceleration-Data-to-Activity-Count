function [xAcc,yAcc,zAcc] = Fun_Read_Raw_Acceleration_Data(load_path)
%% Function to read raw acceleration data
%  Copyright (c) 2015, EveryFit, Inc.
%  Author:  Zhibiao Rao
%  Title:   Machine Learning Engineer
%  Email:   zrao@qmedichealth.com
%  Date:    Aug.6, 2015
%%
%clc; clear all; close all
delimiterIn = ',';
data = importdata(load_path,delimiterIn); % import raw data into Matlab
% ---------data in numeric form-----------------
header = data.textdata(1,:);        % 'HEADER_TIME_STAMP'    'X'    'Y'    'Z'
rawdata = data.data;                % data(:,1) for x-acc, data(:,2) for y-acc, data(:,3) for z-acc
timestamp = data.textdata(2:end,1); % time stamp:  '2011-10-13 18:00:00.013'
%%
lent = length(rawdata(:,1));
Samplingfreq = 30; 
timeinsecond = [0:lent-1]/Samplingfreq;
xAcc = rawdata(:,1);
yAcc = rawdata(:,2);
zAcc = rawdata(:,3);

