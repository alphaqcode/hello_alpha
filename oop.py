##oop

class Student(object):
    def __init__(self,name,score):
        self.name = name
        self.score = score

    def print_score(self):
        print '%s:%s' %(self.name,self.score)


sean = Student('sean du',99)
sean.print_score()

