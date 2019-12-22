from random import randrange

def random_algoritm(queue):
    length = len(queue)
    min_comp = 999
    min_i = None
    for i in range(len(queue)):
        if min_comp > queue[i].complexity:
            min_i = i
            min_comp = queue[i].complexity
    return min_i
    # if length > 0:
    #     return randrange(length)
