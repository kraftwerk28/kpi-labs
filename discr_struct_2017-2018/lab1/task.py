# List element representation
class El_one:
    def __init__(self, data, chi):
        self.data = data
        self.child = chi

    def __repr__(self):
        return '{ data: ' + str(self.data) + '; child: ' + str(self.child) + ' }'


class El_duo:
    def __init__(self, data, par, chi):
        self.data = data
        self.parent = par
        self.child = chi

    def myRepr(self, obj, d):
        if type(obj) == type(None):
            return 'None'
        if d > 0:
            p = None if obj.parent == None else self.myRepr(obj.parent, d - 1)
            c = None if obj.child == None else self.myRepr(obj.child, d - 1)
            return ('{ data: ' + str(obj.data) +
                    '; parent: ' + str(p) +
                    '; child: ' + str(c) + ' }')

    def __repr__(self):
        p = None if self.parent == None else self.parent
        c = None if self.child == None else self.child
        return '{ data: ' + str(self.data) + '; parent: ' + self.myRepr(p, 4) + '; child: ' + self.myRepr(c, 4) + ' }'


# List representation
class LinkedListOne:
    def __init__(self):
        self.first = El_one(None, None)
        self.current = self.first
        self.length = 0

    def Push(self, *data):
        for d in data:
            self.PushOne(d)

    def PushOne(self, data):
        if self.first.data != None:
            next = El_one(data, None)
            self.current.child = next
            self.current = next
        else:
            self.first.data = data
        self.length += 1

    def Pop(self):
        pre = self.first
        i = self.length - 2
        while i > 0:
            pre = pre.child
            i -= 1
        res = pre.child
        pre.child = None
        return res

    def GetAll(self):
        return self.first

    def Get(self, index):
        if index < 0:
            return El_one(None, self.first)
        res = self.first
        while index > 0:
            if res.child == None:
                print('Index is out of bounds')
                return None
            res = res.child
            index -= 1

        return res

    def Move(self, _from, _n):
        self.MoveTo(_from, _from + _n)

    def MoveTo(self, _from, _to):
        if _from < 0 or _from >= self.length or _to < 0 or _to >= self.length:
            print('Index is out of bounds')
            return
        else:
            pre = self.Get(_from - 1)
            temp = pre.child
            if _from == 0:
                self.first = temp.child
            pre.child = temp.child
            _pre = self.Get(_to - 1)
            temp.child = _pre.child
            _pre.child = temp


class LinkedListDuo:
    def __init__(self):
        self.first = El_duo(None, None, None)
        self.current = self.first
        self.length = 0

    def Push(self, *data):
        # print(data)
        for d in data:
            self.PushOne(d)

    def PushOne(self, data):
        if self.first.data != None:
            next = El_duo(data, self.current, None)
            self.current.child = next
            self.current = next
        else:
            self.first.data = data
        self.length += 1

    def Pop(self):
        pre = self.first
        i = self.length - 2
        while i > 0:
            pre = pre.child
            i -= 1
        res = pre.child
        pre.child = None
        return res

    def GetAll(self):
        return self.first

    def Get(self, index):
        if index < 0:
            return El_one(None, self.first)
        res = self.first
        while index > 0:
            if res.child == None:
                print('Index is out of bounds')
                return None
            res = res.child
            index -= 1

        return res

    def Move(self, _from, _n):
        self.MoveTo(_from, _from + _n)

    def MoveTo(self, _from, _to):
        if _from < 0 or _from >= self.length or _to < 0 or _to >= self.length:
            print('Index is out of bounds')
            return
        else:
            pre = self.Get(_from - 1)
            temp = pre.child
            if _from == 0:
                self.first = temp.child
            pre.child = temp.child
            _pre = self.Get(_to - 1)
            temp.child = _pre.child
            _pre.child = temp


# One test
ll = LinkedListOne()

ll.Push(0, 1, 2, 3, 4)

print(ll.GetAll())  # 0 1 2 3 4

ll.Push(5)
print(ll.GetAll())  # 0 1 2 3 4 5

ll.Move(3, 2)
print(ll.GetAll())  # 0 1 2 4 5 3

ll.Move(0, 5)
print(ll.GetAll())  # 1 2 4 5 3 0

ll.Move(-1, 4)  # index error

ll.MoveTo(4, 0)  # index error

print('\n\n')

# Duo test
lll = LinkedListDuo()

lll.Push(1, 2, 3, 4)
print(lll.GetAll())

lll.Move(0, 3)

print(lll.GetAll())
