% -------------------------------------------------------------------------
% Visualize Cross Section of a Model Realization
% -------------------------------------------------------------------------
% Input:
%      CSec: A 2D matrix of the section we want to display, the section is 
%           from simulated surfaces;
%      FSave: Whether to save the plot or not
%      imgName: a string defining the saving name of your plot
%      fh: handle of the figure, only used when you want to give a figure
%      fhTitle: define the title name of your plot
% Output:
%      fh: the figure handle of your plot
function fh = CSection(CSec,FSave,imgName,fh,fhTitle)
        if nargin <5
            fhTitle = ['Cross Section _ Final Stratigraphy'];
        end
        if nargin <4
            fh = figure;
        end
        set(gcf, 'Position', get(0,'Screensize'));
        if nargin <3
            imgName = ['Cross Section _ Final Stratigraphy'];
        end
        if nargin <2
            FSave = false;
        end
        TSec = CSec(:,1:2:end);
        NewZT = TSec(:,2:end);
        NewZB = TSec(:,1:end-1);

        [NC,NZ]=size(NewZB);
        X = 1:NC;
        % -------------------------------------------------------------------------
        % -------------------------------------------------------------------------
        CSZT = NewZT;
        CSZB = NewZB;
        % -------------------------------------------------------------------------
        figure(fh);
        for s = 1:NZ
            cszt = CSZT(:,s);
            cszb = CSZB(:,s);
            csgs = ones(size(CSZB(:,s)))*s*2;
            % plot the grain sizes
            hold on;
            for i=1:NC-1
                x = [X(i) X(i) X(i+1) X(i+1)];
                y = [cszb(i) cszt(i) cszt(i+1) cszb(i+1)];
                c = ones(1,4)*csgs(i);
                if csgs(i)==0
                    c = nan(1,4);
                end
                patch(x,y,c,'EdgeColor','none','FaceColor','flat');
            end
            % plot the surfaces
        %     plot(X,cszb,'-k','LineWidth',1); 
        %     title(sprintf('%d',s),'FontSize',20);
            caxis([1 NZ*2]);
%             s
        end
        axis([1 NC min(TSec(:)) max(TSec(:))]);
        title(fhTitle,'FontSize',20);
        set(gca,'XTick',[],'YTick',[]);
        colormap('HSV');
        if FSave==true
            export_fig(imgName,'-jpg');
        end
end