function [ylm] = compute_ylm(l,m,theta,phi)
% evaluate spherical harmonics function of degree
% l and order m=0,1,2....l for given theta and phi

% checks
if( l<0 || abs(m)>l || fix(m) ~=m || fix(l) ~=l || isempty(theta) || isempty(phi) )
  ylm = zeros(size(theta));
  return;
end

% compute legendre polynomial
tmp = legendre(l,cos(reshape(theta,1,[])));

absm = abs(m);
if (m>=0)
  ylm = reshape(tmp(m+1,:),size(theta)).*exp(1i*m*phi);
else
  ylm = ((-1)^absm)*reshape(tmp(absm+1,:),size(theta)).*exp(1i*m*phi);
  ylm = ylm*factorial(l-absm)/factorial(l+absm);
end

ylm = sqrt((2*l+1)*factorial(l-m)/(4.0*pi*factorial(l+m)))*ylm;
