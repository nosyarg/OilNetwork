%Generate two random graphs and then wire them together based on three
%seperate random rules.
reps1 = 1000000
reps2 = reps1
nforprofit = 14;
forprofitprob = 73/91;
nregional = 11;
regionalprob = 3/55;
crossprob = 75/154;
n = nforprofit + nregional
zerodiag = ones(n) - eye(n);
degcounts = zeros(n,1);
for i = 1:reps1
    ul = rand(nforprofit) < forprofitprob;
    lr = rand(nregional) < regionalprob;
    ll = rand(nregional,nforprofit) < crossprob;
    ur = rand(nforprofit,nregional) < crossprob;
    adjmat = [ul ur; ll lr];
    adjmat = adjmat.*zerodiag;
    randgraph = graph(adjmat,'upper');
    for j = 1:n
        degcounts(j) = degcounts(j) + sum(degree(randgraph)==j);
    end
    if(~mod(i,100))
        i
    end
end
avg = degcounts/reps1;
plot(graph(adjmat,'upper'))
relents = zeros(n,1);
for i = 1:reps2
    ul = rand(nforprofit) < forprofitprob;
    lr = rand(nregional) < regionalprob;
    ll = rand(nregional,nforprofit) < crossprob;
    ur = rand(nforprofit,nregional) < crossprob;
    adjmat = [ul ur; ll lr];
    adjmat = adjmat.*zerodiag;
    randgraph = graph(adjmat,'upper');
    degs = degree(randgraph);
    for j = 1:n
        degcounts(j) = sum(degs == j);
    end
    relents(i) = sum(degcounts.*log(max(degcounts,.001)./max(avg,.0000001)));
    if(~mod(i,100))
        i + 1
    end
end
oildegs = zeros(n,1);
for i = 1:n
    oildegs(i) = sum(degree(mygraph)==i);
end
relentoil = sum(oildegs.*log(max(oildegs,.001)./max(avg,.0000001)));
z = (relentoil - mean(relents))/std(relents)