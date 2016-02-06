% Define recursive function to compute if a point
% is in the Mandelbrot set
function result=mandel(zn, c, n, count)
	
	zn1 = zn .* zn .+ c;	% Compute the next mapping
	
	c = c(abs(zn1) < 2);
	zn1 = zn1(abs(zn1) < 2);	% Eliminate any points
	
	length(zn1)
	
	if(n < count)	% Recursive call to compute next iteration
		result = mandel(zn1, c, n+1, count);
	else
		result = zn1;
	endif
		
endfunction
