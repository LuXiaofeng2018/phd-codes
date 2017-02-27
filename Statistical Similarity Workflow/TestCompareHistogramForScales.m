close all;clc;clear
run('EnviSetting');
%% ------------------------------------------------------------------------
% Compare hitogram with K-S test - xD|SD
% Borneo
load('.\P(xD_SD)\Borneo_NND');
Borneo = norm_NND;
% Summer scales
load('.\P(xD_SD)\Summer_NND');
Summer = norm_NND;
load('.\P(xD_SD)\Scales\Summer\Summer_127Groups_Extr_NND_PxD_SD.mat');
Summer127 = norm_NND;
load('.\P(xD_SD)\Scales\Summer\Summer_87Groups_Extr_NND_PxD_SD.mat');
Summer87 = norm_NND;
load('.\P(xD_SD)\Scales\Summer\Summer_67Groups_Extr_NND_PxD_SD.mat');
Summer67 = norm_NND;
load('.\P(xD_SD)\Scales\Summer\Summer_54Groups_Extr_NND_PxD_SD.mat');
Summer54 = norm_NND;
load('.\P(xD_SD)\Scales\Summer\Summer_47Groups_Extr_NND_PxD_SD.mat');
Summer47 = norm_NND;
load('.\P(xD_SD)\Scales\Summer\Summer_41Groups_Extr_NND_PxD_SD.mat');
Summer41 = norm_NND;
load('.\P(xD_SD)\Scales\Summer\Summer_33Groups_Extr_NND_PxD_SD.mat');
Summer33 = norm_NND;
% WCD scales
load('.\P(xD_SD)\WCD_NND');
WCD = norm_NND;
load('.\P(xD_SD)\Scales\WCD\WCD_114Groups_Extr_NND_PxD_SD.mat');
WCD114 = norm_NND;
load('.\P(xD_SD)\Scales\WCD\WCD_87Groups_Extr_NND_PxD_SD.mat');
WCD87 = norm_NND;
load('.\P(xD_SD)\Scales\WCD\WCD_64Groups_Extr_NND_PxD_SD.mat');
WCD64 = norm_NND;
load('.\P(xD_SD)\Scales\WCD\WCD_55Groups_Extr_NND_PxD_SD.mat');
WCD55 = norm_NND;
load('.\P(xD_SD)\Scales\WCD\WCD_42Groups_Extr_NND_PxD_SD.mat');
WCD42 = norm_NND;
load('.\P(xD_SD)\Scales\WCD\WCD_37Groups_Extr_NND_PxD_SD.mat');
WCD37 = norm_NND;
load('.\P(xD_SD)\Scales\WCD\WCD_35Groups_Extr_NND_PxD_SD.mat');
WCD35 = norm_NND;
%% -------------------------------------------------------------------------
% univariate tests: K-S
pvalsS_SD=[];
pvalsS_theta=[];
pvalsS_poly=[];
pvalsS_shape=[];
pvalsW_SD=[];
pvalsW_theta=[];
pvalsW_poly=[];
pvalsW_shape=[];
% -------------------------------------------------------------------------
% 1. Summer - Borneo
[h,pvalsS_SD(1)] = kstest2(Summer(:,1),Borneo(:,1));
[h,pvalsS_theta(1)] = kstest2(Summer(:,2),Borneo(:,2));
[h,pvalsS_poly(1)] = kstest2(Summer(:,3),Borneo(:,3));
[h,pvalsS_shape(1)] = kstest2(Summer(:,4),Borneo(:,4));
% 2. Summer127 - Borneo
[h,pvalsS_SD(2)] = kstest2(Summer127(:,1),Borneo(:,1));
[h,pvalsS_theta(2)] = kstest2(Summer127(:,2),Borneo(:,2));
[h,pvalsS_poly(2)] = kstest2(Summer127(:,3),Borneo(:,3));
[h,pvalsS_shape(2)] = kstest2(Summer127(:,4),Borneo(:,4));
% 3. Summer87 - Borneo
[h,pvalsS_SD(3)] = kstest2(Summer87(:,1),Borneo(:,1));
[h,pvalsS_theta(3)] = kstest2(Summer87(:,2),Borneo(:,2));
[h,pvalsS_poly(3)] = kstest2(Summer87(:,3),Borneo(:,3));
[h,pvalsS_shape(3)] = kstest2(Summer87(:,4),Borneo(:,4));
% 4. Summer67 - Borneo
[h,pvalsS_SD(4)] = kstest2(Summer67(:,1),Borneo(:,1));
[h,pvalsS_theta(4)] = kstest2(Summer67(:,2),Borneo(:,2));
[h,pvalsS_poly(4)] = kstest2(Summer67(:,3),Borneo(:,3));
[h,pvalsS_shape(4)] = kstest2(Summer67(:,4),Borneo(:,4));
% 5. Summer54 - Borneo
[h,pvalsS_SD(5)] = kstest2(Summer54(:,1),Borneo(:,1));
[h,pvalsS_theta(5)] = kstest2(Summer54(:,2),Borneo(:,2));
[h,pvalsS_poly(5)] = kstest2(Summer54(:,3),Borneo(:,3));
[h,pvalsS_shape(5)] = kstest2(Summer54(:,4),Borneo(:,4));
% 6. Summer47 - Borneo
[h,pvalsS_SD(6)] = kstest2(Summer47(:,1),Borneo(:,1));
[h,pvalsS_theta(6)] = kstest2(Summer47(:,2),Borneo(:,2));
[h,pvalsS_poly(6)] = kstest2(Summer47(:,3),Borneo(:,3));
[h,pvalsS_shape(6)] = kstest2(Summer47(:,4),Borneo(:,4));
% 7. Summer41 - Borneo
[h,pvalsS_SD(7)] = kstest2(Summer41(:,1),Borneo(:,1));
[h,pvalsS_theta(7)] = kstest2(Summer41(:,2),Borneo(:,2));
[h,pvalsS_poly(7)] = kstest2(Summer41(:,3),Borneo(:,3));
[h,pvalsS_shape(7)] = kstest2(Summer41(:,4),Borneo(:,4));
% 8. Summer33 - Borneo
[h,pvalsS_SD(8)] = kstest2(Summer33(:,1),Borneo(:,1));
[h,pvalsS_theta(8)] = kstest2(Summer33(:,2),Borneo(:,2));
[h,pvalsS_poly(8)] = kstest2(Summer33(:,3),Borneo(:,3));
[h,pvalsS_shape(8)] = kstest2(Summer33(:,4),Borneo(:,4));
% -------------------------------------------------------------------------
% 1. WCD - Borneo
[h,pvalsW_SD(1)] = kstest2(WCD(:,1),Borneo(:,1));
[h,pvalsW_theta(1)] = kstest2(WCD(:,2),Borneo(:,2));
[h,pvalsW_poly(1)] = kstest2(WCD(:,3),Borneo(:,3));
[h,pvalsW_(1)] = kstest2(WCD(:,4),Borneo(:,4));
% 2. WCD114 - Borneo
[h,pvalsW_SD(2)] = kstest2(WCD114(:,1),Borneo(:,1));
[h,pvalsW_theta(2)] = kstest2(WCD114(:,2),Borneo(:,2));
[h,pvalsW_poly(2)] = kstest2(WCD114(:,3),Borneo(:,3));
[h,pvalsW_shape(2)] = kstest2(WCD114(:,4),Borneo(:,4));
% 3. WCD87 - Borneo
[h,pvalsW_SD(3)] = kstest2(WCD87(:,1),Borneo(:,1));
[h,pvalsW_theta(3)] = kstest2(WCD87(:,2),Borneo(:,2));
[h,pvalsW_poly(3)] = kstest2(WCD87(:,3),Borneo(:,3));
[h,pvalsW_shape(3)] = kstest2(WCD87(:,4),Borneo(:,4));
% 4. WCD64 - Borneo
[h,pvalsW_SD(4)] = kstest2(WCD64(:,1),Borneo(:,1));
[h,pvalsW_theta(4)] = kstest2(WCD64(:,2),Borneo(:,2));
[h,pvalsW_poly(4)] = kstest2(WCD64(:,3),Borneo(:,3));
[h,pvalsW_shape(4)] = kstest2(WCD64(:,4),Borneo(:,4));
% 5. WCD55 - Borneo
[h,pvalsW_SD(5)] = kstest2(WCD55(:,1),Borneo(:,1));
[h,pvalsW_theta(5)] = kstest2(WCD55(:,2),Borneo(:,2));
[h,pvalsW_poly(5)] = kstest2(WCD55(:,3),Borneo(:,3));
[h,pvalsW_shape(5)] = kstest2(WCD55(:,4),Borneo(:,4));
% 6. WCD42 - Borneo
[h,pvalsW_SD(6)] = kstest2(WCD42(:,1),Borneo(:,1));
[h,pvalsW_theta(6)] = kstest2(WCD42(:,2),Borneo(:,2));
[h,pvalsW_poly(6)] = kstest2(WCD42(:,3),Borneo(:,3));
[h,pvalsW_shape(6)] = kstest2(WCD42(:,4),Borneo(:,4));
% 7. WCD37 - Borneo
[h,pvalsW_SD(7)] = kstest2(WCD37(:,1),Borneo(:,1));
[h,pvalsW_theta(7)] = kstest2(WCD37(:,2),Borneo(:,2));
[h,pvalsW_poly(7)] = kstest2(WCD37(:,3),Borneo(:,3));
[h,pvalsW_shape(7)] = kstest2(WCD37(:,4),Borneo(:,4));
% 8. WCD35 - Borneo
[h,pvalsW_SD(8)] = kstest2(WCD35(:,1),Borneo(:,1));
[h,pvalsW_theta(8)] = kstest2(WCD35(:,2),Borneo(:,2));
[h,pvalsW_poly(8)] = kstest2(WCD35(:,3),Borneo(:,3));
[h,pvalsW_shape(8)] = kstest2(WCD35(:,4),Borneo(:,4));
% -------------------------------------------------------------------------
% plotout p_vals
figure;
X = [1:length(pvalsW_SD)];
subplot(2,2,1);
plot(X,pvalsS_SD,'-r',X,pvalsW_SD,'-b');
title('Source Distance');
subplot(2,2,2);
plot(X,pvalsS_theta,'-r',X,pvalsW_theta,'-b');
title('Orientation');
subplot(2,2,3);
plot(X,pvalsS_poly,'-r',X,pvalsW_poly,'-b');
title('Polygon Distance');
subplot(2,2,4);
plot(X,pvalsS_shape,'-r',X,pvalsW_shape,'-b');
title('Shape Similarity');
%% ------------------------------------------------------------------------
% Compare hitogram with K-S test - xD
load('.\P(xD)\Borneo_NND');
Borneo_ = norm_NND;
% Summer scales
load('.\P(xD)\Summer_NND');
Summer_ = norm_NND;
load('.\P(xD)\Scales\Summer\Summer_127Groups_Extr_NND_PxD.mat');
Summer127_ = norm_NND;
load('.\P(xD)\Scales\Summer\Summer_87Groups_Extr_NND_PxD.mat');
Summer87_ = norm_NND;
load('.\P(xD)\Scales\Summer\Summer_67Groups_Extr_NND_PxD.mat');
Summer67_ = norm_NND;
load('.\P(xD)\Scales\Summer\Summer_54Groups_Extr_NND_PxD.mat');
Summer54_ = norm_NND;
load('.\P(xD)\Scales\Summer\Summer_47Groups_Extr_NND_PxD.mat');
Summer47_ = norm_NND;
load('.\P(xD)\Scales\Summer\Summer_41Groups_Extr_NND_PxD.mat');
Summer41_ = norm_NND;
load('.\P(xD)\Scales\Summer\Summer_33Groups_Extr_NND_PxD.mat');
Summer33_ = norm_NND;
% WCD scales
load('.\P(xD)\WCD_NND');
WCD_ = norm_NND;
load('.\P(xD)\Scales\WCD\WCD_114Groups_Extr_NND_PxD.mat');
WCD114_ = norm_NND;
load('.\P(xD)\Scales\WCD\WCD_87Groups_Extr_NND_PxD.mat');
WCD87_ = norm_NND;
load('.\P(xD)\Scales\WCD\WCD_64Groups_Extr_NND_PxD.mat');
WCD64_ = norm_NND;
load('.\P(xD)\Scales\WCD\WCD_55Groups_Extr_NND_PxD.mat');
WCD55_ = norm_NND;
load('.\P(xD)\Scales\WCD\WCD_42Groups_Extr_NND_PxD.mat');
WCD42_ = norm_NND;
load('.\P(xD)\Scales\WCD\WCD_37Groups_Extr_NND_PxD.mat');
WCD37_ = norm_NND;
load('.\P(xD)\Scales\WCD\WCD_35Groups_Extr_NND_PxD.mat');
WCD35_ = norm_NND;
%% -------------------------------------------------------------------------
% univariate tests: K-S - xD
pvalsS_SD_=[];
pvalsS_theta_=[];
pvalsS_poly_=[];
pvalsS_shape_=[];
pvalsW_SD_=[];
pvalsW_theta_=[];
pvalsW_poly_=[];
pvalsW_shape_=[];
% -------------------------------------------------------------------------
% 1. Summer - Borneo
[h,pvalsS_SD_(1)] = kstest2(Summer_(:,1),Borneo_(:,1));
[h,pvalsS_theta_(1)] = kstest2(Summer_(:,2),Borneo_(:,2));
[h,pvalsS_poly_(1)] = kstest2(Summer_(:,3),Borneo_(:,3));
[h,pvalsS_shape_(1)] = kstest2(Summer_(:,4),Borneo_(:,4));
% 2. Summer127 - Borneo
[h,pvalsS_SD_(2)] = kstest2(Summer127_(:,1),Borneo_(:,1));
[h,pvalsS_theta_(2)] = kstest2(Summer127_(:,2),Borneo_(:,2));
[h,pvalsS_poly_(2)] = kstest2(Summer127_(:,3),Borneo_(:,3));
[h,pvalsS_shape_(2)] = kstest2(Summer127_(:,4),Borneo_(:,4));
% 3. Summer87 - Borneo
[h,pvalsS_SD_(3)] = kstest2(Summer87_(:,1),Borneo_(:,1));
[h,pvalsS_theta_(3)] = kstest2(Summer87_(:,2),Borneo_(:,2));
[h,pvalsS_poly_(3)] = kstest2(Summer87_(:,3),Borneo_(:,3));
[h,pvalsS_shape_(3)] = kstest2(Summer87_(:,4),Borneo_(:,4));
% 4. Summer67 - Borneo
[h,pvalsS_SD_(4)] = kstest2(Summer67_(:,1),Borneo_(:,1));
[h,pvalsS_theta_(4)] = kstest2(Summer67_(:,2),Borneo_(:,2));
[h,pvalsS_poly_(4)] = kstest2(Summer67_(:,3),Borneo_(:,3));
[h,pvalsS_shape_(4)] = kstest2(Summer67_(:,4),Borneo_(:,4));
% 5. Summer54 - Borneo
[h,pvalsS_SD_(5)] = kstest2(Summer54_(:,1),Borneo_(:,1));
[h,pvalsS_theta_(5)] = kstest2(Summer54_(:,2),Borneo_(:,2));
[h,pvalsS_poly_(5)] = kstest2(Summer54_(:,3),Borneo_(:,3));
[h,pvalsS_shape_(5)] = kstest2(Summer54_(:,4),Borneo_(:,4));
% 6. Summer47 - Borneo
[h,pvalsS_SD_(6)] = kstest2(Summer47_(:,1),Borneo_(:,1));
[h,pvalsS_theta_(6)] = kstest2(Summer47_(:,2),Borneo_(:,2));
[h,pvalsS_poly_(6)] = kstest2(Summer47_(:,3),Borneo_(:,3));
[h,pvalsS_shape_(6)] = kstest2(Summer47_(:,4),Borneo_(:,4));
% 7. Summer41 - Borneo
[h,pvalsS_SD_(7)] = kstest2(Summer41_(:,1),Borneo_(:,1));
[h,pvalsS_theta_(7)] = kstest2(Summer41_(:,2),Borneo_(:,2));
[h,pvalsS_poly_(7)] = kstest2(Summer41_(:,3),Borneo_(:,3));
[h,pvalsS_shape_(7)] = kstest2(Summer41_(:,4),Borneo_(:,4));
% 8. Summer33 - Borneo
[h,pvalsS_SD_(8)] = kstest2(Summer33_(:,1),Borneo_(:,1));
[h,pvalsS_theta_(8)] = kstest2(Summer33_(:,2),Borneo_(:,2));
[h,pvalsS_poly_(8)] = kstest2(Summer33_(:,3),Borneo_(:,3));
[h,pvalsS_shape_(8)] = kstest2(Summer33_(:,4),Borneo_(:,4));
% -------------------------------------------------------------------------
% 1. WCD - Borneo
[h,pvalsW_SD_(1)] = kstest2(WCD_(:,1),Borneo_(:,1));
[h,pvalsW_theta_(1)] = kstest2(WCD_(:,2),Borneo_(:,2));
[h,pvalsW_poly_(1)] = kstest2(WCD_(:,3),Borneo_(:,3));
[h,pvalsW_shape_(1)] = kstest2(WCD_(:,4),Borneo_(:,4));
% 2. WCD114 - Borneo
[h,pvalsW_SD_(2)] = kstest2(WCD114_(:,1),Borneo_(:,1));
[h,pvalsW_theta_(2)] = kstest2(WCD114_(:,2),Borneo_(:,2));
[h,pvalsW_poly_(2)] = kstest2(WCD114_(:,3),Borneo_(:,3));
[h,pvalsW_shape_(2)] = kstest2(WCD114_(:,4),Borneo_(:,4));
% 3. WCD87 - Borneo
[h,pvalsW_SD_(3)] = kstest2(WCD87_(:,1),Borneo_(:,1));
[h,pvalsW_theta_(3)] = kstest2(WCD87_(:,2),Borneo_(:,2));
[h,pvalsW_poly_(3)] = kstest2(WCD87_(:,3),Borneo_(:,3));
[h,pvalsW_shape_(3)] = kstest2(WCD87_(:,4),Borneo_(:,4));
% 4. WCD64 - Borneo
[h,pvalsW_SD_(4)] = kstest2(WCD64_(:,1),Borneo_(:,1));
[h,pvalsW_theta_(4)] = kstest2(WCD64_(:,2),Borneo_(:,2));
[h,pvalsW_poly_(4)] = kstest2(WCD64_(:,3),Borneo_(:,3));
[h,pvalsW_shape_(4)] = kstest2(WCD64_(:,4),Borneo_(:,4));
% 5. WCD55 - Borneo
[h,pvalsW_SD_(5)] = kstest2(WCD55_(:,1),Borneo_(:,1));
[h,pvalsW_theta_(5)] = kstest2(WCD55_(:,2),Borneo_(:,2));
[h,pvalsW_poly_(5)] = kstest2(WCD55_(:,3),Borneo_(:,3));
[h,pvalsW_shape_(5)] = kstest2(WCD55_(:,4),Borneo_(:,4));
% 6. WCD42 - Borneo
[h,pvalsW_SD_(6)] = kstest2(WCD42_(:,1),Borneo_(:,1));
[h,pvalsW_theta_(6)] = kstest2(WCD42_(:,2),Borneo_(:,2));
[h,pvalsW_poly_(6)] = kstest2(WCD42_(:,3),Borneo_(:,3));
[h,pvalsW_shape_(6)] = kstest2(WCD42_(:,4),Borneo_(:,4));
% 7. WCD37 - Borneo
[h,pvalsW_SD_(7)] = kstest2(WCD37_(:,1),Borneo_(:,1));
[h,pvalsW_theta_(7)] = kstest2(WCD37_(:,2),Borneo_(:,2));
[h,pvalsW_poly_(7)] = kstest2(WCD37_(:,3),Borneo_(:,3));
[h,pvalsW_shape_(7)] = kstest2(WCD37_(:,4),Borneo_(:,4));
% 8. WCD35 - Borneo
[h,pvalsW_SD_(8)] = kstest2(WCD35_(:,1),Borneo_(:,1));
[h,pvalsW_theta_(8)] = kstest2(WCD35_(:,2),Borneo_(:,2));
[h,pvalsW_poly_(8)] = kstest2(WCD35_(:,3),Borneo_(:,3));
[h,pvalsW_shape_(8)] = kstest2(WCD35_(:,4),Borneo_(:,4));
% -------------------------------------------------------------------------
% plotout p_vals
figure;
X = [1:length(pvalsW_SD_)];
subplot(2,2,1);
plot(X,pvalsS_SD_,'-r',X,pvalsW_SD_,'-b');
title('Source Distance');
subplot(2,2,2);
plot(X,pvalsS_theta_,'-r',X,pvalsW_theta_,'-b');
title('Orientation');
subplot(2,2,3);
plot(X,pvalsS_poly_,'-r',X,pvalsW_poly_,'-b');
title('Polygon Distance');
subplot(2,2,4);
plot(X,pvalsS_shape_,'-r',X,pvalsW_shape_,'-b');
title('Shape Similarity');