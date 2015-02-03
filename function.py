#normal function
def my_abs(x):
    if not isinstance(x,(int,float)):
        raise TypeError('bad operand type')
    if x >= 0:
        return x
    else:
        return -x

#default value
def power(x,n=2):
    s = 1
    while n > 0:
        n = n -1
        s = s * x
    return s


#default notice master
def add_end(L=None):
    if L is None:
        L = []
    L.append('END')
    return L
