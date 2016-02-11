% Compute the area of the mandelbrot set using stratified random sampling

function area = mandelArea_MCstrat(count, numpoints)

	N = floor(sqrt(numpoints));		% Take the square root of the number of Monte Carlo samples to create square array
	h = 4/N;
	x = ones(N,1) * (h*(0:N-1) - 2);	% Create a square matrix in x and y.
	y = (h*(0:N-1) - 2)' * ones(1,N);
	c = x + i * y;			% Combine together in a single complex matrix
	coff = h * (rand(N,N) + i * rand(N,N));	% Take random samples
	c += coff;		% Add random samples to the sieve

	area = mandel(c, count);


endfunction
