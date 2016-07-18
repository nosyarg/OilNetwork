function adjmat =  twosetnomex(~)
    nforprofit = 14;
    forprofitprob = 73/91;
    nregional = 10;
    regionalprob = 3/45;
    crossprob = 74/140;
    n = nforprofit + nregional;
    zerodiag = ones(n) - eye(n);
    ul = rand(nforprofit) < forprofitprob;
    lr = rand(nregional) < regionalprob;
    ll = rand(nregional,nforprofit) < crossprob;
    ur = rand(nforprofit,nregional) < crossprob;
    adjmat = [ul ur; ll lr];
    adjmat = adjmat.*zerodiag;
end