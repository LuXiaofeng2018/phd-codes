% Example 9.11
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% Create some artificial two-term mixture data
n = 200;
data = zeros(n,2);
% Now generate 200 random variables. First find
% the number that come from each component.
r = rand(1,n);
% Find the number generated from component 1.
ind = length(find(r <= 0.5));
% Create some mixture data. Note that the 
% component densities are multivariate normals.
% Generate the first term.
data(1:ind,1) = randn(ind,1) - 2;
data(1:ind,2) = randn(ind,1) + 2;
% Generate the second term.
data(ind+1:n,1) = randn(n-ind,1) + 2;
data(ind+1:n,2) = randn(n-ind,1);

c = 2;   % number of terms
[n,d] = size(data);  % n=# pts, d=# dims
tol = 0.00001;		% set up criterion for stopping EM
max_it = 100;
totprob = zeros(n,1);

% Get the initial parameters for the model to start EM
mu(:,1) = [-1 -1]';			% each column represents a mean
mu(:,2) = [1 1]';
mix_cof = [0.3 0.7];
var_mat(:,:,1) = eye(d);
var_mat(:,:,2) = eye(d);
varup=zeros(size(var_mat));
muup = zeros(size(mu));
% Just to get started.
num_it = 1;
deltol = tol+1;		% to get started

while num_it <= max_it & deltol > tol
   % get the posterior probabilities
   totprob=zeros(n,1);
			for i=1:c      
				posterior(:,i) = mix_cof(i)*...
         csevalnorm(data,mu(:,i)',var_mat(:,:,i));
      totprob = totprob+posterior(:,i);
   end
   den = totprob*ones(1,c);  
   posterior = posterior./den;
   % Update the mixing coefficients.
   mix_cofup = sum(posterior)/n;
   % Update the means.
      mut = data'*posterior;
   MIX = ones(d,1)*mix_cof;
   muup = mut./(MIX*n);
   % Update the means and the variances.
   for i=1:c
      cen_data = data-ones(n,1)*mu(:,i)';
      mat = cen_data'*...
         diag(posterior(:,i))*cen_data;
      varup(:,:,i)=mat./(mix_cof(i)*n);
   end
   % Get the tolerances.
   delvar = max(max(max(abs(varup-var_mat))));
   delmu = max(max(abs(muup-mu)));
   delpi = max(abs(mix_cof-mix_cofup));
   deltol = max([delvar,delmu,delpi]);
   % Reset parameters.
   num_it = num_it+1;
   mix_cof = mix_cofup;
   mu = muup;
   var_mat = varup;
end  % while loop