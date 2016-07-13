%randomgen
n = 25
reps1 = 1000
reps2 = 1000
zerodiag = ones(n) - eye(n);
degcounts = zeros(n,1);
for i = 1:reps1
    adjmat = rand(n) > .5;
    adjmat = adjmat.*zerodiag;
    randgraph = graph(adjmat,'upper');
    for j = 1:n
        degcounts(j) = degcounts(j) + sum(degree(randgraph)==j);
    end
    if(~mod(i,100))
        i
    end
end
avg = degcounts/reps1
bar(avg)
relents = zeros(n,1);
for i = 1:reps2
    adjmat = rand(n) > .5;
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