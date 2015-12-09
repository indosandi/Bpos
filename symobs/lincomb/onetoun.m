function dCell=onetoun(vAll,lmax)
dCell=cell(lmax/2+1); 
ii=0; 
for l=0:2:lmax
    ii=ii+1; 
    lmnum4=2*floor(l/4)+1;
    v=vAll(1:lmnum4*lmnum4); 
  
    vsym=reshape(v,lmnum4,lmnum4); 
    dCell{ii}=vsym; 
    
    vAll(1:(lmnum4)*(lmnum4))=[];
end

% %for low l, it is easily obtain
% dCell{1}=-1;
% dCell{2}=1;
end
