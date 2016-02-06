% Roy Smart
% Feb. 6th 2015
% PHSX567 Mathematical Physics II
% Homework 4: Mandelbrot set area
% This code uses Monte Carlo random and stratified random sampling to estimate the area and plot the Mandelbrot set


% QUESTION 1
% Monte Carlo estimation of Mandelbrot set area using random sampling 

count = 1e6;		% number of iterations into Mandelbrot set
numpoints = 1e3;	% Number of Monte Carlo samples
tot_sampl_area = 16;	% Total area of the Monte Carlo sample set


samples = rand(numpoints,1); % Sample real axis
samples += rand(numpoints,1) * i;	% Sample imag. axis
c = samples .* 4 - 2*(1 + i); % Rescale samples
c = c(abs(c) < 2);	% eliminate any points with |z| < 2, since we know this ahead of time.

% Recursively iterate through mapping
zn = c;		% the first element is just equal to the point
for z = 1:count

	zn = zn .* zn .+ c;	% Compute the next mapping
	c = c(abs(zn) < 2);
	zn = zn(abs(zn) < 2);	% Eliminate any points
	
endfor
%zn = zn(abs(zn) < 2);
length(zn)
area = (length(zn)/numpoints)*tot_sampl_area


% QUESTION 3
% Plot image of the Mandelbrot set.

x_pix = 100;	% number of pixels in horizontal direction

% Store properties of the set for later
maxX = 1;	% maximum x value of set
minX = -2;	% maximum y value of set
dX = maxX - minX;	% total size of X range
maxY = 1;
minY = -1;
dY = maxY - minY;

aspect ratio = dX/dY;	% aspect ratio of the image
ypix = z_pix / aspect_ratio;	% determine y pixels from aspect ratio

image = zeros(x_pix, y_pix, 3);	% preallocate space for image colors














