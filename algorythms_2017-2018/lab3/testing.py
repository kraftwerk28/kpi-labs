import time
import random
import math
from Tkinter import *

root = Tk()
canvas = Canvas(root, width=1000, height=500)
canvas.pack()
root.update()


ifs = 0


def draw(arr, mark):
    canvas.delete(ALL)
    for i in range(0, len(arr)):
        canvas.create_line(i * 2, 500, i * 2, 500 - arr[i])
        # canvas.create_rectangle(i * 2 - 1, 500 - arr[i] - 1, i * 2 + 1, 500 - arr[i] + 1, fill='black')
    canvas.create_rectangle(mark * 2, 500, mark * 2 + 2,
                            500 - arr[mark], fill='red')
    root.update()
    # time.sleep(0.005)


def create(length):
    res = []
    # while (length > 0):
    #     res.append(random.randint(0, length))
    #     length -= 1

    for i in range(0, length):
        res.append(i)
    for i in range(0, length * length):
        i = random.randint(0, length - 1)
        j = random.randint(0, length - 1)
        res[i], res[j] = res[j], res[i]
        # if i % 500 == 0:
        #     draw(res, 0)
    return res


def validate(arr, doDraw):
    for i in range(0, len(arr) - 2):
        if arr[i] > arr[i + 1]:
            print('Not valid sorted')
            return
        if doDraw:
            canvas.create_rectangle(i * 2, 500, i * 2 + 2,
                                    500 - arr[i], fill='lime')
            root.update()
    print('Sort validated!')
    return True


def QuickSort(arr):
    # global ifs
    # ifs = 0

    def sort(start, end):
        # global ifs
        if (start >= end):
            return
        pi = end
        piv = arr[pi]
        wall = start
        for i in range(start, end):
            # ifs += 1
            if arr[i] <= piv:
                arr[wall], arr[i] = arr[i], arr[wall]
                wall += 1
        arr[wall], arr[pi] = arr[pi], arr[wall]
        sort(start, wall - 1)
        sort(wall + 1, end)
    sort(0, len(arr) - 1)
    # print(ifs)


def QuickSortGUI(arr):
    def sort(start, end):
        if (start >= end):
            return
        pi = end
        piv = arr[pi]
        wall = start
        for i in range(start, end):
            if arr[i] <= piv:
                arr[wall], arr[i] = arr[i], arr[wall]
                wall += 1
            draw(arr, i)
        arr[wall], arr[pi] = arr[pi], arr[wall]
        sort(start, wall - 1)
        sort(wall + 1, end)
    sort(0, len(arr) - 1)

# Lab sorts


def QuickSort1(arr):
    global ifs
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
    print(ifs)


def QuickSort2(arr):
    global ifs
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
    print(ifs)


# def QuickSort3(arr):

    

def QuickSortHoare(arr):
    def sort(p, r):
        lt = p
        rt = r
        piv = arr[r]
        while lt <= rt:
            while arr[lt] < piv:
                lt += 1
            while arr[rt] > piv:
                rt -= 1
            if lt <= rt:
                arr[lt], arr[rt] = arr[rt], arr[lt]
                lt += 1
                rt -= 1
            draw(arr, 0)
        if p < rt:
            sort(p, rt)
        if lt < r:
            sort(lt, r)
    sort(0, len(arr) - 1)


def MergeSort(arr):
    b = [0] * len(arr)

    def merge(p, c, r):
        li = p
        ri = c + 1
        for i in range(p, r + 1):
            if ri > r or (li <= c and arr[li] <= arr[ri]):
                b[i] = arr[li]
                li += 1
            else:
                b[i] = arr[ri]
                ri += 1

        for k in range(p, r + 1):
            arr[k] = b[k]\


    def sort(p, r):
        if r - p < 1:
            return
        c = int(math.floor((p + r) / 2))
        if r - p > 1:
            sort(p, c)
            sort(c + 1, r)
        merge(p, c, r)
    sort(0, len(arr) - 1)


def MergeSortGUI(arr):
    b = [0] * len(arr)

    def merge(p, c, r):
        li = p
        ri = c + 1
        for i in range(p, r + 1):
            if ri > r or (li <= c and arr[li] <= arr[ri]):
                b[i] = arr[li]
                li += 1
            else:
                b[i] = arr[ri]
                ri += 1

        for k in range(p, r + 1):
            arr[k] = b[k]
            draw(arr, k)

    def sort(p, r):
        if r - p < 1:
            return
        c = int(math.floor((p + r) / 2))
        if r - p > 1:
            sort(p, c)
            sort(c + 1, r)
        merge(p, c, r)
    sort(0, len(arr) - 1)


def InsertionSortGUI(arr):
    i = 1
    while i < len(arr):
        j = i
        while j > 0 and arr[j - 1] > arr[j]:
            arr[j - 1], arr[j] = arr[j], arr[j - 1]
            j -= 1
        draw(arr, j)
        i += 1


def SelectionSort(arr):
    ind = 0
    while ind < len(arr) - 1:
        draw(arr, ind)
        smallI = ind
        for i in range(ind, len(arr)):
            if arr[i] < arr[smallI]:
                smallI = i
        arr[ind], arr[smallI] = arr[smallI], arr[ind]
        ind += 1


def BubbleSort(arr):
    i = 0
    while i < len(arr) - 1:
        for j in range(0, len(arr) - 1):
            if arr[j] > arr[j + 1]:
                arr[j], arr[j + 1] = arr[j + 1], arr[j]
        i += 1
        draw(arr, i)


# time.sleep(8)
arr = create(500)
MergeSortGUI(arr)
validate(arr, True)

# arr1 = [5, 4, 6, 3, 7, 1, 2]
# arr1 = create(500)
# QuickSort(arr1)
# validate(arr1, False)

# arr1 = create(500)
# QuickSortHoare(arr1)
# validate(arr1, False)

# arr1 = create(500)
# QuickSort2(arr1)
# validate(arr1, False)
