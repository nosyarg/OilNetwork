clear
cd('/Users/grayson/desktop/summerresearch')
companies = csvread('25biggestformatlabcpy.csv'); %Pull in my big company dataset
connections = csvread('bp2015oilnetworkformatlab.csv'); %Pull in the adjacency matrix from bp
connections = connections > 3; %find a minimum threshhold for connections
Gupper = graph(connections,'upper');%plot some graphs which are not particularly meaningful other than showing collaboration
plot(Gupper);
Glower = graph(connections,'lower');
plot(Glower);
countrytounid = containers.Map();%make the hashmap and load the file that it will read from
[id, country] = csvimport('countryid.csv', 'columns',  {'ID','Country'});
for c = 1:length(country)
    countrytounid(char(country(c))) = id(c);
end
[year,month,type,country,value] = csvimport('UNOILDATAFORMATLAB.CSV','columns',{'year','month','type','country','value'});
ids = zeros(length(country),1);
for c = 1:length(country)
    country(c);
    ids(c) = countrytounid(char(country(c))); %convert the UN country names to their UNID
end
sumvals = zeros(length(countrytounid));
newvalue = int(char(value))
for c = 1:length(id)
   sumvals(id(c)) = sumvals(id(c)) + value(c);
end
plot(ids,value)