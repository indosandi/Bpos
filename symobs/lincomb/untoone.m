function vAll=untoone(oCell,lmax)
vAll=[]; 
ii=0;
for l=0:2:lmax
    ii=ii+1;
    v=oCell{ii};
    vOne=reshape(v,[],1);
    vAll=[vAll;vOne];
end

end
