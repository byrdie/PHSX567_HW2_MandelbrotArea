% Roy Smart
% Feb. 6th 2015
% PHSX567 Mathematical Physics II
% Homework 4: Mandelbrot set area
% This code uses Monte Carlo random and stratified random sampling to estimate the area and plot the Mandelbrot set


% QUESTION 1
% Monte Carlo estimation of Mandelbrot set area using random sampling 

count = 1e2;		% number of iterations into Mandelbrot set
numpoints = 1e2;	% Number of Monte Carlo samples
tot_sampl_area = 16;	% Total area of the Monte Carlo sample set


samples = rand(numpoints,1); % Sample real axis
samples += rand(numpoints,1) * i;	% Sample imag. axis
c = samples .* 4 - 2*(1 + i); % Rescale samples
c = c(abs(c) < 2);	% eliminate any points with |z| < 2, since we know this ahead of time.

% Iterate through mapping
zn = mandel(c, c, count);

%zn = zn(abs(zn) < 2);
length(zn)
area = (length(zn)/numpoints)*tot_sampl_area	% compute the area


% QUESTION 3
% Plot image of the Mandelbrot set.

xpix = 10000;	% number of pixels in horizontal direction

% Store properties of the set for later
maxX = 1;	% maximum x value of set
minX = -2;	% maximum y value of set
totalX = maxX - minX;	% total size of X range
maxY = 1;
minY = -1;
totalY = maxY - minY;

aspect_ratio = totalX/totalY;	% aspect ratio of the image
ypix = floor(xpix / aspect_ratio);	% determine y pixels from aspect ratio

% determine the indices of each pixel
dx = 1/xpix;
dy = 1/ypix;
N = zeros(ypix, xpix);
C = N;
Z = N;
for x = 1:xpix
	for y = 1:ypix
		m = x * dx * totalX - totalX/2;
		n = y * dy * totalY - totalY/2;
		C(y,x) = m + n * i;		
	endfor
endfor

Z = C;	% Initialize z0 to point C 
inc = logical(ones(ypix, xpix));
for k = 1:count

	N(inc) = N(inc) + 1;
	Z(inc) = Z(inc) .* Z(inc) .+ C(inc);% compute next iteration of the set
	inc = logical(abs(Z) < 2);
	
endfor

imshow(N, rainbow());








