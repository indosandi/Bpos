function aq=ga(alm)
	
    %lico=[0 6 10 12 16 18 20 22 24 26 28  ]
    %    qmax=0.034;
    %alm=matf('rholm23.mat');
%     alm=matf('ilmb.mat');
    %alm(:,:,:)=alm2(1,:,:,:);
    lmax=size(alm,2)-1;
    lico=[0:2:16];
    Nq=18;
    %dq=headg('dqsph');
    dq=1/20;
	qgrid=0:dq:(Nq-1)*dq;
	
    N=18;
    %dq=headg('dq');
    dq=1/20;
    qqx=-N*dq:dq:N*dq;
	qqy=-N*dq:dq:N*dq;
	qqz=-N*dq:dq:N*dq;
    
    %make one indeks
    nind=0;
    for ii=1:length(qqx)
     for ij=1:length(qqy)
      for ik=1:length(qqz)
        nind=nind+1;
        qx(nind)=qqx(ii);
        qy(nind)=qqy(ij);
        qz(nind)=qqz(ik);
    end  
    end   
    end
    
    [phi,theta,qqr]=cart2sph(qx,qy,qz);
    
    %filling almgrid
    for il=1:length(lico)
        l=lico(il);
		for m=-l:l
		almgrid=alm(:,l+1,m+l+1);
		almp=interp1(qgrid,almgrid,qqr,'spline');
        almp2(l+1,m+l+1,:)=almp;
		end
    end
    
    %filling ylm
    for il=1:length(lico)
        l=lico(il)
		for m=-l:l
           ylmsave(l+1,m+l+1,:)=compute_ylm(l,m,pi/2.-theta,phi);
        end 
    end
    %save('eraseme.mat','ylmsave')
    %pause
    
    
    
    nind=0;
	for ii=1:length(qqx)
	for ij=1:length(qqy)
	for ik=1:length(qqz)
        nind=nind+1
        swap=almp2(:,:,nind).*ylmsave(:,:,nind);
        swap=reshape(swap,[],1);
	aq(ii,ij,ik)=sum(swap);
    
    end
    end
    end
    aq=real(aq);
    aq(isnan(aq))=0;
    
  

	
% 	save('rhoexp.mat','aq');
