from random import randint, choice, shuffle
import string
import texttable as tt
from munkres import Munkres, print_matrix


class Agent:
    def __init__(self, name):
        self._name = name
        self._costs = {}

    def assign(self, name, cost):
        self._costs[name] = cost

    def __repr__(self):
        return f'Name: {self._name}\nTasks: {self._costs}'


LETTERS_LC = string.ascii_lowercase
LETTERS_UC = string.ascii_uppercase


def random_name(l=2, uc=False):
    s = ''.join(choice(LETTERS_LC) for i in range(l))
    return s.capitalize() if uc else s


class AgentsStore:
    def __init__(self):
        self._agents = []
        self._tasks = []

    def generate_agents(self, count=8):
        for i in range(count):
            ag = Agent(random_name(uc=True))
            for t in self._tasks:
                ag.assign(t, randint(1, len(self._tasks)))
            self._agents.append(ag)

    def generate_tasks(self, count=8):
        ts = set()
        while len(ts) < count:
            ts.add(random_name())
        self._tasks = list(ts)

    def print_mtx(self):
        table = tt.Texttable(100)
        table.header(['Name \ Tasks'] + self._tasks)
        for a in self._agents:
            table.add_row([a._name] + [a._costs[k] for k in self._tasks])
        print('Initial weights')
        print(table.draw())

    def solve(self):
        tasks_count = len(self._tasks)
        munk = Munkres()
        mtx = [[ag._costs[t] for t in self._tasks] for ag in self._agents]
        indexes = munk.compute(mtx)
        solved = tt.Texttable(100)
        solved.header(['Name \ Task'] + self._tasks)
        cost = 0
        for idx, ag in enumerate(self._agents):
            r = [''] * tasks_count
            row, col = indexes[idx]
            c = mtx[row][col]
            r[col] = c
            cost += c
            solved.add_row([ag._name] + r)

        print('Solved')
        print(solved.draw())
        print(f'Total cost: {cost}')
    def report(self):
        self.generate_tasks()
        self.generate_agents()
        self.print_mtx()
        print()
        self.solve()


agents = AgentsStore()
agents.report()
# print(agents)
