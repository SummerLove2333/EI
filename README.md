# EI
替学长做对比试验，用EI算法运行几个网络

![Optimization](https://github.com/SummerLove2333/EI/blob/master/img/aa.png)

EI复现的算法使用的：https://github.com/jhxu1/extra_cpp

以Cit-HepPh网络为例：设置
```
#define SIZE  34547     //节点数
#define K 24.36           //平均度
#define INI_NODES  2   //初始节点数
```

在vs里面运行EI算法，得到对应的EI_sort节点排序文件。

![排序结果](https://github.com/SummerLove2333/EI/blob/master/img/sort.png)

接着运行step3算法，并记录工作区的值，与论文中的进行比较。

得到number为14539，R值为0.3017；与论文中20次实验的平均number值14498.90还是比较接近的。

感觉这个EI算法是无误的~(#^.^#)
