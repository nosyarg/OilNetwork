%GRAYSON YORK
%ERGEN.m
%7/11/16
%Generate histograms of ER graphs
function adjmat = ergen(n)
adjmat = rand(n) < 3/55;
adjmat = adjmat.*(ones(n)-eye(n));
end