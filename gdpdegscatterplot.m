%GDPDEGScatterplot
cd('/Users/grayson/desktop/summerresearch'); %get into a good directory
FILE = fopen('companiesgdppercent.csv'); %pull in the network data
DATA = textscan(FILE,'%s %s','delimiter',',','headerlines',1);
fclose(FILE); %close the loose file
country = DATA{1};
gdp = DATA{2};
tempgdp = zeros(length(gdp),1)
for i = 1:length(gdp)
    tempgdp(i) = str2num(gdp{i});
end
gdp = tempgdp;
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
mygraph = rmnode(mygraph,setdiff(allcompanies,top25));
mygraph = rmnode(mygraph,{'PEMEX'});
toremove = strcmp(country,'PEMEX');
country = country(~toremove);
gdp = gdp(~toremove);
[~,degidx] = sort(table2cell(mygraph.Nodes));
[~,gdpidx] = sort(country);
degs = degree(mygraph);
gdp = gdp/100;
degs = degs/std(degs)
gdp = gdp/std(gdp)
scatter(-log(gdp(gdpidx)),degs(degidx));
a = text(-log(gdp(gdpidx))+.2,degs(degidx),sort(country));
set(a,'rotation',25)
hold on;
y = degs(degidx);
x = [ones(length(gdp),1),-log(gdp(gdpidx))];
param = x\y;
linmod = x*param;
plot(x(:,2),linmod);
rsq = 1 - sum((y - linmod).^2)/sum((y - mean(y)).^2);
hold off;