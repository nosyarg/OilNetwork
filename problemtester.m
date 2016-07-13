function arr = problemtester(rgen)
firstrand = rgen();
for i = 1:1000
    arr(i) = rgen();
end