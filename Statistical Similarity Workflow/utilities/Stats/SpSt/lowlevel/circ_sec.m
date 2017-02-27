function s = circ_sec(c, R, mode)
% s = circ_sec(c, R)
%
%   Input:  c       center of circle
%           R       Radius of the circle
%           mode    Distance mode. Possible values are:
%                   'euc':      Euclidean Distance
%                   'cheby':    Chebychev Distance
%                   'city':     City-Block (Manhattan) Distance
%
%   Output: s       matrices of x and y coordinates of circle points
%



if (strcmpi(mode, 'euc'))
    % number of rings
    step_width = 1/5;

    r = (step_width:step_width:1)*R;
    r = ones(30,1) *r;

    % 1 sector per 12°
    i = (pi/15:pi/15:2*pi)';

    % x and y for unitary circle
    X = cos(i) * ones(1,5);
    Y = sin(i) * ones(1,5);

    % x and y for all rings
    x = (X.*r)+c(1).*ones(30, 5);
    y = (Y.*r)+c(2).*ones(30, 5);

    x = x(:);
    y = y(:);

    s = [x y];
    
elseif(strcmpi(mode, 'cheby'))
    s = [];
    R = fix(R);
    for i=-R:R
        for j = -R:R
            s = [s;[i j]];
        end
    end
    
    s = s + ones(size(s,1),1)*c;
elseif(strcmpi(mode, 'city'))
    s = [];
    for i=-R:R
        for j = -(R-abs(i)):(R-abs(i))
            s = [s;[i j]];
        end
    end
end


        
    
    



