% -------------------------------------------------------------------------
% Plot out the geometries of thresholded 2D wheeler diagram
% -------------------------------------------------------------------------
% Input:
%      WCSec: A 2D matrix of size [T X 2], output of ThreshWheeler2D
%            X: length of measuring line; T: Number of surfaces.
%            [T X 1]: Deposition 
%            [T X 2]: Erosion
%      FSave: Whether to save the plot or not
%      imgName: a string defining the saving name of your plot
%      fh: handle of the figure, only used when you want to give a figure
%      fhTitle: define the title name of your plot
% Output:
%      fh: the figure handle of your plot
function fh = GeometricWheeler2D(WCSec,FSave,imgName,fh,fhTitle)
    if nargin <5
        fhTitle = ['Geometry of Wheeler Diagram'];
    end
    if nargin <4
        fh = figure;
    end
    set(gcf, 'Position', get(0,'Screensize'));
    if nargin < 3
        imgName = 'Geometry_of_Wheeler_Diagram';
    end
    if nargin < 2
        FSave = false;
    end
    % Plot out the geometry
    thDAmountMap = squeeze(WCSec(:,:,1));
    thEAmountMap = squeeze(WCSec(:,:,2));
    [nst,nx] = size(thDAmountMap);
    set(gcf,'Units','normalized');
    Labels = {'X','T','Thickness (mm)'};
    Range = [0, nx-1; 0, nst-1;0 nst-1];
    for i=1:nst
        % deposition line
        DLine = thDAmountMap(i,:);
        idxDLine = DLine >0;
        ccd = bwconncomp(idxDLine,4);
        if ccd.NumObjects>0
            idxObj = ccd.PixelIdxList;
            for j=1:ccd.NumObjects
                J = idxObj{j}';
                I = ones(1,length(J));
                x1 = J-1; y1 = I*(i-1); x2 = [x1(1) x1 x1(end)]; y2 = [y1(1) DLine(J)+y1 y1(end)]-1;
                hold on;
                fill([x2 x2(1)],[y2 y2(1)],'r');
                hold off;
            end
        end
        % erosion line
        ELine = thEAmountMap(i,:);
        idxELine = ELine <0;
        cce = bwconncomp(idxELine,4);
        if cce.NumObjects>0
            idxObj = cce.PixelIdxList;
            for j=1:cce.NumObjects
                J = idxObj{j}';
                I = ones(1,length(J));
                x1 = J-1; y1 = I*(i-1); x2 = [x1(1) x1 x1(end)]; y2 = [y1(1) ELine(J)+y1 y1(end)];
                hold on;
                fill([x2 x2(1)],[y2 y2(1)],'b');
                hold off;
            end
        end
    end
    hAxis1 = get(gcf,'CurrentAxes'); 
    set(hAxis1,'YColor','k','Box','on','YAxislocation','Left','FontSize',14); 
    hAxis2 = axes('Parent',get(hAxis1,'Parent'),'Position',get(hAxis1,'Position')); 
    set(hAxis2,'Xlim',get(hAxis1,'Xlim'),'YAxisLocation','right','Color','none','XTickLabel',[],'Layer','top','YColor','k','FontSize',14); 
    set([hAxis1 hAxis2],'Xlim',Range(1,:)); 
    set(hAxis1,'Ylim',Range(2,:),'YAxislocation','left'); 
    set(hAxis2,'Ylim',Range(3,:),'YAxislocation','right');
    xlabel(hAxis1,Labels{1},'FontSize',16)
    ylabel(hAxis1,Labels{2},'FontSize',16);
    ylabel(hAxis2,Labels{3},'FontSize',16);
    linkaxes([hAxis1,hAxis2],'xy');
    title(hAxis1,fhTitle,'FontSize',20);
    if FSave
       export_fig(imgName,'-jpg');
    end
end