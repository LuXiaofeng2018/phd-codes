function csmcmcdemo(maxiter,sigma)
% CSMCMCDEMO Markov chain Monte Carlo demo.
%
%   CSMCMCDEMO(N, SIGMA) implements a demo of MCMC. Here the target
%   distribution is a bivariate normal centered at the origin
%   with covariance matrix equal to the identiy matrix. The
%   proposal (or jumping) distribution is a bivariate normal
%   with mean given by the current place in the walk and a 
%   covariance matrix of SIGMA^2 * I.
%
%   CSMCMCDEMO will perform 1500 iterations of the chain and 
%   SIGMA is 0.2.
%
%   The figure shows the paths that the chain takes. The user can
%   experiment with different values of SIGMA to see the effect this
%   has on mixing.

%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox 


if nargin == 0 
    maxiter=1500;
    sigma = 0.2;
end

data=zeros(maxiter*5,2);   %keep track of the variates in the streams, 
% each 2*col is a step in the MC or a bivarite iterate, each row is a stream

Hfig1=figure;  % for paths
set(Hfig1,'units','normalized','position',[0.0414    0.4004    0.4500    0.5000])
HIter=uicontrol(Hfig1,'units','normalized','position',[0.45 0.93 0.1 0.05],'style','text');

% set up starting points
Xo=[-4 -4; -4 4;4 -4; 4 4; 1 1];
data(1:5,:)=Xo;

% Plot initial points

plot(Xo(1,1),Xo(1,2),'ro',Xo(2,1),Xo(2,2),'go',Xo(3,1),Xo(3,2),'bo',Xo(4,1),Xo(4,2),'mo',Xo(5,1),Xo(5,2),'co')
axis([-5 5 -5 5])
xlabel('X'),ylabel('Y')
set(gca,'drawmode','fast','TickLength',[0 0]);
set(gcf,'backingstore','off')

Hlin1=line(Xo(1,1),Xo(1,2));
set(Hlin1,'color','r','linewidth',2,'erasemode','none')
Hlin2=line(Xo(2,1),Xo(2,2));
set(Hlin2,'color','g','linewidth',2,'erasemode','none')
Hlin3=line(Xo(3,1),Xo(3,2));
set(Hlin3,'color','b','linewidth',2,'erasemode','none')
Hlin4=line(Xo(4,1),Xo(4,2));
set(Hlin4,'color','m','linewidth',2,'erasemode','none')
Hlin5=line(Xo(5,1),Xo(5,2));
set(Hlin5,'color','c','linewidth',2,'erasemode','none')
drawnow;

for t = 2:maxiter
   % generate a candidate stepping point for each stream
   for i=1:5
      Xstep(i,:)=csmvrnd(Xo(i,:)',sigma^2*eye(2),1);
   end
  
   % evaluate the ratios for each stream
   xold=diag(Xo*Xo');
   xnew=diag(Xstep*Xstep');
   ratio=exp(-.5*(xnew-xold));
   % find all of those ratios that are greater than 1
   indtmp=ratio>=1;
   % find indices where above was true
   ind=find(indtmp);  
   % take the step, because those ratios were > 1
   Xo(ind,:)=Xstep(ind,:);
   % find those that are not and check to see if will step
   indchk=find(indtmp==0);
   
   rnd=rand(size(indchk));
   indi=find(ratio(indchk)>rnd);  % these are indices where we should change
   indchg=indchk(indi);
   Xo(indchg,:)=Xstep(indchg,:);  % accept the worse steps
   
   % keep track of steps for data set - these will be the variates
   data((5*t-4):5*t,:)=Xo;
   
   % Do the plotting pf trajectories
   x1=5*t-4+[0 -5];
   x2=5*t-3+[0 -5];
   x3=5*t-2+[0 -5];
   x4=5*t-1+[0 -5];
   x5=5*t+[0 -5];
   
   set(Hlin1,'xdata',[data(x1,1)],'ydata',[data(x1,2)])
   set(Hlin2,'xdata',[data(x2,1)],'ydata',[data(x2,2)])
   set(Hlin3,'xdata',[data(x3,1)],'ydata',[data(x3,2)])
   set(Hlin4,'xdata',[data(x4,1)],'ydata',[data(x4,2)])
   set(Hlin5,'xdata',[data(x5,1)],'ydata',[data(x5,2)])
   set(HIter,'string',int2str(t))
   pause(.75);
   drawnow;
   
end

Hfig2=figure;   % for 
set(Hfig2,'units','normalized','position',[0.5164    0.4004    0.4500    0.5000])

plot(data(maxiter/2:maxiter,1),data(maxiter/2:maxiter,2),'.')
title('Scatterplot of Generated Variates')

