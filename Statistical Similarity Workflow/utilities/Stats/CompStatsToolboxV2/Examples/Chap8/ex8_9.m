% Example 8.9
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% Use the law data.
load law
lsat = law(:,1);
gpa = law(:,2);

% Use the example in MATLAB documentation.
B=1000;
[bootstat,bootsam] = bootstrp(B,'corrcoef',lsat,gpa);
% Find the jackknife-after-bootstrap
n = length(gpa);
% Set up storage space.
jreps = zeros(1,n);
% Loop through all points, 
% find the cols in bootsam that
% do not have that point in it.
for i = 1:n
			% Note that the columns of bootsam are 
			% the indices to the samples.
			% Find all columns with the point.
			[I,J] = find(bootsam==i);
			% Find all columns without the point.
			jacksam = setxor(J,1:B);									
			% Find the correlation coefficient for 
			% each of the bootstrap samples that 
			% do not have the point in them.
			bootrep = bootstat(jacksam,2);													
			% In this case it is col 2 that we need.
			% Calculate the feature (gamma_b) we want.
			jreps(i) = std(bootrep);								
end
% Estimate the error in gamma_b
varjack = (n-1)/n*sum((jreps-mean(jreps)).^2);
% The original bootstrap estimate of error is 
gamma = std(bootstat(:,2));
