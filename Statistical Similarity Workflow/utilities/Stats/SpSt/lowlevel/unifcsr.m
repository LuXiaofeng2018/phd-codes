function sP = unifcsr(map, n_samples, mode)
% sP = unifcsr(map, n_samples, mode)
%
% Uniformly distributed random points on a hypercubic map.
%
% Input:    map     hyper[quader] map, given by maximum and minimum value in each
%                   dimension. 
%                   A map from -1 to 1 in 3 dimensions would be given by        
%                   map = [1 1 1;-1 -1 -1];
%
%           nsamples (integer) number of random points.
%
%           mode    possible locations for points. Accepted values are:
%                   'dec':  Any decimal between map max and min.
%                   'disc': Discrete. Only signed integer coordinates. 
%
% Output:   sP      Matrix of random points with same dimensionality as
%                   map.
%
% Copyright:      Sebastian Rohrer
%                 University of Braunschweig, Institute of Technology
%                 Department of Pharmaceutical Chemistry
%                 2008


[m n] = size(map);

mi = map(1,:);                          % Borders
ma = map(2,:);                          %

inter  = ma - mi;                       % Interval = range for random numbers.
inter = ones(n_samples, 1)*inter;       % Replicate.

s = rand(n_samples,n);                  % Get uniformly distributed numbers from interval [0,1]
s = s.*inter;                           % Scale to range.

if(strcmpi(mode, 'disc'))               % If discrete ouput is wanted, round to next int.
    s = round(s);
end  
     
sP = ones(n_samples,1)*mi + s;          % Shift by lower border, and output.