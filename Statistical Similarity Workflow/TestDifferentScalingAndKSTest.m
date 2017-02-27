% -------------------------------------------------------------------------
% Surface Proc
% -------------------------------------------------------------------------
clear;close all;
AllNND = cell(4,1);
% Borneo
ImgPath = 'D:\workspace\TempWork\NewData\InfoExtract\BorneoCoarse\Extracted\';
FileName = 'Borneo_NND';
load([ImgPath FileName]);
AllNND(1) = {NND};
% Summer
ImgPath = 'D:\workspace\TempWork\NewData\InfoExtract\SummerCoarse\Extracted\';
FileName = 'Summer_NND';% Save name
load([ImgPath FileName]);
AllNND(2) = {NND};
% WCDCoarse
ImgPath = 'D:\workspace\TempWork\NewData\InfoExtract\WCDCoarse\Extracted\';
FileName = 'WCD_NND';% Save name
load([ImgPath FileName]);
AllNND(3) = {NND};
% WCDCoarse
ImgPath = 'D:\workspace\TempWork\NewData\InfoExtract\Amazon\Extracted\';
FileName = 'Amazon_NND';% Save name
load([ImgPath FileName]);
AllNND(4) = {NND};
% -------------------------------------------------------------------------
% plot cdfs
NNDb = cell2mat(AllNND(1));
NNDs = cell2mat(AllNND(2));
NNDw = cell2mat(AllNND(3));
NNDa = cell2mat(AllNND(4));

[F0,X0]=ecdf(NNDb(:,1));[F1,X1]=ecdf(NNDs(:,1));
[F2,X2]=ecdf(NNDw(:,1));[F3,X3]=ecdf(NNDa(:,1));
figure;plot(X0,F0,'-b',X1,F1,'-r',X2,F2,'-k',X3,F3,'-c');title('Source Point');
legend('Borneo','Summer','WCD','Amazon');

[F0,X0]=ecdf(NNDb(:,2));[F1,X1]=ecdf(NNDs(:,2));
[F2,X2]=ecdf(NNDw(:,2));[F3,X3]=ecdf(NNDa(:,2));
figure;plot(X0,F0,'-b',X1,F1,'-r',X2,F2,'-k',X3,F3,'-c');title('Orientation');
legend('Borneo','Summer','WCD','Amazon');

[F0,X0]=ecdf(NNDb(:,3));[F1,X1]=ecdf(NNDs(:,3));
[F2,X2]=ecdf(NNDw(:,3));[F3,X3]=ecdf(NNDa(:,3));
figure;plot(X0,F0,'-b',X1,F1,'-r',X2,F2,'-k',X3,F3,'-c');title('Polygon Distance');
legend('Borneo','Summer','WCD','Amazon');

[F0,X0]=ecdf(NNDb(:,4));[F1,X1]=ecdf(NNDs(:,4));
[F2,X2]=ecdf(NNDw(:,4));[F3,X3]=ecdf(NNDa(:,4));
figure;plot(X0,F0,'-b',X1,F1,'-r',X2,F2,'-k',X3,F3,'-c');title('Shape');
legend('Borneo','Summer','WCD','Amazon');

% -------------------------------------------------------------------------
% test with kstest2
PValSP = zeros(4);
PValT = zeros(4);
PValPoly = zeros(4);
PValSh = zeros(4);
for i=1:4
    for j=1:4
        samp1 = cell2mat(AllNND(i));
        samp2 = cell2mat(AllNND(j));
        [h,PValSP(i,j)]=kstest2(samp1(:,1),samp2(:,1));
        [h,PValT(i,j)]=kstest2(samp1(:,2),samp2(:,2));
        [h,PValPoly(i,j)]=kstest2(samp1(:,3),samp2(:,3));
        [h,PValSh(i,j)]=kstest2(samp1(:,4),samp2(:,4));
    end
end
