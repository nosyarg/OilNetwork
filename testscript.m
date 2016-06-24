companies = csvread('25biggestformatlabcpy.csv'); %Pull in my big company dataset
connections = csvread('bp2015oilnetworkformatlab.csv'); %Pull in the adjacency matrix from bp
connections = connections > 3; %find a minimum threshhold for connections
Gupper = graph(connections,'upper');%plot some graphs which are not particularly meaningful other than showing collaboration
plot(Gupper);
Glower = graph(connections,'lower');
plot(Glower);
countrytogdprank = containers.Map();
[id, country, GDP] = csvimport('GDPByCountryformatlab.csv', 'columns',  {'Ranking', 'Economy','Size'});
for c = 1:length(country)
    current = country(c);
    countrytogdprank(char(current)) = id(c);
end
