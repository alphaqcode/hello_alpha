#高级特性

#切片
l = ['sean','tony','dustin','luolu']
l[0:3]


l = range(100)

l[0:10]

l[-10:]

l[:10:3]




#迭代
d = {'a':'sean','b':'dustin','c':'luolu'}
for key in d:
    print key

for key in d.itervalues():
    print key

for key in d.iteritems():
    print key

for ch in 'sean':
    print ch

from collections import Iterable
isinstance('sean',Iterable)
isinstance([1,2,3],Iterable)
isinstance(123,Iterable)

for i,value in enumerate(['sean','dustin','luolu']):
    print i,value





#列表生成式
t = range(100)
t = range(1,11)

[x * x for x in range(1,11)]

[x * x for x in range(1,11) if x % 2 == 0]

[m + n for m in 'sean' for n in 'dustin']

import os
[d for d in os.listdir('.')]
[d for d in os.listdir('D:\DATA')]

L = ['SEAN','DUSTIN']
[s.lower() for s in L]





#生成器
def fib(max):
    n, a, b = 0, 0, 1
    while n < max:
        yield b
        a, b = b, a + b
        n = n + 1


fib(10)



