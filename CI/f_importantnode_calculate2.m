function [rcost,rcostqueue] = f_importantnode_calculate2( p_A,p_nodequeue )
%����R p_nodequeue Ϊ��ӽڵ��˳��  """��������㷨"""

%%

networkA=p_A(p_nodequeue,p_nodequeue);
% cy_k=sum(networkA);
networkA2=triu(networkA,1);
all_sy=find(networkA2);%����������
cy_k2=sum(networkA2);%ʹ�õĶȣ�ÿ��ֻҪ֮ǰ��û�о���
c_kxd=find(cy_k2>0);%���е�����
n_kxd=c_kxd(1)-1;%���е�����
n1=size(networkA,1);
[sub_a,~]=ind2sub(size(networkA2),all_sy);
% c_edge(:,2)=sub_a;
sub_a=sub_a';
v_bhofzs=1:n1;%ÿ���ڵ����ڵĶ�
endloc=cumsum(cy_k2);%ÿ���ѽ�����λ��
sizeof_d=ones(1,n1);%�Ѵ�С
dqmaxd=1;%��ǰ���ѵĴ�С
rcostqueue=ones(1,n1);
jlsy=zeros(1,n1);
for k1=n_kxd+1:n1
%     tic
    c_lj=sub_a(endloc(k1)-cy_k2(k1)+1:endloc(k1));
    if isempty(c_lj)
        %%
        %���Ϊ�գ���
        rcostqueue(k1)=dqmaxd;
        continue;
    end
    if length(c_lj)==1
        %%
        %Ѱ�ҸĶ���С�ı��
        v_lsk=c_lj;
        while v_bhofzs(v_lsk)~=v_lsk
            v_lsk=v_bhofzs(v_lsk);
        end
        v_bhofzs(c_lj)=v_lsk;%����������������
        v_bhofzs(k1)=v_lsk;%�ı�k1������
        sizeof_d(v_lsk)=sizeof_d(v_lsk)+1;%�ı�Ѵ�С
        if sizeof_d(v_lsk)>dqmaxd
            dqmaxd=sizeof_d(v_lsk);%��¼���Ѵ�С
        end
    else
        v_lsk=c_lj(1);
        jlsy(v_lsk)=k1;
        while v_bhofzs(v_lsk)~=v_lsk
            v_lsk=v_bhofzs(v_lsk);
            jlsy(v_lsk)=k1;
        end
        n_cddx=sizeof_d(v_lsk)+1;%�˶Ѵ�С
        v_bhofzs(c_lj(1))=v_lsk;%����������������
        v_bhofzs(k1)=v_lsk;%�ı�k1������
        for k2=c_lj(2:end)
            v_lsk2=k2;
            if jlsy(v_lsk2)==k1
                continue;
            end
            while v_bhofzs(v_lsk2)~=v_lsk2
                jlsy(v_lsk2)=k1;
                ls_lsk2=v_lsk2;
                v_lsk2=v_bhofzs(v_lsk2);
                v_bhofzs(ls_lsk2)=v_lsk;%��������·���Ľڵ�������ȫ�����³���С��ŵĶ�
                if jlsy(v_lsk2)==k1
                    break;
                end
            end
            v_bhofzs(k2)=v_lsk;
            if jlsy(v_lsk2)~=k1
                jlsy(v_lsk2)=k1;
                n_cddx=n_cddx+sizeof_d(v_lsk2);
            end
            v_bhofzs(v_lsk2)=v_lsk;%���յ�ĵ�������Ҳ���³���С��ŵĶ�
        end
        sizeof_d(v_lsk)=n_cddx;
        if n_cddx>dqmaxd
            dqmaxd=n_cddx;%��¼���Ѵ�С
        end
    end
    rcostqueue(k1)=dqmaxd;
%     toc
%     k1
end
rcost=sum(rcostqueue(1:end-1))/(n1*n1);

end

