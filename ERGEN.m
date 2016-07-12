%GRAYSON YORK
%ERGEN.m
%7/11/16
%Generate histograms of ER graphs
er = graph(rand(10000) > .5,'upper');
%histogram(degree(er))
normplot(degree(er))