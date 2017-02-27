% Example 10.7
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

load iris
% This loads up three matrices: 
% setosa, versicolor and virginica.
% We will use the versicolor and virginica.
% Note that the priors are equal, so the decision is
% based on the class-conditional probabilities.
ncc = 0;
versicolor(:,3:4)=[];
virginica(:,3:4)=[];
[nver,d]=size(versicolor);
[nvir,d]=size(virginica);
n = nvir + nver;

% Loop first through all of the patterns corresponding
% to versicolor. Here correct classification 
% is obtained if pxgver > pxgvir;
muvir = mean(virginica);  
covvir = cov(virginica);
% These will be the same for this part.
for i = 1:nver
		% Get the test point and the training set
		versitrain = versicolor;
        % This is the testing point.
		x = versitrain(i,:);
        % Delete from training set.
        % The result is the training set.
		versitrain(i,:)=[];	
		muver = mean(versitrain);
		covver = cov(versitrain);
		pxgver=csevalnorm(x,muver,covver);
		pxgvir=csevalnorm(x,muvir,covvir);
		if pxgver > pxgvir							
			% then we correctly classified it
			ncc = ncc+1;
		end
end

% Loop through all of the patterns of virginica notes.
% Here correct classification is obtained when
% pxgvir > pxxgver
muver = mean(versicolor);
covver = cov(versicolor);
% These remain the same for the following.
for i = 1:nvir
		% Get the test point and training set
		virtrain = virginica;
		x = virtrain(i,:);
		virtrain(i,:)=[];
		muvir = mean(virtrain);
		covvir = cov(virtrain);
		pxgver = csevalnorm(x,muver,covver);
		pxgvir = csevalnorm(x,muvir,covvir);
		if pxgvir > pxgver							
			% then we correctly classified it
			ncc = ncc+1;
		end
end

pcc = ncc/n;
