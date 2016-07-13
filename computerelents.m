function [relents, oilrelent] = computerelents(generationfunction,oilgraph,reps1,reps2)
    [n, ~] = size(adjacency(oilgraph));
    degcounts = zeros(n,1);
    for i = 1:reps1
        currentadjmat = generationfunction(n);
        twoset();
        currentgraph = graph(currentadjmat,'upper');
        degs = degree(currentgraph);
        for j = 1:n
            degcounts(j) = degcounts(j) + sum(degs == j);
        end
        if(~mod(i,100))
            i
        end 
    end
    avg = degcounts/reps1;
    relents = zeros(n,1);
    for i = 1:reps2
        currentadjmat = generationfunction(n);
        currentgraph = graph(currentadjmat,'upper');
        degs = degree(currentgraph);
        for j = 1:n
            degcounts(j) = sum(degs == j);
        end
        relents(i) = sum(degcounts.*log(max(degcounts,.001)./max(avg,.0000001)));
        if(~mod(i,100))
            i + 1
        end
    end
    oildegs = degree(oilgraph);
    oildegcount = zeros(n,1)
    for j = 1:n
            oildegcount(j) = oildegcount(j) + sum(oildegs == j);
    end
    oildegcount = oildegcount/n;
    avg = avg/n;
    oilrelent = sum(oildegcount.*log(max(oildegcount,.00001)./max(avg,.001)));
end