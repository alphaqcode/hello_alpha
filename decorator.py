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


func(1,2)
func2(1,2,3)

