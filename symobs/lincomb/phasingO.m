clear;
Bexp=matf('bKCreal.mat');
nq=19;
Bq=Bexp(1:nq,1:nq,:); 

lmax=16; 

dq=1;
mCol=0;
for l=0:2:lmax
    mCol=mCol+(2*l+1)^2; 
end
disp(mCol)
pause


nthe=10;
nphi=10;
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
symnumber=4;
for l=0:2:lmax
    for m=-l:l
        if(mod(m,symnumber)==0)
          mind=mind+1;
            larray(mind)=l;
            marray(mind)=m;
            ylmsave(:,mind)=resp(l,m,thetapoint,phipoint);
        end
        %ylmsave(:,mind)=compute_ylm(l,m,thetapoint,phipoint);
    end
end

%taking svd of B
gMcell=cell(1,lmax/2+1); 
n=0
for l=0:2:lmax
    n=n+1; 
    Bl=squeeze(Bq(:,:,l+1));
    [u s v]=svd(Bl);
    lmnum4=2*floor(l/4)+1;
    if (lmnum4<nq)
        gMcell{n}=u*sqrt(s(:,1:lmnum4)); 
    elseif(lmnum4>nq)
        zeroMatrix=zeros(nq,lmnum4-nq); 
        %fprintf('%d %d \n',nq,2*l+1); 
        %size(zeroMatrix)
        tempGmatrix=u*sqrt(s(:,1:nq)); 
        gMcell{n}=[tempGmatrix zeroMatrix];
        %size(gMcell{n})
        %pause; 
    end
end
save('greal.mat','gMcell')
% pause
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
        lmnum4=2*floor(l/4)+1;
        l4=floor(lmnum4/2);
        img=0;
    for ii=-symnumber*l4:symnumber:symnumber*l4; 
        img=img+1;
        nind=nind+1; 
        aM(nqangle,nind)=gM(iq,img)*ylmsave(iangle,im); 
%         fprintf('%d %d \n',m,ii)
%         pause
    end
    end
end
end
save('aMreal.mat','aM')
% aMinv=pinv(aM);
% save('aMrealinv.mat','aMinv');
