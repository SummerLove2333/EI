A = as733;
N = size(A,1);
CI = load('output.csv')';
CI = CI+1;
for i = 1:N
    K(i) = i;
end

D = setdiff(K, CI);

rnodequeue_ci =[CI D];

[number, ~] = f_cns_number(A,rnodequeue_ci(N:-1:1));
[R,rcostqueue_ci] = f_importantnode_calculate2( A,rnodequeue_ci(N:-1:1));