##Python的os模块封装了操作系统的目录和文件操作，要注意这些函数有的在os模块中，有的在os.path模块中。
##
##练习：编写一个search(s)的函数，能在当前目录以及当前目录的所有子目录下查找文件名包含指定字符串的文件，并打印出完整路径：
##
##$ python search.py test
##unit_test.log
##py/test.py
##py/test_os.py
##my/logs/unit-test-result.txt

import os

def search(p,s):
    f = [x for x in os.listdir(p) if os.path.isfile(os.path.join(os.path.abspath(p),x)) and s in x]
    fn = map(lambda x:os.path.join(os.path.abspath(p),x),f)    
    
    d = [x for x in os.listdir(p) if os.path.isdir(x)]
    dn = map(lambda x:os.path.join(os.path.abspath(p),x),d)
    
    for node in dn:
        fn = fn + find(node,s)

    return fn


result = find('.','fun')
    
print result


    
