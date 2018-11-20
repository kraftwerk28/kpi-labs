def makeTab(cnt):
    res = ''
    while cnt > 0:
        res += '  '
        cnt -= 1
    return res


class TreeEl:
    def __init__(self, data, right, left):
        self.value = data
        self.right = right
        self.left = left

    def myRepr(self, obj, tabs):
        # if obj.value == None:
        #     return makeTab(tabs) + 'None'
        l = None if obj.left == None else self.myRepr(obj.left, tabs + 1)
        r = None if obj.right == None else self.myRepr(obj.right, tabs + 1)
        return ('(' + str(obj.value) + '\n' +
                makeTab(tabs) + str(l) + '\n' +
                makeTab(tabs) + str(r) + '\n' + makeTab(tabs - 1) + ')')

    def __repr__(self):
        # lf = self.left
        # rt = self.right
        l = self.myRepr(self.left, 2)
        r = self.myRepr(self.right, 2)
        return '(' + str(self.value) + '\n' + makeTab(1) + str(l) + '\n' + makeTab(1) + str(r) + '\n)'


class Tree:
    def __init__(self, root):
        self.root = TreeEl(root, None, None)

    def Push(self, number):
        def f(n, cur):
            if n >= cur.value:
                if cur.right != None:
                    f(n, cur.right)
                else:
                    cur.right = TreeEl(n, None, None)
            else:
                if cur.left != None:
                    f(n, cur.left)
                cur.left = TreeEl(n, None, None)
        f(number, self.root)

    def Print(self):
        print(self.root)

    def findLeft(self):
        cur = self.root
        while cur.left != None:
            cur = cur.left
        return cur.value

    def Count(self, number):
        self.res = 0

        def c(node):
            if node.value == number:
                self.res += 1
            if node.left != None:
                c(node.left)
            if node.right != None:
                c(node.right)
        c(self.root)
        return self.res


T = Tree(-1)
T.Push(0)
T.Push(1)
T.Push(4)
T.Push(-22)
T.Push(3)
T.Push(4)
T.Push(4)
T.Print()
print(T.Count(T.findLeft()))