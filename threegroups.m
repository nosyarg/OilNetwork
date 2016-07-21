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
[~,idx] = unique(strcat(Edges(:,1),Edges(:,2)));
Edges = Edges(idx,:);
mygraph = graph(Edges(:,1),Edges(:,2));
top25 = {'SAUDIARAMCO', 'GAZPROM', 'IRANIANNATIONALOILCOMPANY', 'EXXONMOBIL', 'CNPC', 'BP', 'SHELL', 'PEMEX', 'CHEVRON', 'KUWAITPETROLEUM', 'ABUDHABI', 'SONATRACH', 'TOTAL', 'PETROBRAS', 'ROSNEFT', 'IRAQIOILMINISTRY', 'QATARPETROLEUM', 'LUKOIL', 'ENI', 'STATOIL', 'CONOCOPHILLIPS', 'PDVSA', 'SINOPEC', 'NNPC', 'PETRONAS'};
western = {'EXXONMOBIL','BP','SHELL','CHEVRON','TOTAL','ENI','STATOIL','CONOCOPHILLIPS'};
chinese = {'CNPC','SINOPEC'};
russian = {'GAZPROM','ROSNEFT','LUKOIL'};
forprofit = [western chinese];
regional = setdiff(top25,[forprofit,russian,'PETRONAS'])
mygraph = rmnode(mygraph,setdiff(allcompanies,top25));
[val, idx] = sort(degree(mygraph));
val = [val, val,val];
val([5,11,13:15,17:25],1) = 0;
val([1:4,6:10,12,14:17,21,23:25],2) = 0;
val([1:13,16,18:20,22],3)=0
bar(val);
set(gca,'xticklabel',table2cell(mygraph.Nodes(idx,1)),'XTickLabelRotation',45,'Xtick',1:25);
saveas(gca,'plots/allcompanies.jpg');
maxeveryone = max(degree(mygraph));
avgeveryone = mean(degree(mygraph));
mineveryone = min(degree(mygraph));
mygraph = rmnode(mygraph,[forprofit, russian, 'PETRONAS']);
[val, idx] = sort(degree(mygraph));
bar(val);
set(gca,'xticklabel',table2cell(mygraph.Nodes(idx,1)),'XTickLabelRotation',45,'Xtick',1:25);
saveas(gca,'plots/rivals.jpg');
maxrivals = max(degree(mygraph));
avgrivals = mean(degree(mygraph));
minrivals = min(degree(mygraph));
mygraph = graph(Edges(:,1),Edges(:,2));
mygraph = rmnode(mygraph,setdiff(allcompanies,[forprofit, russian, 'PETRONAS']));
[val, idx] = sort(degree(mygraph));
bar(val);
set(gca,'xticklabel',table2cell(mygraph.Nodes(idx,1)),'XTickLabelRotation',45,'Xtick',1:25);
saveas(gca,'plots/frenemies.jpg');
maxfrenemies = max(degree(mygraph));
avgfrenemies = mean(degree(mygraph));
minfrenemies = min(degree(mygraph));
mygraph = graph(Edges(:,1),Edges(:,2));
mygraph = rmnode(mygraph,setdiff(allcompanies,top25));
edgelist = table2cell(mygraph.Edges)
toremove = [];
for i = 1:length(edgelist)
    if and(any(strcmp(regional,edgelist{i}{1})),any(strcmp(regional,edgelist{i}{2})))
        toremove = [toremove; i]
    end
    if and(~any(strcmp(regional,edgelist{i}{1})),~any(strcmp(regional,edgelist{i}{2})))
        toremove = [toremove; i]
    end
end
mygraph = rmedge(mygraph,toremove);
plot(mygraph)
[val, idx] = sort(degree(mygraph));
val = [val, val];
val([2, 7, 12:14, 16, 17, 21, 23:25],1) = 0;
val([1,3,4,5,6,8:11,15,18,19,20,22],2) = 0;
bar(val);
set(gca,'xticklabel',table2cell(mygraph.Nodes(idx,1)),'XTickLabelRotation',45,'Xtick',1:25);
saveas(gca,'plots/crosslinks.jpg');
maxcross = max(degree(mygraph));
avgcross = mean(degree(mygraph));
minrcross = min(degree(mygraph));