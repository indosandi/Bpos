function omega=procpr(A,B)
M=A'*B; 
[u s v]=svd(M);
omega=u* v'; 
end
