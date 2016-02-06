% Roy Smart
% Feb. 6th 2015
% PHSX567 Mathematical Physics II
% Homework 4: Mandelbrot set area
% This code uses Monte Carlo random and stratified random sampling to estimate the area and plot the Mandelbrot set

count = 1e5;
numpoints = 1e5;	% Number of Monte Carlo samples

samples = rand(numpoints,1); % Sample real axis
samples += rand(numpoints,1) * i;	% Sample imag. axis
c = samples * 4 - (1 + i) * 2; % Rescale samples
c = samples(abs(samples) < 2);	% eliminate any points with |z| < 2, since we know this ahead of time.

% Recursively iterate through mapping
zn = c;		% the first element is just equal to the point
for z = 1:count

	zn = zn .* zn .+ c;	% Compute the next mapping
	%c = c(abs(zn) < 2);
	%zn = zn(abs(zn) < 2);	% Eliminate any points
	
endfor
zn = zn(abs(zn) < 2);
length(zn)
















