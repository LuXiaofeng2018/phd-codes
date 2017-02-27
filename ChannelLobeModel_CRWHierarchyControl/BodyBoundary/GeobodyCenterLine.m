% -------------------------------------------------------------------------
% Generate PMap of elevation
% Input:
%       ModelParam: Structure of model parameters with the centerline
%       points array empty
% Output:
%       ModelParam: with ModelParam.RuntimeParam.CPt filled with new points
function [ModelParam] = GeobodyCenterLine(ModelParam)
            % Surfaces
            OutLineControl = ModelParam.OutLineControl;
            GridInfo = ModelParam.GridInfo;
            PriorCdfs = ModelParam.PriorCdfs;
            ProcParam = ModelParam.ProcParam;
            RuntimeParam = ModelParam.RuntimeParam;
            SimRecord = ModelParam.SimRecord;
            % initialize the channel half width given the lobe half width
            [LobeHalfWidth]=OvalShapeBound([0:GridInfo.dx:OutLineControl.L],...
                                OutLineControl.f_w,...
                                OutLineControl.f_LOffset,...
                                OutLineControl.oval_control); % compute the channel half width
            RuntimeParam.CW = LobeHalfWidth(1,2); % assign channel half width
            %% ------------------------------------------------------------------------
            % Generate centerline key points
            % -------------------------------------------------------------------------
%             % get a random channel source if no previous values exist
%             RuntimeParam.EventSource(1) = ProcParam.SXRange(1)+rand*ProcParam.WSource;
%             RuntimeParam.EventSource(2) = ProcParam.SYRange(1)+rand*ProcParam.WSource;
            flag = 1;
            while(flag)
                % -------------------------------------------------------------------------
                % Sample MPP relative migrating distance lobe orientation shifting angle with the
                % prior pattern
                [RuntimeParam.SimDMPP, RuntimeParam.SimTLobe] = ...
                Seq_Priors(PriorCdfs.dRMPP, PriorCdfs.dThetaLobe);
                % -------------------------------------------------------------------------
                % Find the steepest direction at distance RuntimeParam.SimDMPP
                [TopoTheta] = SteepTheta(RuntimeParam.PMPP,RuntimeParam.SimDMPP,...
                    RuntimeParam.CurrentSurf, GridInfo.X, GridInfo.Y);
                % -------------------------------------------------------------------------
                % combine the steepest direction and the persistent direction
                % and use as the mean in Cauchy distribution for the next
                % location
                [muTheta,SimPVMPPTheta] = WMeanTheta...
                    (RuntimeParam.bMPP,RuntimeParam.PVMPPTheta,TopoTheta,RuntimeParam.PMPP,...
                    RuntimeParam.SimDMPP, RuntimeParam.kaiMPP,RuntimeParam.rangeMPP);
                %verify DMPP
                SimDMPP = sqrt( (SimPVMPPTheta(3)-SimPVMPPTheta(1)).^2 ...
                    + (SimPVMPPTheta(4)-SimPVMPPTheta(2)).^2 );
                RuntimeParam.SimDMPP = SimDMPP;
                flag = ~InModelDomain(SimPVMPPTheta(3:4),GridInfo.X,GridInfo.Y,GridInfo.dx);
            end
            RuntimeParam.PVMPPTheta = SimPVMPPTheta;
            
            % -------------------------------------------------------------------------
            % update MPP related parameters for the next loop
            RuntimeParam.SimMPP = RuntimeParam.PVMPPTheta(3:4);
            RuntimeParam.CPt(3,:) = RuntimeParam.SimMPP;
            % -------------------------------------------------------------------------
            % determine lobe end point
            [RuntimeParam.SimVThetaLobe,SimDTheta] = LobeDirection(SimRecord.VTLobe(1,:),...
                RuntimeParam.SimTLobe, RuntimeParam.SimMPP, RuntimeParam.CurrentSurf,...
                GridInfo.X, GridInfo.Y, OutLineControl.L);
            % verify L
            SimL = sqrt( (RuntimeParam.SimVThetaLobe(3)-RuntimeParam.SimVThetaLobe(1)).^2 ...
                + (RuntimeParam.SimVThetaLobe(4)-RuntimeParam.SimVThetaLobe(2)).^2);
            % verify TLobe
            VTLobe = SimRecord.VTLobe(1,:);
            u = [VTLobe(3:4)-VTLobe(1:2) 0];
            v = [RuntimeParam.SimVThetaLobe(3:4)-RuntimeParam.SimVThetaLobe(1:2) 0];
            RuntimeParam.SimTLobe = VecAng(u,v);
            % -------------------------------------------------------------------------
            % update lobe orientation related parameters for the next loop
            RuntimeParam.CPt(5,:) = RuntimeParam.SimVThetaLobe(3:4);
            RuntimeParam.CPt(4,:) = (RuntimeParam.CPt(5,:) + RuntimeParam.CPt(3,:))/2;
            
            RuntimeParam.PMPP = RuntimeParam.SimMPP;
            RuntimeParam.PVLobeTheta = RuntimeParam.SimVThetaLobe;
            % -------------------------------------------------------------------------
            % Calculate the basic lobe direction from CPt(2,:) and CPt(3,:)
            RuntimeParam.CPt(5,:) = LobeKeyPoints(RuntimeParam.CPt(3:4,:),...
                                                    ProcParam.VTheta,...
                                                    OutLineControl.L);
            RuntimeParam.CPt(4,:) = (RuntimeParam.CPt(5,:)+RuntimeParam.CPt(3,:))/2;
            % -------------------------------------------------------------------------
            % return saved values
            ModelParam.OutLineControl = OutLineControl;
            ModelParam.GridInfo = GridInfo;
            ModelParam.ProcParam = ProcParam;
            ModelParam.RuntimeParam = RuntimeParam;
end