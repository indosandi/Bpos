function minft()

% matrix C
aM=matf('aMreal.mat');
aM=aM*(-1); % set matrix negative since requirement is greater than

b=zeros(size(aM,1),1);  % set vector zero

vAll0=2*(rand(size(aM,2),1)-0.5); %set random initial guess

%set guess for first 2 coeficient since only different by sign
vAll(1)=-1;
vAll(2)=1;


lmax=16;
size(b)
size(vAll0)

%set upper and lower bound
lb=-1*ones(size(aM,1),1);
ub=1*ones(size(aM,1),1);

% just the way to call function
options = optimset(@fmincon)
field1 = 'objective';  value1 = @fmin;
field2 = 'x0';  value2 = vAll0;
field3 = 'Aineq';  value3 = aM;
field4 = 'bineq';  value4 = b;
field5 = 'lb';  value5 = lb;
field6 = 'ub';  value6 = ub;
field7 = 'solver';  value7 = 'fmincon';
field8 = 'options';  value8 = options;
s = struct(field1,value1,field2,value2,field3,value3,field4,value4,...
    field5,value5,field6,value6,field7,value7,field8,value8)

% start running active set algorithma
tic
vAll = fmincon(s)
toc


save('temp.mat','vAll');
end