% Define recursive function to compute if a point
% is in the Mandelbrot set
function A = mandel(c, count)
	
	area = [];	% Store the change in area for plotting later
	zn = c;
	inc = logical(ones(1,length(zn)));
	
	for k = 1:count

		zn(inc) = zn(inc) .* zn(inc) .+ c(inc);	% Compute the next mapping
		inc = logical(abs(zn) < 2);
		area = [area length(zn(inc))];
	
	endfor
	
	A = area;
		
endfunction
