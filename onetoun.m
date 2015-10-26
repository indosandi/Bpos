function dCell=onetoun(vAll,lmax); 
dCell=cell(lmax/2+1); 
ii=0; 
for l=0:2:lmax
    ii=ii+1; 
    v=vAll(1:(2*l+1)*(2*l+1)); 
    %v=impsymconj(v); 
    %apply symmetry
    vsym=impsymconj(reshape(v,2*l+1,2*l+1));
    dCell{ii}=vsym; 
    %dCell{ii}=reshape(v,2*l+1,2*l+1); 
    %size(dCell{ii})
    %disp(dCell{ii})
    %pause
    vAll(1:(2*l+1)*(2*l+1))=[];
end
end
