% Computational Statistics Toolbox.
% Version 2.0     12-15-2007
%
% From the book 'Computational Statistics Handbook with MATLAB, 2nd Ed' by
%   Wendy and Angel Martinez, CRC Press, 2008.
%   
% For more information on these functions, type help func_name.
%
% 
%  Probability Density (Mass) Functions
%   csbetap     - Beta distribution
%   csbinop     - Binomial distribution
%   cschip      - Chi-square distribution
%   csexpop     - Exponential distribution
%   csgammp     - Gamma distribution
%   csnormp     - Normal distribution - univariate
%   csevalnorm  - Normal distribution - multivariate
%   cspoisp     - Poisson distribution
%   csunifp     - Continuous uniform distribution
%   csweibp     - Weibull distribution
%
%  Cumulative Distribution Functions
%   csbetac     - Beta distribution
%   csbinoc     - Binomial distribution
%   cschic      - Chi-square distribution
%   csexpoc     - Exponential distribution
%   csgammc     - Gamma distribution
%   csnormc     - Normal distribution - univariate
%   cspoisc     - Poisson distribution
%   csunifc     - Continuous uniform distribution
%   csweibc     - Weibull distribution
%
%  Parameter Estimation
%   csbinpar    - Binomial distribution
%   csexpar     - Exponential distribution
%   csgampar    - Gamma distribution
%   cspoipar    - Poisson distribution
%   csunipar    - Continuous uniform distribution
%
%  Quantiles - Inverse Cumulative Distribution
%   csbinoq     - Binomial distribution
%   csexpoq     - Exponential distribution
%   csunifq     - Continuous uniform distribution
%   csnormq     - Normal distribution - univariate
%   csweibq     - Weibull distribution
%   csquantiles - Returns the sample quantiles
%
%  Statistics
%   csmomentc   - Sample central moments
%   csmoment    - Sample moments
%   cskewness   - Coefficient of skewness
%   cskurtosis  - Coefficient of kurtosis - not excess kurtosis
%   csecdf      - Empirical cumulative distribution function
%   cscomb      - Combinations - n choose r
%   cscorr      - Correlation coefficient between x and y
%
%  Random Number Generation
%   csbetarnd   - Beta distribution
%   csbinrnd    - Binomial distribution
%   cschirnd    - Chi-square distribution
%   csdunrnd    - Discrete uniform distribution
%   csexprnd    - Exponential distribution
%   csgamrnd    - Gamma distribution
%   csmvrnd     - Normal distribution - multivariate
%   cspoirnd    - Poisson distribution
%   cssphrnd    - Points on the unit sphere
%   cssample    - Random sample from an arbitrary distribution
%
%  Exploratory Data Analysis
%   csstars     - Star plot
%   csstemleaf  - Stem-and-leaf plot
%   csparallel  - Parallel coordinates plot
%   csqqplot    - Q-Q plot
%   cspoissplot - Poissonness plot
%   csandrews   - Andrews curves
%   csexpoplot  - Exponential probability plot
%   csbinoplot  - Binomial plot
%   csppeda     - Projection pursuit exploratory data analysis
%   csppind     - Projection pursuit index - chi-square
%   csppstrtrem - Projection pursuit structure removal
%   boxp        - Box plot - Variable width and histplot
%   boxprct     - Box-percentile plot
%   isomap      - ISOMAP nonlinear dimensionality reduction
%   torustour   - Torus grand tour
%   csica       - Independent Component Analysis
%
%  Bootstrap and Jackknife
%   csboot      - Bootstrap of bias and standard error
%   csbootint   - Bootstrap-t confidence interval
%   csbooperint - Bootstrap percentile confidence interval
%   csbootbca   - Bootstrap Bias-corrected and accelerated confidence interval
%   csjack      - Jackknife estimate of bias and standard error
%   csjackboot  - Jackknife after bootstrap
%
%  Probability Density Estimation
%   cshist2d    - Bivariate density histogram
%   cshistden   - Univariate density histogram
%   csfreqpoly  - Frequency polygon density estimate
%   csash       - Univariate averaged shifted histogram
%   cskernmd    - Multivariate kernel density estimation
%   cskern1d    - Univariate kernel density estimation
%   cskern2d    - Bivariate kernel density estimation
%   csdfplot    - dF representation of the mixture parameter space
%   csplotuni   - Plot a univariate finite mixture density
%   csfinmix    - Univariate & multivariate finite mixture density estimation
%   csadpmix    - Univariate & multivariate adaptive mixture density estimation
%   genmix      - Generate finite mixture random variables - GUI
%
%  Classification Trees
%   csgrowc     - Grow a classification tree
%   csprunec    - Prune a classification tree
%   cstreec     - Classify an observation using a tree
%   csplotreec  - Plot a classification tree
%   cspicktreec - Extract a tree from the sequence of pruned trees
%
%  Supervised Learning
%   csrocgen    - Generate ROC curve
%   cskernmd    - Estimate class-conditional densities
%   cskern2d    - Estimate bivariate class-conditional densities
%   csboost     - Boosting with decision stumps
%   adabstdemo  - ADA boost demo
%   stumplearn  - Decision stump learner
%   stumpfunc   - Evaluate a decision stump classifier
%   aggregate   - Find the boosted ensemble classification
%
%  Unsupervised Learning
%   cshmeans    - K-means clustering
%   cskmeans    - K-means clustering
%   agmbclust   - Agglomerative clustering
%   mbcfinmix   - Model-based finite mixtures
%   mbclust     - Model-based clustering
%   mojenaplot  - Mojena plot for choosing the number of clusters
%   adjrand     - Adjusted Rand index to evaluate groupings
%   randind     - Rand index to evaluate groupings
%
%  Parametric and Nonparametric Models
%   csloess     - Loess smoothing
%   csloessenv  - Loess smoothing with upper and lower smooths
%   csloessr    - Robust loess smoothing
%   cslocpoly   - Local polynomial smoothing
%   csloclin    - Local linear regression
%   csnardwats  - Nardarya-Watson regression
%   spfit       - Spline regression
%   csbinsmth   - Bin smoother
%   csrmeansmth - Running mean smoother
%   csbootband  - Bootstrap confidence bands
%   cssplinesmth  Cubic smoothing spline
%   csadmodel   - Additive model with smoothing splines
%
%  Regression Trees
%   csgrowr     - Grow a regression tree
%   cspruner    - Prune a regression tree
%   cstreer     - Return function estimate using a tree
%   csplotreer  - Plot a regression tree
%   cspicktreer - Extract a tree from the sequence of pruned trees
%
%  Markov Chain Monte Carlo
%   csgelrub    - Gelman-Rubin convergence diagnostic
%   csmcmcdemo  - Demo of the Metropolis-Hastings sampler
%
%  Spatial Statistics
%   csbinproc       - Generate binomial spatial point process
%   csclustproc     - Generate cluster spatial point process
%   csinhibproc     - Generate regular spatial point process
%   cspoissproc     - Generate Poisson spatial point process
%   csstraussproc   - Generate a Strauss spatial point process
%   csgetregion     - Interactively set a study region
%   csintkern       - Estimate intensity using kernels
%   csfhat          - Estimate the F distribution function
%   csghat          - Estimate the G distribution function
%   cskhat          - Estimate the K function
%