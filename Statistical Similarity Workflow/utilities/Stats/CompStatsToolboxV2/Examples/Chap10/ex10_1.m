% Example 10.1
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

load iris
% This loads up three matrices: 
% setosa, virginica and versicolor
% We will assume each class is multivariate normal. 
% To get the class-conditional probabilities, we
% get estimates for the parameters for each class.
muset = mean(setosa);
covset = cov(setosa);
muvir = mean(virginica);
covvir = cov(virginica);
muver = mean(versicolor);
covver = cov(versicolor);

