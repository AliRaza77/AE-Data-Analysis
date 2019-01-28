%% Housekeeping
clear all
clc
%% Parameters

Peak_Tolerance = 0.03;
Time_Tolerance = 950;
Highlight_Peaks = 1;
Show_Graph = 1;
Parametric = 3;
Initial_Cycle = 111651;

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

%%
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
n2=numel(P1A);
x=zeros(n2,1);

 [loads,locs]= findpeaks(P1A,'MinPeakHeight',MP2,'MinPeakDistance',Time_Tolerance);
 
 P2=data(:,9);
 P2A=table2array(P2);
P2A=abs(P2A);
MP2=max(abs(P2A),[],1);
MP3=MP2-Peak_Tolerance;
TT=Time_Tolerance;
 y= findpeaks(P2A,'MinPeakHeight',MP3,'MinPeakDistance',Time_Tolerance);
 
 Cycles=numel(loads);
 
 
 if Show_Graph == 1
 X_axis=T1;
 Y_axis=P1A;
plot(X_axis,Y_axis,'-b');
 xlabel('Time');
 ylabel('Load');
 title('Peaks')
 end
 
 if Highlight_Peaks == 1
 hold on
 f_data = [X_axis,Y_axis];
 ndx=X_axis(locs);
 ndy=Y_axis(locs);
 plot(ndx,ndy,'or')
 end
 
 P_data = f_data(locs,:);
 End_Cycle = Initial_Cycle + Cycles;
 Cycle_Array = [Initial_Cycle:(End_Cycle-1)];
 FileSet=FileSet(locs);
 P_data = [P_data,Cycle_Array',FileSet];
 
 %% Cleaning
 
 
 