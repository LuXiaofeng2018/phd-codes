%% ------------------------------------------------------------------------
% test simulation
% ------------------------------------------------------------------------
run('EnviSetting');
%% ------------------------------------------------------------------------
% Initial parameters
% -------------------------------------------------------------------------
InitParameters;
%% ------------------------------------------------------------------------
% Derivative parameters
% -------------------------------------------------------------------------
DerivedParameters;
%% ------------------------------------------------------------------------
% Varying parameters for sensitivity test
% -------------------------------------------------------------------------
% OutLineControl.f_w = 0.7; % LobeW/LobeL ratio
% FaciesParam.Ft = [0.6]; % Threshold of facies change based on the distance map
% RuntimeParam.Gamma = 2;% controling the stacking pattern
% RuntimeParam.f_WCBelt = 1; % potential channel belt width
% -------------------------------------------------------------------------
NS = 5;
% -------------------------------------------------------------------------
% slim to fat lobes
f_w = linspace(0.3,0.7,NS);
% -------------------------------------------------------------------------
% few to more sand
Ft = linspace(0.3,0.8,NS);
% -------------------------------------------------------------------------
% less clustered to more
Gamma = logspace(log10(0.1),log10(3),NS);
% -------------------------------------------------------------------------
% channel sinuosity
f_WCBelt = linspace(0,1,NS);
% -------------------------------------------------------------------------
SimInfo = zeros(NS^4,5);
% loop for the test
scount =1;
for i=1:NS
    for j=1:NS
        for k=1:NS
            for t=1:NS
                scount
%                 if scount>447
                SimName = sprintf('Sim_fw=%4.3fFt=%4.3fGamma%4.3ffWCB%4.3f',...
                    f_w(i),Ft(j),Gamma(k),f_WCBelt(t))
                sprintf('i=%d j=%d k%d t=%d',i,j,k,t)
                ModelParam.OutLineControl.f_w = f_w(i); % LobeW/LobeL ratio
                ModelParam.FaciesParam.Ft = Ft(j); % Threshold of facies change based on the distance map
                ModelParam.RuntimeParam.Gamma = Gamma(k);% controling the stacking pattern
                ModelParam.RuntimeParam.f_WCBelt = f_WCBelt(t); % potential channel belt width
                [TCube,PCube,NCube,FCube,DCube,KeyPt] = ChanLobeModel(ModelParam);
%                 DCube = sparse(DCube);
                save(sprintf('sim%d',scount),'DCube','KeyPt','ModelParam');
                SimInfo(scount,:) = [scount,f_w(i),Ft(j),Gamma(k),f_WCBelt(t)];
%                 end
                scount = scount+1;
            end
        end
    end
end
save(['SimInfo.mat'],'SimInfo');