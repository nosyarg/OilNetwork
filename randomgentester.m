%randomgentester
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
allgov = {'SAUDIARAMCO','IRANIANNATIONALOILCOMPANY','KUWAITPETROLEUM','ABUDHABI','SONATRACH','IRAQIOILMINISTRY','QATARPETROLEUM','PDVSA','NNPC','PETRONAS'}
somegov = {'CNPC','PETROBRAS','ROSNEFT','ENI','STATOIL','SINOPEC','GAZPROM'}
nogov = {'EXXONMOBIL','BP','SHELL','CHEVRON','TOTAL','LUKOIL','CONOCOPHILLIPS'}
forprofit = [western chinese];
mygraph = rmnode(mygraph,setdiff(allcompanies,top25));
%mygraph = rmnode(mygraph, setdiff(top25,[forprofit, russian, 'PETRONAS']))
%mygraph = rmnode(mygraph, [forprofit, russian, 'PETRONAS'])
mygraph = rmnode(mygraph, 'PEMEX')
reps = 10000;
[x, y] = computerelents(@gdpgen,mygraph,reps,reps);
sum(x<y)/reps
%mygraph = rmnode(mygraph,allgov)
%myplot = plot(mygraph,'layout','circle')
%highlight(myplot,allgov,'NodeColor','r','MarkerSize',10)
%highlight(myplot,somegov,'NodeColor','m','MarkerSize',10)
%highlight(myplot,nogov,'NodeColor','b','MarkerSize',10)

