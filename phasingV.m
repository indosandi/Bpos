function phasingV
clear;
Amat=matf('aMKC2D20.mat');
% Ainv=matf('Ainv30.mat'); 
% Iqref=matf('Iql16chig.mat'); 
Ainv=pinv(Amat); 
lmax=16; 
vAllCell=guessO(lmax); 
% vAllCell=matf('vCell1UAO2D.mat'); 
% vAllref=matf('vAll1UAO4D.mat'); 
% vR=real(vAllref);
% vI=imag(vAllref); 
%tic
vAll=untoone(vAllCell,lmax); 
Rnew=1;
temp=fleastmin(Amat*vAll)
for in=1:2000
%R(vR,real(vAll))
%R(vI,imag(vAll))
%vAll=matf('vAll.mat'); 
% temp=Iqnegmin;
Iq=Amat*vAll; 
Iqnegmin=fleastmin(Iq);

%wrt(Iq)
%pause
Iqp=(Iq+conj(Iq))/2;  %set positive value
Iqp(Iqp<0)=Iqp(Iqp<0)*-1;  %flip negative value
vAllp=Ainv*Iqp; 
vAllpCell=onetoun(vAllp,lmax); %convert from 1-D array into unitary matrix
%--------
vAllCell=cellProc(vAllCell,vAllpCell); 
vAll=untoone(vAllCell,lmax); 
%Iq=Amat*vAll; 
% rFac=R(real(Iq),real(Iqref)); 
if(Iqnegmin>temp)
    fprintf('%e %e \n',temp,Iqnegmin);
%     fprintf('%e %e %f \n',temp,Iqnegmin,rFac);
    temp=Iqnegmin;
    save('vAllsolKC2D.mat','vAllCell'); 
% pause
end
% if ( rFac<Rnew)
%     Rnew=rFac
%     save('vAllsol.mat','vAllCell'); 
% end

%R(imag(Iq),imag(Iqref)) 
%wrt(Iq); 
end
%toc; 
end

function wrt(Iq)
Iqim=imag(Iq); 
Iqre=real(Iq);
Iqneg=Iqre(Iqre<0); 
fprintf('%d %e %e \n',size(Iqneg,1),sum(abs(Iqim)),sum(abs(Iqneg)))
end

function cellOut=cellProc(dCell,dCellP)
%for ii=1:6
    %size(dCellP{ii})
    %pause
%end
nsize=size(dCell,1); 
cellOut=cell(nsize,1); 
for ii=1:nsize
    %size(dCell{ii})
    %size(dCellP{ii})
    %pause
   omega=procpr(dCell{ii},dCellP{ii});  
   cellOut{ii}=dCell{ii}*omega; 
end
end

function out=fleastmin(f)
rf=real(f);
y=rf(rf<0);
out=sum(y);
end