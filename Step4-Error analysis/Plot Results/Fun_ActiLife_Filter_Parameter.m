function [Xcount,NewXacc] = Fun_ActiLife_Filter_Parameter(Xacc,threshold,scale)
%% Using northeastern university real-time data to identify the weighting factor
%  Copyright (c) 2015, EveryFit, Inc.
%  Author:  Zhibiao Rao
%  Title:   Machine Learning Engineer
%  Email:   zrao@qmedichealth.com
%  Date:    Aug.6, 2015

%% close all; clear all; clc;
%% --------------Build the filter shape------------------------------------
FreqFilter = [0,0,944,3276,5512,7800,10104,11956,13752,15216,16640,17608,18504,19284,19920,20460,20912,21224,21528,21688,21920,21912,21952,22000,21936,21800,21824,21696,21544,21412,21120,21004,20816,20580,20296,20040,19752,19444,19120,18828,18400,18152,17832,17516,17152,16920,16488,16108,15768,15404,15000,14700,14424,14044,13704,13360,13032,12732,12368,12048,11640,11468,11160,10824,10576,10280,10008,9692,9440,9204,8880,8656,8496,8212,7992,8100,7496,7276,7056,6892,6640,6468,6264,6116,5976,5760,5568,5376,5200,5020,4920,4808,4632,4560,4368,4120,4080,3904,3744,3648,3600,3424,3384,3260,3064,3000,2896,2796,2712,2532,2520,2388,2272,2144,2112,2080,2048,1968,1824,1716,1560,1552,1488,1404,1272,1100,1224,1112,1008,888,800,732,696,648,600,540,488,420,336,216,0,0,0,0,0,0,0,0,0,0,0];
Temp = zeros(451,1);
Temp(1:151) = FreqFilter;
ActiLifeFilter = Temp/max(Temp);
%% ------------Transfer the time-domain acceleration data to frequency-domain data--------
fs = 30;                        % Sampling frequency = 30Hz          
Yacc = fft(Xacc);
%% ------------Order the FFT data--------
TempFilter = [ActiLifeFilter(end-1:-1:2);ActiLifeFilter(1);ActiLifeFilter(2:end)];
Frequency = -15:1/30:15;
Frequency = Frequency(2:end);
if mod(length(Xacc),2)==0  % the length of data is even
    NewFrequency = fs/2*linspace(0,1,floor(length(Xacc)/2));
    TemFrequency = [NewFrequency,-NewFrequency(end:-1:1)]; 
else                       % the length of data is odd
    NewFrequency = fs/2*linspace(0,1,floor(length(Xacc)/2)+1);
    TemFrequency = [NewFrequency,-NewFrequency(end:-1:2)];
end
%% -----------Apply the filter shape to its FFT data-----------------------
NewFilter = interp1(Frequency,TempFilter,TemFrequency); 
aIndex = find(isnan(NewFilter));
NewFilter(aIndex)=0;
YaccProduct = Yacc.*NewFilter';
NewXacc = real(ifft(YaccProduct));
%% -----------Apply the threshold to the post-filtered data----------------
NewXacc(abs(NewXacc)<threshold)=0;
%% -----------Scale up the post-filtered data------------------------------
NewXacc = round(NewXacc*scale);
%% -----------Sum the post-filtered data in 1-min window-------------------
lent = length(NewXacc);
TimeWindow = 60;                    % 1min has 60 1-second window
BinNo = round(lent/(TimeWindow*fs));% how many 1-min data

for loop = 1:BinNo
    WindowST = 1 + (loop-1)*fs*TimeWindow;
    WindowEnd = WindowST + fs*TimeWindow-1;
    if WindowEnd > lent
        WindowEnd = lent;
    end
    % ------------Activity Count----------------
    Xcount(1,loop) = sum(abs(NewXacc(WindowST:WindowEnd))');
end