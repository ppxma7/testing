function [myInts] = posInt(x)
myLen = 99;
myInts = zeros(myLen,1);
for ii = 1:myLen
    y = rem(ii,x);
    if y == 0
        myInts(ii) = ii;
    end
end
myInts = nonzeros(myInts);
end

