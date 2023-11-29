a = 1.8; %amount of time cut after 2 runs
k = 8; %1k per 8 min

while k >= 2.7
    k = k - a
    a = a./2;
end
