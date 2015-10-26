clear;
Bexp=matf('blKC2D.mat');
nq=33;
Bq=Bexp(1:nq,1:nq,:); 

lmax=16; 

dq=1;
mCol=0;
for l=0:2:lmax
    mCol=mCol+(2*l+1)^2; 
end
disp(mCol)
pause


nthe=20;
nphi=20;
dthe=pi/nthe; 
dphi=2*pi/nphi; 

qr=0:dq:dq*(nq-1);
theta=linspace(0,pi-dthe,nthe);
phi=linspace(0,2*pi-dphi,nphi);

nind=0;
    for ithe=1:nthe;
        for iphi=1:nphi
            nind=nind+1;
            thetapoint(nind)=theta(ithe);
            phipoint(nind)=phi(iphi);
        end
    end

ylmsave=zeros(nind,mCol);
mind=0;
for l=0:2:lmax
    for m=-l:l
        mind=mind+1;
        larray(mind)=l;
        marray(mind)=m;
        ylmsave(:,mind)=compute_ylm(l,m,thetapoint,phipoint);
    end
end

%taking svd of B
gMcell=cell(1,lmax/2+1); 
n=0
for l=0:2:lmax
    n=n+1; 
    Bl=squeeze(Bq(:,:,l+1));
    [u s v]=svd(Bl);
    gMcell{n}=u*sqrt(s(:,1:2*l+1)); 
    size(gMcell{n})
end
save('gCellKC2D20.mat','gMcell')

nangle=nind; 
nqangle=0; 
for iq=1:nq
    fprintf('%d \n',iq)
    for iangle=1:nangle
    nqangle=nqangle+1; 
    nind=0; 
    for im=1:mind;
        l=larray(im);
        m=marray(im); 
        gM=gMcell{l/2+1}; 
    for ii=-l:l; 
        nind=nind+1; 
        aM(nqangle,nind)=gM(iq,ii+l+1)*ylmsave(iangle,im); 
    end
    end
end
end
save('aMKC2D20.mat','aM')
