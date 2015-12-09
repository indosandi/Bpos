function out=vCelltoIlm(gCell,vCell)
lmax=(size(vCell,1)-1)*2;
nq=size(gCell{1},1);
out=zeros(nq,lmax+1,2*lmax+1); 
ii=0;
symnumber=4;
for l=0:2:lmax
    ii=ii+1;
    ilm=gCell{ii}*vCell{ii};
    size(ilm)
    im=0;
    for m=-l:l
        
        if(mod(m,symnumber)==0)
            im=im+1;
            out(:,l+1,m+l+1)=ilm(:,im); 
        end
       
    end
%     out(:,l+1,1:2*l+1)=ilm(:,:);
%     pause
end

end