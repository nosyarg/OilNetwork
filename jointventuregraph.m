clear; %clear the environmnt
cd('/Users/grayson/desktop/summerresearch'); %get into a good directory
FILE = fopen('jointventurenet.csv');
DATA = textscan(FILE,'%s %s %s','delimiter',',');
fclose(FILE);
firstcompany = DATA{1};
secondcompany = DATA{2};
for i = 1:length(DATA)
    current1 = firstcompany(i);
    current2 = secondcompany(i);
    current1(isspace(current1)) = [];