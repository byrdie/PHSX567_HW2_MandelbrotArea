% Compute the area of the mandelbrot set using random sampling

function area = mandelArea_MCrandom(count, numpoints)

	samples = rand(numpoints,1); % Sample real axis
	samples += rand(numpoints,1) * i;	% Sample imag. axis
	c = samples .* 4 - 2*(1 + i); % Rescale samples
	c = c(abs(c) < 2);	% eliminate any points with |z| < 2, since we know this ahead of time.

	% Iterate through mapping
	area = mandel(c, count);

endfunction
