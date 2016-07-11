%GRAYSON YORK
%PLAYINGWITHGDP.m
%7/11/16
%Look at oil production vs GDP in relevant countries
clear; %clear the environmnt
cd('/Users/grayson/desktop/summerresearch'); %get into a good directory
FILE = fopen('oilproductiongdp.csv'); %pull in the network data
DATA = textscan(FILE,'%s %s %s','delimiter',',');
fclose(FILE); %close the loose file
country = DATA{1}; %break up the data into three seperate variables
production = DATA{2};
GDP = DATA{3};
country = country(3:end);
production = str2double(production(3:end));
GDP = str2double(GDP(3:end));
oiltogdp = production./GDP;
bar(oiltogdp);
Labels = country;
set(gca, 'XTick', 1:20 , 'XTickLabel', Labels, 'XTickLabelRotation', 45);