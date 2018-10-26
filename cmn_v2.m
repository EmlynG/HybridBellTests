%p=zeros(delA,delB,mA,delTotB);


% program 19 of arxiv 1303.2849

% get some behaviour p to test.
%bev233;
matrices = {Expression1, Expression10, Expression100, Expression11, Expression12, Expression13, Expression14, Expression15, Expression16, Expression17, Expression18, Expression19, Expression2, Expression20, Expression21, Expression22, Expression23, Expression24, Expression25, Expression26, Expression27, Expression28, Expression29, Expression3, Expression30, Expression31, Expression32, Expression33, Expression34, Expression35, Expression36, Expression37, Expression38, Expression39, Expression4, Expression40, Expression41, Expression42, Expression43, Expression44, Expression45, Expression46, Expression47, Expression48, Expression49, Expression5, Expression50, Expression51, Expression52, Expression53, Expression54, Expression55, Expression56, Expression57, Expression58, Expression59, Expression6, Expression60, Expression61, Expression62, Expression63, Expression64, Expression65, Expression66, Expression67, Expression68, Expression69, Expression7, Expression70, Expression71, Expression72, Expression73, Expression74, Expression75, Expression76, Expression77, Expression78, Expression79, Expression8, Expression80, Expression81, Expression82, Expression83, Expression84, Expression85, Expression86, Expression87, Expression88, Expression89, Expression9, Expression90, Expression91, Expression92, Expression93, Expression94, Expression95, Expression96, Expression97, Expression98, Expression99}
for k=1:length(matrices)
p = matrix(:);

DeltaA=[2,2,2]; % number of outcomes for Alice
DeltaB=[2,2,2]; % number of outcomes for Bob


delTotA=sum(DeltaA);
delTotB=sum(DeltaB); % total number of possible outcomes


% form the deterministic behaviours
% prob of p(a,b|x y)
lambda_max = prod(DeltaA) * prod(DeltaB); % number of extremal deterministic behaviour
beh_size = delTotA * delTotB; % behaviour size
df = zeros(lambda_max, delTotA, delTotB); 

count=0;
for(i=0:prod(DeltaA)-1)
for(j=0:prod(DeltaB)-1)
    count=count+1;
    vA=de2delta(i,DeltaA);
    vB=de2delta(j,DeltaB);
    df(count,:,:)=vA'*vB;
end
end

dmat=reshape(df,lambda_max,beh_size);



fprintf(1,'Computing the optimal solution ...');
cvx_begin

  variable s(1,beh_size)
  -1 <= s*dmat' <=1; 
  maximize (s*p)
  
cvx_end
fprintf(1,'Done! \n');

% save('c32_local.txt','dmat','-ascii')

% fprintf(1,'Computing the optimal solution ...');
% cvx_begin

%   variable s(1,36)
%   variable s_l
%   s*dmat'-s_l <=0; 
%   s*p - s_l <=1;

%   maximize (s*p-s_l)
  
% cvx_end
% fprintf(1,'Done! \n');
