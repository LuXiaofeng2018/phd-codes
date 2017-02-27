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
            ProcParam = ModelParam.ProcParam;
            RuntimeParam = ModelParam.RuntimeParam;
            % initialize the channel half width given the lobe half width
            [LobeHalfWidth]=OvalShapeBound([0:GridInfo.dx:OutLineControl.L],...
                                OutLineControl.f_w,...
                                OutLineControl.f_LOffset,...
                                OutLineControl.oval_control); % compute the channel half width
            RuntimeParam.CW = LobeHalfWidth(1,2); % assign channel half width
            %% ------------------------------------------------------------------------
            % Generate centerline key points
            % -------------------------------------------------------------------------
            % get a random channel source if no previous values exist
            RuntimeParam.EventSource(1) = ProcParam.SXRange(1)+rand*ProcParam.WSource;
            RuntimeParam.EventSource(2) = ProcParam.SYRange(1)+rand*ProcParam.WSource;
            % -------------------------------------------------------------------------
            % Update source probability maps
            % update the distance to channel source map
            RuntimeParam.PSMap = MPMap(GridInfo.X,GridInfo.Y,RuntimeParam.EventSource,...
                                 RuntimeParam.Gamma,ProcParam.SW/2);
            % update the distance to prev lobe source map
            RuntimeParam.PLMap = MPMap(GridInfo.X,GridInfo.Y,RuntimeParam.CPt(3,:),...
                                 RuntimeParam.Gamma,RuntimeParam.CW);
            % update the depo thickness map
            RuntimeParam.PTMap = EPMap(RuntimeParam.CurrentSurf);
            % combine PSMap, PLMap, PTMap with assigned weights
            RuntimeParam.PDiMap(:,:,2)=RuntimeParam.PSMap;
            RuntimeParam.PDiMap(:,:,3)=RuntimeParam.PLMap;
            RuntimeParam.PDiMap(:,:,4) = RuntimeParam.PTMap;
            RuntimeParam.PMap = TauModel(RuntimeParam.PDiMap,RuntimeParam.Tau);
            % -------------------------------------------------------------------------
            % Draw lobe source
            RuntimeParam.CPt(3,:) = PtFromPMap(GridInfo.x,GridInfo.y,RuntimeParam.PMap);
            % -------------------------------------------------------------------------
            % Find the junction of ChannelSource-LobeSource line and the
            % region boundary
            RuntimeParam.CPt(1,:) = ChanBoundJunction(RuntimeParam.EventSource,...
                                    RuntimeParam.CPt(3,:),GridInfo.x(1));
            [RuntimeParam.CBeltMask, CHD, CPD, a, b, c] = ChannelBelt([RuntimeParam.CPt(1,:);...
                                                         RuntimeParam.CPt(3,:)],...
                                                         RuntimeParam.f_WCBelt,...
                                                         GridInfo.X,...
                                                         GridInfo.Y);
            if sum(RuntimeParam.CBeltMask(:))==0
            % -------------------------------------------------------------------------
            % update the distance to prev channel intermediate point map
                 RuntimeParam.CPt(2,:)=(RuntimeParam.CPt(1,:)+RuntimeParam.CPt(3,:))/2;
%                  [RuntimeParam.CBeltMask, CHD, CPD, a, b, c] = ChannelBelt([RuntimeParam.CPt(1,:);...
%                                                              RuntimeParam.CPt(3,:)],...
%                                                              RuntimeParam.f_WCBelt,...
%                                                              GridInfo.X,...
%                                                              GridInfo.Y);
%                  RuntimeParam.PCMap = MPMap(GridInfo.X,GridInfo.Y,nan(1,2),...
%                                     RuntimeParam.CBeltMask);                                     
            elseif sqrt(sum((RuntimeParam.CPt(1,:)-RuntimeParam.CPt(3,:)).^2)) < 5*GridInfo.dx
            % -------------------------------------------------------------------------
            % update the distance to prev channel intermediate point map
                 RuntimeParam.CPt(2,:)=(RuntimeParam.CPt(1,:)+RuntimeParam.CPt(3,:))/2;
                 [RuntimeParam.CBeltMask, CHD, CPD, a, b, c] = ChannelBelt([RuntimeParam.CPt(1,:);...
                                                             RuntimeParam.CPt(3,:)],...
                                                             RuntimeParam.f_WCBelt,...
                                                             GridInfo.X,...
                                                             GridInfo.Y);
                 RuntimeParam.PCMap = MPMap(GridInfo.X,GridInfo.Y,nan(1,2),...
                                      RuntimeParam.Gamma,RuntimeParam.CW,...
                                      RuntimeParam.CBeltMask);                                     
            else
            % -------------------------------------------------------------------------
            % Generate the potential channel belt region mask
                [RuntimeParam.CBeltMask, CHD, CPD, a, b, c] = ChannelBelt([RuntimeParam.CPt(1,:);...
                                                             RuntimeParam.CPt(3,:)],...
                                                             RuntimeParam.f_WCBelt,...
                                                             GridInfo.X,...
                                                             GridInfo.Y);
            % -------------------------------------------------------------------------
            % ChannelSource-LobeSource distance are too close,just set
            % channel middle points the same a
                RuntimeParam.PCMap = MPMap(GridInfo.X,GridInfo.Y,RuntimeParam.CPt(2,:),...
                                      RuntimeParam.Gamma,RuntimeParam.CW,...
                                      RuntimeParam.CBeltMask);                                     
                RuntimeParam.CPt(2,:) = PtFromPMap(GridInfo.x,GridInfo.y,RuntimeParam.PCMap,...
                                RuntimeParam.CBeltMask);
            end
            % -------------------------------------------------------------------------
            % Calculate the basic lobe direction from CPt(2,:) and CPt(3,:)
            RuntimeParam.CPt(4:5,:) = LobeKeyPoints(RuntimeParam.CPt(2:3,:),...
                                                    ProcParam.VTheta,...
                                                    OutLineControl.L);
            % -------------------------------------------------------------------------
            % return saved values
            ModelParam.OutLineControl = OutLineControl;
            ModelParam.GridInfo = GridInfo;
            ModelParam.ProcParam = ProcParam;
            ModelParam.RuntimeParam = RuntimeParam;
end