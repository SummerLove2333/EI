function [rcost,rcostqueue] = f_importantnode_calculate2( p_A,p_nodequeue )
%计算R p_nodequeue 为添加节点的顺序  """逆序添加算法"""

%%

networkA=p_A(p_nodequeue,p_nodequeue);
% cy_k=sum(networkA);
networkA2=triu(networkA,1);
all_sy=find(networkA2);%上三角索引
cy_k2=sum(networkA2);%使用的度，每次只要之前的没有就行
c_kxd=find(cy_k2>0);%空闲到集合
n_kxd=c_kxd(1)-1;%空闲到多少
n1=size(networkA,1);
[sub_a,~]=ind2sub(size(networkA2),all_sy);
% c_edge(:,2)=sub_a;
sub_a=sub_a';
v_bhofzs=1:n1;%每个节点属于的堆
endloc=cumsum(cy_k2);%每个堆结束的位置
sizeof_d=ones(1,n1);%堆大小
dqmaxd=1;%当前最大堆的大小
rcostqueue=ones(1,n1);
jlsy=zeros(1,n1);
for k1=n_kxd+1:n1
%     tic
    c_lj=sub_a(endloc(k1)-cy_k2(k1)+1:endloc(k1));
    if isempty(c_lj)
        %%
        %如果为空，则
        rcostqueue(k1)=dqmaxd;
        continue;
    end
    if length(c_lj)==1
        %%
        %寻找改堆最小的编号
        v_lsk=c_lj;
        while v_bhofzs(v_lsk)~=v_lsk
            v_lsk=v_bhofzs(v_lsk);
        end
        v_bhofzs(c_lj)=v_lsk;%更新所连点所属堆
        v_bhofzs(k1)=v_lsk;%改变k1所属堆
        sizeof_d(v_lsk)=sizeof_d(v_lsk)+1;%改变堆大小
        if sizeof_d(v_lsk)>dqmaxd
            dqmaxd=sizeof_d(v_lsk);%记录最大堆大小
        end
    else
        v_lsk=c_lj(1);
        jlsy(v_lsk)=k1;
        while v_bhofzs(v_lsk)~=v_lsk
            v_lsk=v_bhofzs(v_lsk);
            jlsy(v_lsk)=k1;
        end
        n_cddx=sizeof_d(v_lsk)+1;%此堆大小
        v_bhofzs(c_lj(1))=v_lsk;%更新所连点所属堆
        v_bhofzs(k1)=v_lsk;%改变k1所属堆
        for k2=c_lj(2:end)
            v_lsk2=k2;
            if jlsy(v_lsk2)==k1
                continue;
            end
            while v_bhofzs(v_lsk2)~=v_lsk2
                jlsy(v_lsk2)=k1;
                ls_lsk2=v_lsk2;
                v_lsk2=v_bhofzs(v_lsk2);
                v_bhofzs(ls_lsk2)=v_lsk;%把其他堆路过的节点所属堆全部更新成最小编号的堆
                if jlsy(v_lsk2)==k1
                    break;
                end
            end
            v_bhofzs(k2)=v_lsk;
            if jlsy(v_lsk2)~=k1
                jlsy(v_lsk2)=k1;
                n_cddx=n_cddx+sizeof_d(v_lsk2);
            end
            v_bhofzs(v_lsk2)=v_lsk;%将终点的点所属堆也更新成最小编号的堆
        end
        sizeof_d(v_lsk)=n_cddx;
        if n_cddx>dqmaxd
            dqmaxd=n_cddx;%记录最大堆大小
        end
    end
    rcostqueue(k1)=dqmaxd;
%     toc
%     k1
end
rcost=sum(rcostqueue(1:end-1))/(n1*n1);

end

