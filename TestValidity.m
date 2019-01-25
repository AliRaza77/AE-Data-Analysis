function Validity = TestValidity(n,TT,P1A);
Validity=0;
f=TT; b=TT;
if n-TT < 0
    b=n-1;
end
if n+TT > numel(P1A)
    f=numel(P1A)
end

for c=[1:f]
    if P1A(n) < P1A(n+c)
        break
    elseif P1A(n) > P1A(n+c)
        Validity = Validity +1;
    end
end
for c=[1:b]
    if P1A(n) < P1A(n-c)
        break
    elseif P1A(n) >= P1A(n-c)
        Validity = Validity +1;
    end
end

end
