%% Housekeeping
clear all
clc

Peak_Tolerance = 200;
Time_Tolerance = 1800;

%%
file1=uigetfile('*.txt');
data=readtable(file1);
TimeSet=data(:,1);
T1=table2array(TimeSet);
P1=data(:,8);
P1A=table2array(P1);
P1A=abs(P1A);
MP1=max(abs(P1A),[],1);
MP2=MP1-Peak_Tolerance;
TT=Time_Tolerance;
%%
n2=numel(P1A);
x=zeros(n2,1);
Cycles=0;
Validity = 0;

for n=[1:(n2-TT)]
    if (n+1)== n2
        return
    elseif P1A(n) < P1A(n+1)
        continue
    elseif P1A(n) > P1A(n+1)
      Validity= TestValidity(n,TT,P1A);
      if Validity == 2*TT
          Cycles=Cycles+1;
      end
    end
    Validity =0;
end
