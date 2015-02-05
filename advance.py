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


#生成器
