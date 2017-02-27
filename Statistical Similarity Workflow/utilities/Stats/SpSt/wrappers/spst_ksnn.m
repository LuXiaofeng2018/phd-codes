function [R, S] = spst_ksnn(act, dec, classes, nact, ndec, options)

disp('Generating datasets of actives with maximum spread. (Kennard-Stone Design)');
R.mode.act = 'KS';
R.mode.dec = 'kNN';

for i=1:size(classes,1);
    classe = char(classes(i));
    disp(classe);
    R.act.(classe)=spst_kennardstone(act.(classe).dsc, [], nact, options);
    G = spst_G(act.(classe).dsc(R.act.(classe),:), [], options);
    S.sigmaG(i,1) = sum(G(:,2));
end
   
disp('Generating datasets of decoys with minimum separation. (k-Nearest Neighbor Design)');

for i=1:size(classes,1);
    classe = char(classes(i));
    disp(classe);
    R.dec.(classe)= spst_knn_decoys(act.(classe).dsc, dec.(classe).dsc, R.act.(classe), ndec, options);
    F = spst_F(act.(classe).dsc(R.act.(classe),:), [], dec.(classe).dsc(R.dec.(classe),:), options);
    S.sigmaF(i,1) = sum(F(:,2));
end
