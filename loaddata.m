%% Housekeeping
clear all
clc

Peak_Tolerance = 200;
Time_Tolerance = 9000;

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
        
        for c=[1:TT]
            if P1A(n)>P1A(n+c)
                Validity=Validity+1;
            elseif P1A(n+c) > P1A(n)
                Validity=0;
                break
            end
        end
        if Validity == TT
            Cycles=Cycles+1;
            Validity=0;
            x(n)=1;
        end
        Validity=0;
    end
    
end
