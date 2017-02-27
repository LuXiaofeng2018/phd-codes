% -------------------------------------------------------------------------
% the function generating stratigraphy cube with a given topography cube
% -------------------------------------------------------------------------
function [S]=Stratigraphy2D(Z)
    [ny,nx]=size(Z);
    S = zeros(ny,nx);
    S(:,end)=Z(:,end);
    for i=nx-1:-1:1
        S(:,i)=min(S(:,i+1),Z(:,i));
%         subplot(2,1,1);
%         plot(squeeze(Z(:,i)));
%         hold on;
%         plot(squeeze(S(:,i+1)),'-g');
%         plot(squeeze(S(:,i)),'-r');
%         legend(sprintf('Z %d',i),sprintf('Z %d',i+1),sprintf('S %d',i));
%         hold off;
%         subplot(2,1,2);
%         plot(squeeze(S(:,i:nx)));
%         strLeg = [];
%         for j=nx:-1:i
%             strLeg = cat(1,sprintf('''S %d''',j),strLeg);
%         end
%         legend(strLeg);
    end
end