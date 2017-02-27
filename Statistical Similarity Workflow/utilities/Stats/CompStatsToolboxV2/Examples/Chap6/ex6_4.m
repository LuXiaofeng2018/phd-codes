% Example 6.4 - ICA
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% REFERENCE:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Demonstration code for "Independent component analysis: A Tutorial Introduction"
% JV Stone, MIT Press, September 2004.
% Copyright: 2005, JV Stone, Psychology Department, Sheffield University, Sheffield, England.    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Basic projection pursuit algorithm demonstrated on 2 sound signals,
% only one signal is extracted here.

% Include the following in the on-line example code.
% This shows how we constructed the signal.
% The source signals are loaded and standardized.
N = 10000; 
load chirp; 
g1 = y(1:N); 
g1 = g1 - mean(g1); 
g1 = g1/std(g1);
load gong;  
g2 = y(1:N); 
g2 = g2 - mean(g2); 
g2 = g2/std(g2);
% Combine sources into matrix S.
% Each column contains a signal.
G = [g1,g2];
% Generate a random mixing matrix.
mixmat = randn(2,2);
% Create the signal .
x = G*mixmat;
% Spherize the data.
[U D V]=svd(x,0);
z=U;
z=z./repmat(std(z,1),N,1);
save icaexample N G x z mixmat

% Load the data.
load icaexample
% See the on-line version of the example
% for details on how the data were constructed.
% This loads up a matrix x with 2 columns.
% Each column contains observed amplitudes
% from one microphone. Thus, each column
% of x is a mixture of the chirp and gong.
% It also contains the matrix z, which is
% a spherized version of x. Finally, it has
% the unmixed signals in matrix s and the
% frequency N.
% Initialise weight vector and normalize.
w = randn(1,2);
w = w/norm(w);
% Specify the step size.
step = 0.02;
% Do projection pursuit using gradient ascent.
for iter=1:100
    % Get estimated source signal, y.
    y = z*w'; 
    % Get estimated kurtosis. Note that 
    % we can use a simplified form because
    % the weight vector has unit length.
    K = mean(y.^4)-3; 
    % Find gradient of kurtosis.
    y3 = y.^3;
    Y3 = repmat(y3,1,2);
    grad = mean(Y3.*z);
    % Update w and normalize.
    w = w + step*grad;
    w = w/norm(w);
end

plot(y)
ylabel('Amplitude - Extracted Signal')

% Play back both signals to compare them.
soundsc(G(:,1),N); % This is the original signal.
soundsc(y,N); % This is the extracted signal.

% This will be part of the Exercises.
% Now try the Gram-Schmidt orthogonalization
% as applied to each column of z separately.
% Remove this signal from each of the cols.
y1 = y;
z1 = z(:,1) - y1'*z(:,1)*y1/(y1'*y1);
z2 = z(:,2) - y1'*z(:,2)*y1/(y1'*y1);
zn = [z1, z2];
% Repeat the process on these.
% Initialise weight vector and normalize.
w = randn(1,2);
w = w/norm(w);
% Specify the step size.
step = 0.02;
% Do projection pursuit using gradient ascent.
for iter=1:100
    % Get estimated source signal, y.
    y = zn*w'; 
    % Get estimated kurtosis. Note that 
    % we can use a simplified form because
    % the weight vector has unit length.
    K = mean(y.^4)-3; 
    % Find gradient of kurtosis.
    y3 = y.^3;
    Y3 = repmat(y3,1,2);
    grad = mean(Y3.*zn);
    % Update w and normalize.
    w = w + step*grad;
    w = w/norm(w);
end

y2 = y;
% Listen to this one.
soundsc(y2,N);








