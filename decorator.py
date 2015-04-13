def deco(ex):
    def _deco(*args,**haha):
        print('func called before')
        p = ex(*args,**haha)
        print('func called after,result%s' %(p))
        return p
    return _deco

@deco
def func(a,b):
    print('func calling')
    return a+b

@deco
def func2(a,b,c):
    print('func2 calling')
    return a+b+c


@deco
def func3(x,y):
    print('func3 is calling')
    return x + y



func(1,2)
func2(1,2,3)
func2(2,3,4)
func3(6,7)


