function [TCube,PCube,NCube,FCube,LSPt,ModelParam] = CRWLobeModel(ModelParam)
    %% ------------------------------------------------------------------------
    % Initialized Surface Cubes
    % -------------------------------------------------------------------------
    FCube = zeros(ModelParam.GridInfo.ny,ModelParam.GridInfo.nx,ModelParam.SimParam.NEvent);
    PCube = zeros(ModelParam.GridInfo.ny,ModelParam.GridInfo.nx,ModelParam.SimParam.NEvent);
    NCube = zeros(ModelParam.GridInfo.ny,ModelParam.GridInfo.nx,ModelParam.SimParam.NEvent);
    TCube = zeros(ModelParam.GridInfo.ny,ModelParam.GridInfo.nx,ModelParam.SimParam.NEvent);
    LSPt = zeros(ModelParam.SimParam.NEvent,2);
    % -------------------------------------------------------------------------
    for ie=1:ModelParam.SimParam.NEvent
        %% --------------------------------------------------------------------
        % Generate centerline key points
        ModelParam = GeobodyCenterLine(ModelParam);
        % Simulation records
        ModelParam.SimRecord.MPP(ie+1,:) = ModelParam.RuntimeParam.SimMPP;
        ModelParam.SimRecord.DMPP(ie+1,:) = ModelParam.RuntimeParam.SimDMPP;
        ModelParam.SimRecord.TLobe(ie+1,:) = ModelParam.RuntimeParam.SimTLobe;
        ModelParam.SimRecord.VTLobe(ie+1,:) = ModelParam.RuntimeParam.SimVThetaLobe;
        % ---------------------------------------------------------------------
        % Generate all surfaces (Positive, Negative, Facies) for a geobody
        [DMap,Surfaces,cline,b1,b2,ModelParam] =...
                                Geobody(ModelParam.RuntimeParam.CPt(3:5,:),ModelParam);
        PSurf = Surfaces(:,:,1);
        PSurf(isnan(PSurf))=0;
        NSurf = Surfaces(:,:,2);
        NSurf(isnan(NSurf))=0;
        FMap = Surfaces(:,:,3);
        % ---------------------------------------------------------------------
        % Update current surface and save geobody
        ModelParam.RuntimeParam.CurrentSurf = ModelParam.RuntimeParam.CurrentSurf + NSurf + PSurf;
        TCube(:,:,ie) = ModelParam.RuntimeParam.CurrentSurf;
        PCube(:,:,ie) = PSurf;
        NCube(:,:,ie) = NSurf;
        FCube(:,:,ie) = FMap;
        LSPt(ie,:) = ModelParam.RuntimeParam.CPt(3,:);
%         if (rem(ie,40)==0)
            ie
%         end
    end
    % Simulation records
    ModelParam.SimRecord.MPP = ModelParam.SimRecord.MPP(2:end,:);
    ModelParam.SimRecord.DMPP = ModelParam.SimRecord.DMPP(2:end,:);
    ModelParam.SimRecord.TMPP = ModelParam.SimRecord.TMPP(2:end,:);
    ModelParam.SimRecord.TLobe = ModelParam.SimRecord.TLobe(2:end,:);
    ModelParam.SimRecord.VTMPP = ModelParam.SimRecord.VTMPP(2:end,:);
    ModelParam.SimRecord.VTLobe = ModelParam.SimRecord.VTLobe(2:end,:);
end