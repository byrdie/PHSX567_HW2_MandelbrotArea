% Define recursive function to compute if a point
% is in the Mandelbrot set
function result=mandel(zn, c, count)
	
	for z = 1:count

		zn = zn .* zn .+ c;	% Compute the next mapping
		c = c(abs(zn) < 2);
		zn = zn(abs(zn) < 2);	% Eliminate any points
	
	endfor
	result = zn;
		
endfunction
