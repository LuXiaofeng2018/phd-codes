%% ------------------------------------------------------------------------
% test simulation
% ------------------------------------------------------------------------
run('EnviSetting');
rand('seed',10);
randn('seed',15);
% %% ------------------------------------------------------------------------
% % Initial parameters
% % -------------------------------------------------------------------------
% InitParameters;
% %% ------------------------------------------------------------------------
% % Derivative parameters
% % -------------------------------------------------------------------------
% DerivedParameters;
%% ------------------------------------------------------------------------
% -------------------------------------------------------------------------
NS = 1;
% -------------------------------------------------------------------------
% slim to fat lobes
% f_w = [0.3 0.5 0.7];
f_w = [0.5];
% -------------------------------------------------------------------------
% slim to fat lobes
bMPP = [0.1 0.5 0.9];
aMPP = [0.1 0.5 0.9];
% bMPP = [0.5];
% -------------------------------------------------------------------------
SimInfo = zeros(NS*length(bMPP)*length(f_w),3);
% loop for the test
scount =1;
for i=1:NS
    for j=1:length(aMPP)
        for k=1:length(bMPP)
            scount
            %% ------------------------------------------------------------------------
            % Initial parameters
            % -------------------------------------------------------------------------
            InitParameters;
            %% ------------------------------------------------------------------------
            % Derivative parameters
            % -------------------------------------------------------------------------
            DerivedParameters;

            ModelParam.RuntimeParam.kaiMPP = aMPP(j); % LobeW/LobeL ratio
            ModelParam.RuntimeParam.bMPP = bMPP(k); % MPP direction factor

            SimName = sprintf('Sim_aMPP=%4.3f, Sim_bMPP=%4.3f',...
                ModelParam.RuntimeParam.kaiMPP,ModelParam.RuntimeParam.bMPP)
            sprintf('i=%d',i)
            
            [TCube,PCube,NCube,FCube,LSPt,ModelParam] = CRWLobeModel(ModelParam);
            save(sprintf('sim%d_%4.3f_%4.3f.mat',scount,ModelParam.RuntimeParam.kaiMPP,ModelParam.RuntimeParam.bMPP),'TCube','PCube','NCube','FCube','LSPt','ModelParam');
            SimInfo(scount,:) = [scount,ModelParam.RuntimeParam.kaiMPP,ModelParam.RuntimeParam.bMPP];
            scount = scount+1;
        end
    end
end
save(['SimInfo.mat'],'SimInfo');