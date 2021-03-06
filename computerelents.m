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
    avg = avg/sum(avg);
    relents = zeros(n,1);
    for i = 1:reps2
        currentadjmat = generationfunction(n);
        currentgraph = graph(currentadjmat,'upper');
        degs = degree(currentgraph);
        for j = 1:n
            degcounts(j) = sum(degs == j);
        end
        degcounts = degcounts/max(sum(degcounts),.001);
        relents(i) = sum(degcounts.*log2(max(degcounts,.000001)./max(avg,.000001)));
        if(~mod(i,100))
            i + 1
        end
    end
    oildegs = degree(oilgraph);
    oildegcount = zeros(n,1)
    for j = 1:n
            oildegcount(j) = oildegcount(j) + sum(oildegs == j);
    end
    oildegcount = oildegcount/sum(oildegcount);
    oilrelent = sum(oildegcount.*log(max(oildegcount,.000001)./max(avg,.000001)));
end