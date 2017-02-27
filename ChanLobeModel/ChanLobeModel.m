function [TCube,PCube,NCube,FCube,DCube,KeyPt] = ChanLobeModel(ModelParam)
    %% ------------------------------------------------------------------------
    % Initialized Surface Cubes
    % -------------------------------------------------------------------------
    FCube = zeros(ModelParam.GridInfo.ny,ModelParam.GridInfo.nx,ModelParam.SimParam.NEvent);
    PCube = zeros(ModelParam.GridInfo.ny,ModelParam.GridInfo.nx,ModelParam.SimParam.NEvent);
    NCube = zeros(ModelParam.GridInfo.ny,ModelParam.GridInfo.nx,ModelParam.SimParam.NEvent);
    TCube = zeros(ModelParam.GridInfo.ny,ModelParam.GridInfo.nx,ModelParam.SimParam.NEvent);
    DCube = cell(ModelParam.SimParam.NEvent,1);
    KeyPt = [];
    % -------------------------------------------------------------------------
    % Loop
    for ie=1:ModelParam.SimParam.NEvent
        %% --------------------------------------------------------------------
        % Generate centerline key points
        ModelParam = GeobodyCenterLine(ModelParam);
        % ---------------------------------------------------------------------
        % Generate all surfaces (Positive, Negative, Facies) for a geobody
        [DMap,Surfaces,cline,b1,b2,ModelParam] =...
                                Geobody(ModelParam.RuntimeParam.CPt,ModelParam);
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
        DCube{ie} = sparse(DMap);
        KeyPt = [KeyPt;ModelParam.RuntimeParam.CPt];
        if (rem(ie,40)==0)
            ie
        end
    end