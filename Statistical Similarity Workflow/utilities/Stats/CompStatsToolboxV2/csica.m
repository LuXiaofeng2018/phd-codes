function Y = csica(x)

% CSICA     Independent Component Analysis
%
%	Y = CSICA(X) Returns the extracted signals in Y.
%
%   The input variable X is a matrix of signal mixtures, where each column
%   corresponds to one signal mixture.
%
%   EXAMPLE:
%
%   N = 10000;
%   load chirp
%   g1 = y(1:N); 
%   g1 = g1 - mean(g1); 
%   g1 = g1/std(g1);
%   load gong
%   g2 = y(1:N); 
%   g2 = g2 - mean(g2); 
%   g2 = g2/std(g2);
%   load laughter
%   g3 = y(1:N); 
%   g3 = g3 - mean(g3); 
%   g3 = g3/std(g3);
%   % Combine sources into matrix S.
%   % Each column contains a signal.
%   G = [g1(:),g2(:),g3(:)];
%   % Generate a random mixing matrix.
%   mixcoef = randn(3,3);
%   % Create the signal .
%   x = G*mixcoef;
%   Y = csica(x);
%   % Listen to the signals
%   soundsc(Y(:,1),N)
%   soundsc(Y(:,2),N)
%   soundsc(Y(:,3),N)



%   W. L. and A. R. Martinez, 12/14/07
%   Computational Statistics Toolbox, V 2 


% REFERENCE:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Demonstration code for "Independent component analysis: A Tutorial Introduction"
% JV Stone, MIT Press, September 2004.
% Copyright: 2005, JV Stone, Psychology Department, Sheffield University, Sheffield, England.    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[N,d] = size(x);

% The following stores the extracted signals.
Y = zeros(N,d);

% Spherize the data.
[U D V]=svd(x,0);
z=U;
z=z./repmat(std(z,1),N,1);

% Specify the step size.
step = 0.02;
% Each column of the matrix will contain the mixing coeffiecients for one
% signal mixture. Note that we can extract a maximum of d signals.
mixmat = zeros(d,d);


for i = 1:d
    disp(['Finding signal ', int2str(i)])
    % Initialise weight vector and normalize.
    % These will go into the mixmat that is returned by the function.
    w = randn(1,d);
    w = w/norm(w);
    % Do projection pursuit using gradient ascent.
    for iter=1:200
        % Get estimated source signal, y.
        y = z*w';
        % Find gradient of kurtosis.
        y3 = y.^3;
        Y3 = repmat(y3,1,d);
        grad = mean(Y3.*z);
        % Update w and normalize.
        w = w + step*grad;
        w = w/norm(w);
    end
    
    % Store the extracted signal in Y as output.
    Y(:,i) = y(:);
    % Store the weight vector as output.
    mixmat(:,i) = w(:);
    
    % Now try the Gram-Schmidt orthogonalization
    % as applied to each column of the current z separately.
    % Remove this signal from each of the cols.   
    for j = 1:d
        z(:,j) = z(:,j) - y'*z(:,j)*y/(y'*y);
    end
    
    
end









