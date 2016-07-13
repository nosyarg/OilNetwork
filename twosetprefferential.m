function adjmat = twosetprefferential()
%assign the first two sets as normal, but assign the third set
%prefferentially
regionallinks = 3;
forprofitlinks = 73;
crosslinks = 75;
forprofitnum = 14;
regionalnum = 11;
probforprofit = ones(forprofitnum,1)/forprofitnum;
probregional = ones(regionalnum,1)/regionalnum;
cumprobforprofit = probforprofit;
cumprobregional = probregional;
adjmat = zeros(forprofitnum + regionalnum);
end