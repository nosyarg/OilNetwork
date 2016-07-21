%tying in the gdp
function adjmat = gdpgen(n)
    cd('/Users/grayson/desktop/summerresearch'); %get into a good directory
    FILE = fopen('gdppercentnomex.csv'); %pull in the network data
    DATA = textscan(FILE,'%s %s','delimiter',',','headerlines',1);
    fclose(FILE); %close the loose file
    gdp = DATA{2};
    tempgdp = zeros(length(gdp),1);
    for i = 1:length(gdp)
        tempgdp(i) = str2num(gdp{i});
    end
    gdp = -log(tempgdp/100);
    gdp = gdp/max(gdp);
    gdp = repmat(gdp,1,n);
    adjmat = rand(n)/3 < gdp;
    adjmat = adjmat.*adjmat';
    adjmat = adjmat.*(ones(n) - eye(n));
end