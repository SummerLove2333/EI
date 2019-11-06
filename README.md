# EI
替学长做对比试验，用EI算法运行几个网络

![Optimization](https://github.com/SummerLove2333/EI/blob/master/img/aa.png)

EI复现的算法使用的：https://github.com/jhxu1/extra_cpp

以Cit-HepPh网络为例：设置
```
#define SIZE  34547     //节点数
#define K 12.18           //平均度
#define INI_NODES  3   //初始节点数
```

在vs里面运行EI算法，得到对应的EI_sort节点排序文件。

然后在matlab中，运行step1_adj_list.m，将网络转化成邻接表的格式。

接着运行没有回插的CI算法，并记录工作区的值，与论文中的进行比较。
