% -------------------------------------------------------------------------
% the function generating stratigraphy cube with a given topography cube
% -------------------------------------------------------------------------
function [S]=Stratigraphy(Z)
    [ny,nx,nz]=size(Z);
    S = zeros(ny,nx,nz);
    S(:,:,end)=Z(:,:,end);
    for i=nz-1:-1:1
        S(:,:,i)=min(S(:,:,i+1),Z(:,:,i));
%         subplot(2,1,1);
%         plot(squeeze(Z(:,150,i:i+1)));
%         legend(sprintf('%d',i),sprintf('%d',i+1));
%         subplot(2,1,2);
%         plot(squeeze(S(:,150,i)));
%         legend(sprintf('%d',i));        
    end
end