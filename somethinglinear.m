function adjmat = somethinglinear()
    n = 25;
    adjmat = zeros(n);
    connectaffinities = repmat((1:n)/n,n,1);
    randmat = rand(n);
    adjmat = randmat > connectaffinities;
    adjmat = adjmat .* (adjmat');
    adjmat = adjmat .* (ones(n) - eye(n));
end