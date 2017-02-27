function[fillhandle,msg]=SurfChangeFill(xpoints,Zt,Zt1,transparency)
% fill depositional area by red, fill erosional area by blue
%Siyao Xu Febuary 2012;

if nargin<4 transparency = 0.4; end % default transparency is 0.5
add = 1; % plot on current grid
ec = 'b'; dc = 'r'; % erosion are blue, deposition are red
% start the primary work
if length(Zt1)==length(Zt) && length(Zt1)==length(xpoints)
    % find sub deposition areas
    dZ = (Zt1 - Zt);
    idxD = dZ>0;
    iDI = find(diff(idxD)~=0);
%     if length(iDI)<1 
%         return;
%     end
    if (length(iDI)>0)&&(iDI(1)>1)
        iDI = [1;iDI];
    end
    if (length(iDI)>0)&&(iDI(end)<length(xpoints))
        iDI = [iDI;length(xpoints)];
    end
    % plot the areas
    for i=1:length(iDI)-1
        % subpolygon indices
        if iDI(i)==1
            piL = iDI(i);
        else
            piL = iDI(i)+1;
        end
        piU = iDI(i+1);
        idx = [piL:piU];
        % skip if nothing occurrs
        if idxD(piL)
            % take the subpolygon and fill it
            filled=[Zt1(idx);flipud(Zt(idx))];
            x=[xpoints(idx),fliplr(xpoints(idx))];
            if add
                hold on
            end
            fillhandle=fill(x,filled,dc);% fill the area
            set(fillhandle,'FaceAlpha',transparency,'EdgeColor','none');% set transparency
            if add
                hold off
            end
        end
    end
    
    % find the erosion area
    dZ = (Zt1 - Zt);
    idxE = dZ<0;
    iEI = find(diff(idxE)~=0);
%     if length(iEI)<1 
%         return;
%     end
    if (length(iEI)>0)&&(iEI(1)>1)
        iEI = [1;iEI];
    end
    if (length(iEI)>0)&&(iEI(end)<length(xpoints))
        iEI = [iEI;length(xpoints)];
    end
    % plot the areas
    for i=1:length(iEI)-1
        % subpolygon indices
        if iEI(i)==1
            piL = iEI(i);
        else
            piL = iEI(i)+1;
        end
        piU = iEI(i+1);
        idx = [piL:piU];
        % skip if nothing occurrs
        if idxE(piL)
            % take the subpolygon and fill it
            filled=[Zt1(idx);flipud(Zt(idx))];
            x=[xpoints(idx),fliplr(xpoints(idx))];
            if add
                hold on
            end
            fillhandle=fill(x,filled,ec);% fill the area
            set(fillhandle,'FaceAlpha',transparency,'EdgeColor','none');% set transparency
            if add
                hold off
            end
        end
    end    
else
    msg='Error: Must use the same number of points in each vector';
end