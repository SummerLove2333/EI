A = as733;
N = size(A,1);
for i = 1:N
    ind = find(A(i,:) == 1);
    X = [i,ind];
    dlmwrite('input.txt',X,'-append','delimiter',' ','newline','pc','precision',7);
end