% function pc = getprob(Nk,pies,Nkt)
%
% Nk is a vector containing the number of cases in the learning sample
% that belong to each class.
% pies is a vector containing the prior probabilities that it belongs to a class
% Nkt is a vector of the number of cases in the node t that belong to each class

function pc = getprob(Nk,pies,Nkt)

pkt = pies.*Nkt./Nk;
pt = sum(pkt);
pc = pkt/pt;

