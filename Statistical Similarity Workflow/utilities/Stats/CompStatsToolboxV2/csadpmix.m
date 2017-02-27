function [pies,mus,covm] = csadpmix(x,maxterms,tc)
% CSADPMIX  Adaptive mixtures density estimation.
%
%   [WGTS,MU,COVM] = CSADPMIX(X,MAXTERMS,TC)
%   This function returns the adaptive mixtures density
%   estimate based on the observations in X.
%
%   X is the data matrix, where each row is an observation.
%   MAXTERMS is the maximum allowed number of terms.
%   TC is the create threshold. This is optional. Default
%   values are available for 1-D, 2-D and 3-D data.
%
%   WGTS is a vector of weights for each component density.
%   MU is an array of means, where each column corresponds to a component mean.
%   COVM is a 3-D array of covariance matrices. Each page (third dimension)
%   is a component d x d covariance matrix. In the univariate case, this is a
%   vector of component variances.
%
%   EXAMPLE
%
%   load snowfall
%   [wgts, mus, vars] = csadpmix(snowfall,25);

%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox

[n,p]=size(x);

if n==1 | p==1
    % then it is univariate data.
    x = x(:);
    p=1;
end

if nargin == 2
    if p == 1
        tc = 1;
    elseif p == 2
        tc = 2.34;
    elseif p == 3
        tc = 3.54;
    else
        error('You must specify the create threshold.')
    end
end

if p==1
    % Do the univariate case
    n=length(x);
    mus=zeros(1,maxterms);
    vars=zeros(1,maxterms);
    pies=zeros(1,maxterms); 
    posterior=zeros(1,maxterms);
    % lower bound on new pies
    minpie=.00001;					
    % bound on variance
    sievebd=1000;			
    % initialze density to first data point
    nterms=1;
    mus(1)=x(1);
    % rule of thumb for initial variance - univariate
    vars(1)=(std(x))^2/2.5;							
    pies(1)=1;
    % loop through all of the data points
    for i=2:n
        md=((x(i)-mus(1:nterms)).^2)./vars(1:nterms);
        if min(md)>tc & nterms<maxterms
            create=1;
        else
            create=0;
        end
        if create==0						% update terms
            posterior(1:nterms)=...
                csrpostup(x(i),pies,mus,vars,nterms);
            [pies(1:nterms),mus(1:nterms),...
                    vars(1:nterms)]=csrup(x(i),pies,mus,...
                vars,posterior,nterms,i);
        else					% create a new term
            nterms=nterms+1;
            mus(nterms)=x(i);
            pies(nterms)=max([1/(i),minpie]);											
            % update pies
            pies(1:nterms-1)=...
                pies(1:nterms-1)*(1-pies(nterms));
            vars(nterms)=...
                cssetvar(mus,pies,vars,x(i),nterms-1);
        end 					% end if statement
        % to prevent spiking of variances
        index=find(vars(1:nterms)<1/(sievebd*nterms));
        vars(index)=ones(size(index))/(sievebd*nterms);
    end    % for i loop
    % clean up the model - get rid of the 0 terms
    mus((nterms+1):maxterms)=[];
    pies((nterms+1):maxterms)=[];
    vars((nterms+1):maxterms)=[];
    covm = vars;
else
    % Do the multivariate case.
    % get constants, set up vectors
    data = x;
    [n,d]=size(data);
    max_data=max(data);	%gives max in each dimension
    min_data=min(data);
    mus=zeros(d,maxterms);	%each col is a term
    vars=zeros(d,maxterms*d);	%each dxd submatrix is term
    pies=zeros(1,maxterms);
    posterior=zeros(1,maxterms);
    minpie=.00001;		% lower bound on new pies
    sievebd=1000;		% bounding the parameter space
    % initialize density to first data point        
    nterms=1;
    mus(:,1)=data(1,:)';
    vars(:,1:d)=eye(d,d);
    pies(1)=1; 
    for i=2:n
        if ~createm(data(i),pies,mus,vars,tc,nterms,maxterms)	% update terms
            posterior(1:nterms)=rpostupm(data(i,:)',pies,mus,vars,nterms);
            vars=rvarupm(data(i,:),pies,mus,vars,posterior,nterms,i);
            mus=rmuupm(data(i,:),pies,mus,posterior,nterms,i);
            pies(1:nterms)=rpieupm(posterior,pies,i,nterms);
            
        else	% create a new term
            nterms=nterms+1;
            mus(:,nterms)=data(i,:)';
            pies(nterms)=max([1/(i),minpie]);	% update pies
            pies(1:nterms-1)=pies(1:nterms-1)*(1-pies(nterms));
            vars(:,d*(nterms-1)+1:d*nterms)=setvarm(mus,pies,vars,data(i,:),nterms-1);
        end 	% end if create statement            
    end  % for i loop
    % Clean up the arrays.
    mus(:,(nterms+1):maxterms) = [];
    pies((nterms+1):maxterms) = [];
    % Note that each page is a covariance matrix for a term.
    covm = zeros(d,d,nterms);
    for i = 1:nterms
        cov(:,:,i) = vars(:,((i-1)*d+1):i*d);
    end
end

    