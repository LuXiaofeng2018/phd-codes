%% ------------------------------------------------------------------------
% test simulation
% ------------------------------------------------------------------------
run('EnviSetting');
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
NS = 70;
% -------------------------------------------------------------------------
% slim to fat lobes
f_w = [0.3 0.5 0.7];
% f_w = [0.5];
% -------------------------------------------------------------------------
% slim to fat lobes
% bMPP = [0.2 0.5 0.8];
bMPP = [0.5];
% -------------------------------------------------------------------------
SimInfo = zeros(NS*length(bMPP)*length(f_w),3);
% loop for the test
scount =1;
for i=1:NS
    for j=1:length(f_w)
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

            SimName = sprintf('Sim_fw=%4.3f, Sim_bMPP=%4.3f', f_w(j),bMPP(k))
            sprintf('i=%d',i)
            ModelParam.OutLineControl.f_w = f_w(j); % LobeW/LobeL ratio
            ModelParam.RuntimeParam.bMPP = bMPP(k); % MPP direction factor

            [TCube,PCube,NCube,FCube,LSPt,ModelParam] = CRWLobeModel(ModelParam);
            save(sprintf('sim%d',scount),'TCube','PCube','NCube','FCube','LSPt','ModelParam');
            SimInfo(scount,:) = [scount,f_w(j),bMPP(k)];
            scount = scount+1;
        end
    end
end
save(['SimInfo.mat'],'SimInfo');