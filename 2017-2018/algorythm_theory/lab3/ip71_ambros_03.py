import sys
import math

ifs = 0
arr = []
allifs = [0] * 3
with open(sys.argv[1]) as f:
    arr = f.readlines()

arr = arr[1:]

for i in range(0, len(arr)):
    # print(arr[i])
    arr[i] = int(arr[i])


def QuickSort1(arr):
    global ifs
    global allifs
    ifs = 0

    def Partition(p, r):
        global ifs
        piv = r
        x = arr[piv]
        i = p - 1
        for j in range(p, r):
            ifs += 1
            if arr[j] <= x:
                i += 1
                arr[i], arr[j] = arr[j], arr[i]
            # draw(arr, j)
        arr[i + 1], arr[r] = arr[r], arr[i + 1]
        return i + 1

    def sort(p, r):
        if r <= p:
            return
        piv = Partition(p, r)
        sort(0, piv - 1)
        sort(piv + 1, r)

    sort(0, len(arr) - 1)
    # print(ifs)
    allifs[0] = ifs


def QuickSort2(arr):
    global ifs
    global allifs
    ifs = 0

    def mid(i1, i2, i3):
        if (arr[i1] <= arr[i2] and arr[i1] >= arr[i3]) or (arr[i1] >= arr[i2] and arr[i1] <= arr[i3]):
            return i1
        elif (arr[i2] <= arr[i1] and arr[i2] >= arr[i3]) or (arr[i2] >= arr[i1] and arr[i1] <= arr[i3]):
            return i2
        else:
            return i3

    def part(p, r):
        global ifs

        if p >= r:
            return
        pi = mid(p, int(math.floor((p + r) / 2)), r)
        arr[r], arr[pi] = arr[pi], arr[r]

        piv = arr[r]
        wall = p - 1
        for i in range(p, r):
            ifs += 1
            if arr[i] <= piv:
                wall += 1
                arr[wall], arr[i] = arr[i], arr[wall]
            # draw(arr, i)
        arr[wall + 1], arr[r] = arr[r], arr[wall + 1]
        return wall + 1

    def sort(p, r):
        global ifs
        if (p >= r):
            return
        if r - p < 2:
            if arr[p] < arr[r]:
                arr[p], arr[r] = arr[r], arr[p]
        if r - p < 3:
            ifs += 3
            if arr[p] > arr[p + 1]:
                arr[p], arr[p + 1] = arr[p + 1], arr[p]
            if arr[p + 1] > arr[r]:
                arr[p + 1], arr[r] = arr[r], arr[p + 1]
            if arr[p] > arr[p + 1]:
                arr[p], arr[p + 1] = arr[p + 1], arr[p]
        i = part(p, r)
        sort(p, i - 1)
        sort(i + 1, r)

    sort(0, len(arr) - 1)
    # print(ifs)
    allifs[1] = ifs


def QuickSort3(arr):
    global ifs
    global allifs
    ifs = 0

    # def mid(i1, i2, i3):
    #     if (arr[i1] <= arr[i2] and arr[i1] >= arr[i3]) or (arr[i1] >= arr[i2] and arr[i1] <= arr[i3]):
    #         return i1
    #     elif (arr[i2] <= arr[i1] and arr[i2] >= arr[i3]) or (arr[i2] >= arr[i1] and arr[i1] <= arr[i3]):
    #         return i2
    #     else:
    #         return i3

    def part(p, r):
        global ifs

        if p >= r:
            return
        #pi = mid(p, int(math.floor((p + r) / 2)), r)
        # arr[r], arr[pi] = arr[pi], arr[r]

        piv1 = arr[p]
        piv1 = arr[p + 1]
        piv1 = arr[r]
        wall = p - 1
        for i in range(p, r):
            ifs += 1
            if arr[i] <= piv1:
                wall += 1
                arr[wall], arr[i] = arr[i], arr[wall]
            # draw(arr, i)
        arr[wall + 1], arr[r] = arr[r], arr[wall + 1]
        return wall + 1

    def sort(p, r):
        global ifs
        if (p >= r):
            return
        if r - p < 2:
            if arr[p] < arr[r]:
                arr[p], arr[r] = arr[r], arr[p]
        if r - p < 3:
            ifs += 3
            if arr[p] > arr[p + 1]:
                arr[p], arr[p + 1] = arr[p + 1], arr[p]
            if arr[p + 1] > arr[r]:
                arr[p + 1], arr[r] = arr[r], arr[p + 1]
            if arr[p] > arr[p + 1]:
                arr[p], arr[p + 1] = arr[p + 1], arr[p]
        i = part(p, r)
        sort(p, i - 1)
        sort(i + 1, r)

    sort(0, len(arr) - 1)
    # print(ifs)
    allifs[2] = ifs



arr1 = arr[:]
QuickSort1(arr1)

arr2 = arr[:]
QuickSort2(arr2)

arr3 = arr[:]
QuickSort3(arr3)

out = open('output.txt', 'w+')

o = ''
for n in allifs:
    o += str(n) + ' '

out.write(o[:len(o) - 1])
out.close()
