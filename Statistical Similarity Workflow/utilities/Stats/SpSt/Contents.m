%Spatial Analysis
% 
% spst_G		G = spst_G(D, map, options)		Nearest Neighbor Function
% spst_GIJ		G = spst_GIJ(D1, D2, map, options)	Nearest Neighbor Function, Bivariate
% spst_F		F = spst_F(D, map, I, options)		Empty Space Function
%
% spst_pollard		P = spst_pollard(D, map, I, options)	Pollard's Index. Incorporates empty space information
% spst_ripleysK		K = spst_ripleysK(D, map,options)	Ripley's K. Test a population of points for spatial randomness
% spst_dixonS		S = spst_dixonS(D, map, options)	Dixon's S matrix. Distribution of mutual nearest neighbors in multivariated data
% spst_guha_rnn		RNN = spst_guha_rnn(D, options)		Guha's RNN curves for every datapoint in the set.
% spst_manlysW		W = spst_manlysW(D, k, options)		Manly's W. The mean distance to the k-nearest neighbor in the set.

%Wrappers
%
% spst_refNN		S = spst_RefNN(D, map, I, options)	Calculate all of the above and return in a struct S.
%

%Design of Datasets
%
% spst_dopt		R = spst_dopt(D, t, nsel, options)	Select nsel datapoints with D-optimality
% spst_mindist		R = spst_mindist(D, t, nsel, k, options) Select nsel datapints with Minimum Diversity
% spst_optisim		R = spst_optisim(D, nsel, options)	Select nsel datapoints using the OptiSim Algorithm
% spst_kennardstone	R = spst_kennardstone(D, t, nsel, options) Select nsel maximally diverse and uniformly distributed datapoints
% spst_knn_decoys	R = spst_knn_decoys(D, X, t, options)	Select a set of nearest decoys for each active
%

%Low-Level Helper Functions
%
% unifcsr		A realization of uniform complete spatial randomness
% convex_pseudo_data	Spatial randomness created from convex pseudo-data
% bootstrap		Spatial randomness created by bootstrapping
% sqeudist		Squared Euclidean distance
% nndist		Nearest neighbor distance
% chebydist		Chebychev distance
% citydist		City-Block or Manhattan distance
% distance		Wrapper for the distance functions
% isonmap		Are datapoints on map?
% dist2border		Distance to map's border
% circ_sec		Create a filled circle around datapoints