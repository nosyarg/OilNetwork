%countrygdpstuff
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
[val, idx] = sort(gdp)
bar(val)
set(gca,'xticklabel',country(idx),'XTickLabelRotation',45,'Xtick',1:25);