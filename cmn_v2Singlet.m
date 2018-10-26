%p=zeros(delA,delB,mA,delTotB);


% program 19 of arxiv 1303.2849

% get some behaviour p to test.
%bev233;
solvals=zeros(100,1);
svals=zeros(100,36);
for k=1:100
%for k=1:1
    statename = ['Expression'+string(k)]
    curstate=eval(statename);
    p = curstate(:);

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
    solvals(k)=cvx_optval;
    svals(k,:)=s;
%    solnvals = [solnvals, s*p]
 %   svals = [svals, s]
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
end

max(solvals)
