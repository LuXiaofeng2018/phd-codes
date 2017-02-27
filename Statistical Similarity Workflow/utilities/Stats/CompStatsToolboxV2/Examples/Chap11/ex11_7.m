% Example 11.7
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% First load the data.
load insect
% Again, we will look only at the first
% two dimensions in this example.
X = insect(:,1:2);

% Call the model-based clustering function
% using a maximum of 6 models. 
[bics,bestmodel,allmodel,Z,clabs] = ...
    mbclust(X,6);

% Plot the BIC values.
plotbic(bics)
 
axis([0     7  -560  -510])


% cluster ID's for the best model.
% 
%      1     2     3     4     5     6     7     8     9    10    13
%     11    12    14    15    16    17    18    19    20
%     21    22    23    24    25    26    27    28    29    30



% Now plot the obsevations with symbols
% corresponding to the model-based
% clustering labels.
% ind1 = find(clabs == 1);
% ind2 = find(clabs == 2);
% ind3 = find(clabs == 3);
% % Plot using different plotting symbols.
% plot(X(ind1,1),X(ind1,2),'.')
% hold on
% plot(X(ind2,1),X(ind2,2),'+')
% plot(X(ind3,1),X(ind3,2),'x')
% hold off
% xlabel('Width First Joint (microns)')
% ylabel('Width Second Joint (microns)')
% title('Best Model from Model-Based Clustering')
% 
% opts = struct('FontMode','fixed','FontSize',6,'height',3,'Color','bw');
% exportfig(gcf,'fig1111.eps',opts)

