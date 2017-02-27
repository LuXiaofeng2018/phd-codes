function S = spst_RefNN(D, map, I, options)

disp('Calculating F...');
S.F = spst_F(D, map, I, options);

disp('Calculating G ...');
S.G = spst_G(D, map, options);

disp('Calculating S, sigmas, meds...');
S.S = zeros(size(S.F));

S.S(:,1) = S.F(:,1);
S.S(:,2) = S.F(:,2)-S.G(:,2);

S.sigmaS = sum(S.S(:,2));
S.sigmaG = sum(S.G(:,2));
S.sigmaF = sum(S.F(:,2));

mg = find(S.G(:,2)>=0.5,1, 'first');
if(size(mg,1)>0)
    S.medG = S.G(mg,1);
else
    S.medG = options.maxD;
end


mf = find(S.F(:,2)>=0.5,1, 'first');

if (size(mf,1)>0)
    S.medF = S.F(mf,1);
else
    S.medF = options.maxD;
end


disp('Calculating Manlys W.');
S.W = zeros(1,5);

for k=1:5
    S.W(1,k) = spst_manlysW(D, k, options);
end

disp('Calculating Ripleys K...');
S.K = spst_ripleysK(D, [], options);
S.sigmaK = sum(S.K(:,2));

S.xSpatial = [S.sigmaS, S.sigmaG, S.sigmaF, S.sigmaK, S.medG, S.medF, S.W];