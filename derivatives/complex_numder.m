function [dudx,dudy,dvdx,dvdy] = complex_numder(func,z,dzdy)

delta = 1e-3;

u = @(z) real(func(z)) ;
v = @(z) imag(func(z)) ;

dudx = numder(u, z, dzdy, delta) ;
dudy = numder(u, z, dzdy, delta*1i) ;
dvdx = numder(v, z, dzdy*(-1i), delta) ;
dvdy = numder(v, z, dzdy*(-1i), delta*1i) ;
end


function dzdx = numder(g, x, dzdy, delta)
if nargin < 3
  delta = 1e-3 ;
end
dzdy = gather(dzdy) ;
y = gather(g(x)) ;
dzdx = zeros(size(x),'double') ;
for i=1:numel(x)
  x_ = x ;
  x_(i) = x_(i) + delta ;
  y_ = gather(g(x_)) ;
  factors = dzdy .* (y_ - y)/delta ;
  dzdx(i) = dzdx(i) + sum(factors(:)) ;
end
end
