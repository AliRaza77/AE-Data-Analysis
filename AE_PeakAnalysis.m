%% Housekeeping
clear all, close all  %#ok<*CLALL>
clc
%% Parameters

Peak_Tolerance = 200;       % Select Distance of local minima/maxima search from the maximum peak
                            % Recommended Settings: 200 for scaled data and
                            % between 0.02-0.03 for unscaled data
Time_Tolerance = 950;       % Select distance between adjacent peaks recognized in number of datapoints
                            % Calibrated Time Tolerance = 950 datapoints
Parametric = 3;             % Select Parametric (from 1 through 4)
Initial_Cycle = 92800;      % Input the number of the Initial Cycle of the first file 

%% Processing
PP=0;
if Parametric == 1
    PP = 8;
elseif Parametric == 2
    PP = 9;
elseif Parametric == 3
    PP = 10;
elseif Parametric == 4
    PP = 11;
end

file1=uigetfile('*.txt');
data=readtable(file1);
TimeSet=data(:,1);
FileSet=data(:,3);
FileSet=table2array(FileSet);
T1=table2array(TimeSet);
P1=data(:,PP);
P1A=table2array(P1);
P1A=abs(P1A);
MP1=max(abs(P1A),[],1);
MP2=MP1-Peak_Tolerance;
TT=Time_Tolerance;
%%
 [loads,locs]= findpeaks(P1A,'MinPeakHeight',MP2,'MinPeakDistance',Time_Tolerance);
 
 Cycles=numel(loads);
 
 %% Graph
 X_axis=T1;
 Y_axis=P1A;
plot(X_axis,Y_axis,'-b');
 xlabel('Time');
 ylabel('Load');
 title('Peaks')

 %% Highlight Peaks

 hold on
 f_data = [X_axis,Y_axis];
 ndx=X_axis(locs);
 ndy=Y_axis(locs);
 plot(ndx,ndy,'or')

 P_data = zeros(Cycles,4);
 P_data(:,[1:2]) = f_data(locs,:);
 End_Cycle = Initial_Cycle + Cycles;
 Cycle_Array = [Initial_Cycle:(End_Cycle-1)];
 FileSet=FileSet(locs);
 P_data(:,3) = Cycle_Array';
 P_data(:,4) = FileSet;
 
 hold off
 
 %% Cleaning
vars = {'Cycle_Array','data','FileSet','f_data','file1','P1A','loads','locs','MP1','MP2','ndx','ndy','P1','PP','T1','TimeSet','TT','X_axis','Y_axis'};
clear(vars{:})
clear vars


 
 