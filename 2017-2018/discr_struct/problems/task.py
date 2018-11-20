# tasks 5, 11, 17, 23
from random import randint

# 5, 11


def makeTab(cnt):  # parser for readable tree printing
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
        if obj == None:
            return ''
        l = '' if obj.left == None else makeTab(
            tabs) + self.myRepr(obj.left, tabs + 1) + '\n'
        r = '' if obj.right == None else makeTab(
            tabs) + self.myRepr(obj.right, tabs + 1) + '\n'
        return ('(' + str(obj.value) + '\n' +
                str(l) +
                str(r) + makeTab(tabs - 1) + ')')

    def __repr__(self):
        # lf = self.left
        # rt = self.right
        l = self.myRepr(self.left, 2)
        r = self.myRepr(self.right, 2)
        return '(' + str(self.value) + '\n' + makeTab(1) + str(l) + '\n' + makeTab(1) + str(r) + '\n)'


class Tree:
    def __init__(self):
        self.root = TreeEl(None, None, None)

    def __repr__(self):
        return str(self.root)

    def push(self, number):
        def f(node):
            if number < node.value:
                if node.left == None:
                    node.left = TreeEl(number, None, None)
                else:
                    f(node.left)
            else:
                if node.right == None:
                    node.right = TreeEl(number, None, None)
                else:
                    f(node.right)
        if self.root.value == None:
            self.root.value = number
        else:
            f(self.root)

    def findRight(self, node):
        cur = node
        while cur.right != None:
            cur = cur.right
        return cur

    def count(self, number):
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

    def search(self, value):
        def s(node):
            if value == node.value:
                return node
            elif value < node.value:
                if node.left == None:
                    return None
                return s(node.left)
            else:
                if node.right == None:
                    return None
                return s(node.right)
        return s(self.root)

    def getParent(self, child):
        if child == None:
            return None

        def s(node):
            if (child == node.right) or (child == node.left):
                return node
            elif child.value < self.root:
                return s(node.left)
            else:
                return s(node.right)
        return s(self.root)

    def delete(self, node):
        par = self.getParent(node)
        side = ''
        if node == par.right:
            side = 'right'
        else:
            side = 'left'

        if (node.left == None) and (node.right == None):
            setattr(par, side, None)

        elif node.left == None:
            setattr(par, side, node.right)

        elif node.right == None:
            setattr(par, side, node.left)

        else:
            term = self.findRight(node.left)
            par = self.getParent(node)
            ch_l = node.left
            ch_r = node.right
            setattr(par, side, term)
            term.left = ch_l
            term.right = ch_r


# 17
def QuickSort(arr):
    def sort(p, r):
        lt = p
        rt = r
        piv = arr[p]
        while lt <= rt:
            while arr[lt] < piv:
                lt += 1
            while arr[rt] > piv:
                rt -= 1
            if lt <= rt:
                arr[lt], arr[rt] = arr[rt], arr[lt]
                lt += 1
                rt -= 1
        if p < rt:
            sort(p, rt)
        if lt < r:
            sort(lt, r)
    sort(0, len(arr) - 1)


def ShellSort(arr):
    N = len(arr)
    d = N / 2
    while d >= 1:
        for i in range(d, N):
            j = i
            while (j >= d) and (arr[j - d] > arr[j]):
                arr[j], arr[j - d] = arr[j - d], arr[j]
                j -= d
        d /= 2


def create(length):
    res = []
    for i in range(0, length):
        res.append(i)
    for i in range(0, length * length):
        i = randint(0, length - 1)
        j = randint(0, length - 1)
        res[i], res[j] = res[j], res[i]
    return res


def validate(arr):
    for i in range(0, len(arr) - 2):
        if arr[i] > arr[i + 1]:
            print('Not valid sorted')
            return
    print('Sort validated!')
    return True

# 23


class HashTable:
    class bwTree:

        class bwTreeEl:  # False represents black; True - red

            def __init__(self, data, color, left, right):
                self.value = data
                self.color = color
                self.left = left
                self.right = right

            def myRepr(self, obj, tabs):
                if obj == None:
                    return ''
                l = '' if obj.left == None else makeTab(
                    tabs) + self.myRepr(obj.left, tabs + 1) + '\n'
                r = '' if obj.right == None else makeTab(
                    tabs) + self.myRepr(obj.right, tabs + 1) + '\n'
                return ('(' + str(obj.value) + '\n' +
                        str(l) +
                        str(r) + makeTab(tabs - 1) + ')')

            def __repr__(self):
                # lf = self.left
                # rt = self.right
                l = self.myRepr(self.left, 2)
                r = self.myRepr(self.right, 2)
                return '(' + str(self.value) + ' [' + str(self.color) + ']' + '\n' + makeTab(1) + str(l) + '\n' + makeTab(1) + str(r) + '\n)'

        def __init__(self):
            self.root = self.bwTreeEl(None, False, None, None)

        def __repr__(self):
            return str(self.root)

        def push(self, number):
            def f(node):
                if number < node.value:
                    if node.left == None:
                        node.left = self.bwTreeEl(
                            number, not node.color, None, None)
                    else:
                        f(node.left)
                else:
                    if node.right == None:
                        node.right = self.bwTreeEl(
                            number, not node.color, None, None)
                    else:
                        f(node.right)
            if self.root.value == None:
                self.root.value = number
            else:
                f(self.root)

        def search(self, value):
            def s(node):
                if value == node.value:
                    return node
                elif value < node.value:
                    if node.left == None:
                        return None
                    return s(node.left)
                else:
                    if node.right == None:
                        return None
                    return s(node.right)
            return s(self.root)

    def __init__(self, **a):
        if 'length' in a:
            self.length = a['length']
            self.arr = [None] * self.length
        else:
            self.arr = []

    def __repr__(self):
        return str(self.arr)

    def hash(self, str):
        C = 255
        h = 0
        if self.length != None:
            for i in range(0, len(str)):
                h = (h * C + ord(str[i])) % self.length
        return h

    def push(self, data):
        data = str(data)
        index = self.hash(data)
        if self.arr[index] == None:
            self.arr[index] = self.bwTree()
        self.arr[index].push(data)

    def search(self, data):
        ind = self.hash(data)
        return self.arr[ind].search(data)



# Tests
T = Tree()
for i in range(0, 16):
    T.push(randint(-16, 16))
print(T)
print('input search number: ')
print(T.findRight)
print(T.search(input()))


print('\n\n')

testarr = create(500)
ShellSort(testarr)
validate(testarr)

print('\n\n')

H = HashTable(length=5)
H.push('lol')
H.push('kek')
H.push('4ek')
H.push('123')
print(H)
print(H.search('kek'))
