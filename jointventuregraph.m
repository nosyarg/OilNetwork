%Grayson York
%jointventuregraph.m
%6/28/2016
%pull in and visualize the edgelist 'jointventurenet.csv' with line format
%Company1,Company2,Source
%Dependencies:
%
clear; %clear the environmnt
cd('/Users/grayson/desktop/summerresearch'); %get into a good directory
FILE = fopen('jointventurenet.csv'); %pull in the network data
DATA = textscan(FILE,'%s %s %s','delimiter',',');
fclose(FILE); %close the loose file
firstcompany = DATA{1}; %break up the data into two seperate variables
secondcompany = DATA{2};
for i = 1:length(firstcompany) %loop through and correct for capitalization and spacing differences
    current1 = upper(firstcompany{i});
    current2 = upper(secondcompany{i});
    current1(isspace(current1)) = [];
    current2(isspace(current2)) = [];
    firstcompany{i} = current1;
    secondcompany{i} = current2;
end
allcompanies = union(firstcompany,secondcompany); %find list of all companies in dataset without repeats
Edges = [];
for i = 1:length(firstcompany)
    Edges = [Edges; sort([firstcompany(i) secondcompany(i)])];
end
%Edges = sort(Edges,2)
%Edges = flipud(transpose(sortrows(transpose(Edges),2)));
[~,idx] = unique(strcat(Edges(:,1),Edges(:,2)));
Edges = Edges(idx,:);
mygraph = graph(Edges(:,1),Edges(:,2));
plotfull = plot(mygraph,'layout','force');
plotfull.NodeLabel = table2cell(mygraph.Nodes(:,1))
top25 = {'SAUDIARAMCO', 'GAZPROM', 'IRANIANNATIONALOILCOMPANY', 'EXXONMOBIL', 'CNPC', 'BP', 'SHELL', 'PEMEX', 'CHEVRON', 'KUWAITPETROLEUM', 'ABUDHABI', 'SONATRACH', 'TOTAL', 'PETROBRAS', 'ROSNEFT', 'IRAQIOILMINISTRY', 'QATARPETROLEUM', 'LUKOIL', 'ENI', 'STATOIL', 'CONOCOPHILLIPS', 'PDVSA', 'SINOPEC', 'NNPC', 'PETRONAS'};
%for i = 1:length(allcompanies)
%    oldnode = allcompanies(i);
%    if ~ismember(oldnode,top25)
%        mygraph = rmnode(mygraph,oldnode);
%    end
%end
mygraph = rmnode(mygraph,setdiff(allcompanies,top25));
mygraph.Nodes.Degree = num2str(degrees(adjacency(mygraph))');
mygraph.Nodes.Closeness = num2str(closeness(adjacency(mygraph)));
%mygraph.Nodes.Betweenness = num2str(node_betweenness(adjacency(graph)));
%mygraph.Nodes.Eigen = num2str(eigencentrality(adjacency(graph)));
plot25 = plot(mygraph,'layout','force');
plot25.NodeLabel = table2cell(mygraph.Nodes(:,1))
bar(sort(str2num(mygraph.Nodes.Degree)))