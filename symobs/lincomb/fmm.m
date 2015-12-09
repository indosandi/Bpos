function out=fmm(x)
%approach orthogonal
 y=x'*x;
 
%matrix diagonal 
diagonal=repmat(diag(y),[1 size(y,2)]).*eye(size(y,2));
len=size(y,2);
dy=diag(y);
std=1*ones(size(y,2),1);
std(round(len/2))=1;
exterr=sum((dy-std).^2);

%without diagonal
liny=y-diagonal;

%square element
sqry=liny.^2;

%sum over all element
out=sum(sum(sqry))+exterr;
end