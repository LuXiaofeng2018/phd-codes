% wrapped cauchy distribution
function [THETA] = WrappedCauchy(theta, kai, mu)
    upper = 1 - kai.^2;
    lower = 1 + kai.^2 - 2.*kai.*cos(theta - mu);
    THETA = upper./lower./2/pi;
end