function out=resp(l,m,theta,phi)
if(m<0)
    out=sqrt(2)*(-1)^m*imag(compute_ylm(l,abs(m),theta,phi));
elseif(m>0)
    out=sqrt(2)*(-1)^m*real(compute_ylm(l,m,theta,phi));
else
    out=compute_ylm(l,0,theta,phi);
end
        
end
