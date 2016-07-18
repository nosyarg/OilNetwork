function adjmat = twoset(~)
    nforprofit = 14;
    forprofitprob = 73/91;
    nregional = 11;
    regionalprob = 3/55;
    crossprob = 75/154;
    n = nforprofit + nregional;
    zerodiag = ones(n) - eye(n);
    ul = rand(nforprofit) < forprofitprob;
    lr = rand(nregional) < regionalprob;
    
    adjmat = [ul ur; ll lr];
    adjmat = adjmat.*zerodiag;
end