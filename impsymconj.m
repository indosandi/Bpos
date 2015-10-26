function out=impsymconj(v)
sizeV=size(v,1) ; 
if (sizeV==1)
    out=sign(v); 
    return
end
lmax=(sizeV-1)/2 ; 
out=zeros(size(v));
for ii=1:lmax+1; 
    %disp(ii)
    m=-lmax+ii-1; 
    out(:,ii)=(v(:,ii)+v(:,sizeV-ii+1))/2; 
    out(:,sizeV-ii+1)= (-1)^(m) *conj(out(:,ii)); 
    %out(:,sizeV-ii+1)=out(:,ii); 
end

