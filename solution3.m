% Roy Smart
% Feb. 6th 2015
% PHSX567 Mathematical Physics II
% Homework 4: Mandelbrot set area
% This code uses Monte Carlo random and stratified random sampling to estimate the area and plot the Mandelbrot set

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% QUESTION 1
% Monte Carlo estimation of Mandelbrot set area using random sampling 

count = 1e2;		% number of iterations into Mandelbrot set
numpoints = 1e4;	% Number of Monte Carlo samples
tot_sampl_area = 16;	% Total area of the Monte Carlo sample set


rand_area = mandelArea_MCrandom(count, numpoints);
printf("	QUESTION 1: Total area with random sampling is %f \n", rand_area(end) / numpoints * tot_sampl_area);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% QUESTION 2
% Compute the change in area and plot a power law trend
dA = (shift(rand_area,1)- rand_area) ./ numpoints .* tot_sampl_area;
x = 1:length(dA);
P = polyfit(log(x(2:10)), log(dA(2:10)), 1)
printf("	QUESTION 2: The power law exponent for the change in area is %f \n", P(1))

figure(1)
loglog(x(dA > 0), dA(dA > 0));
hold on
loglog(x, exp(P(2)) .* x.^(P(1)), 'r');
hold off
title("Decrease in Area vs. n");
xlabel("n");
ylabel("Decrease in Area");
legend("Observed change", "Power law trend");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% QUESTION 3
% Compute the area of the mandelbrot set using stratified random sampling

strat_area = mandelArea_MCstrat(count, numpoints);

printf("	QUESTION 3: Total area with stratified random sampling is: %f \n", strat_area(end) / numpoints * tot_sampl_area)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% QUESTION 4
% Determine the standard deviation of the both Monte Carlo techniques and plot power law trend
r = [];
s = [];
rArea = [];	% Allocate space for area measurements
sArea = [];
for n = 10:500:numpoints+10
	for d = 0:9

		% Have each row hold the area calculation for each run
		r = [r mandelArea_MCrandom(count, n)(end)];
		s = [s mandelArea_MCstrat(count, n)(end)];

	endfor
	
	rArea = [rArea; r / n * tot_sampl_area];	% Stick result into next row of array
	sArea = [sArea; s / n * tot_sampl_area];
	r = [];
	s = [];	% Clear memory
	
endfor

std_dev_rand = std(rArea / numpoints * tot_sampl_area, 0, 2);
std_dev_strat = std(sArea / numpoints * tot_sampl_area, 0, 2);

% Plot the standard deviation as a function of N
figure(2);
x = 10:500:numpoints+10;
loglog(x, std_dev_rand);
hold on
loglog(x, std_dev_strat, 'g')

% Determine the power law for standard deviation convergence
Pr = polyfit(log(x'(1:10)), log(std_dev_rand(1:10)), 1);
Ps = polyfit(log(x'(1:10)), log(std_dev_strat(1:10)), 1);
loglog(x, 4.5e2*exp(Pr(2)) .* std_dev_rand(1) * x.^Pr(1), '--r');
loglog(x, 4.9e2*exp(Ps(2)) .* std_dev_strat(1) * x.^Ps(1), '--c');
hold off
title("Standard deviation in random/stratified sampling vs. N");
xlabel("N");
ylabel("Standard deviation");
legend("Random Observed", "Stratified Observed", "Random Trend", "Stratified Trend");

printf("	QUESTION 4: The standard deviation for random sampling goes as N to the %f power \n", Pr(1));
printf("		The standard deviation for stratified sampling goes as N to the %f power \n", Ps(1))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% QUESTION 5
% Plot image of the Mandelbrot set.

xpix = 100;	% number of pixels in horizontal direction

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
		m = x * dx * totalX - 2*totalX/3;
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

figure(3)
imshow(N, cool());
imwrite(N, cool(), "mandelbrot.tif");

printf("\n\n")





