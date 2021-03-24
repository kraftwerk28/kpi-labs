from dataclasses import dataclass
from enum import Enum
import itertools
import random


class Gender(Enum):
    M = 1
    F = 2

    def __str__(self):
        return "M" if self is Gender.M else "F"


@dataclass
class Unit:
    gender: Gender
    pair_id: int

    def __hash__(self):
        return hash((self.gender, self.pair_id))

    def __str__(self):
        return f"{self.gender}{self.pair_id}"

    def __repr__(self):
        return str(self)


BOAT_CAPACITY = 3
INITIAL_STATE = []
for i in range(1, 6):
    INITIAL_STATE.append(Unit(Gender.M, i))
    INITIAL_STATE.append(Unit(Gender.F, i))


class Side(Enum):
    Left = 1
    Right = 2

    def __invert__(self):
        return Side.Left if self is Side.Right else Side.Right


class State:
    def __init__(self, lbank=INITIAL_STATE, rbank=[], side=Side.Left):
        self.lbank = lbank
        self.rbank = rbank
        self.side = side

    def is_failed(self):
        males = [u for u in self.lbank if u.gender is Gender.M]
        for u in self.lbank:
            if u.gender is Gender.F:
                if all(m.pair_id != u.pair_id for m in males):
                    return True
        # males = [u for u in self.rbank if u.gender is Gender.M]
        # for u in self.rbank:
        #     if u.gender is Gender.F:
        #         if all(m.pair_id != u.pair_id for m in males):
        #             return True
        return False

    def possible_moves(self):
        """Get all possible children of current node"""
        bank = self.lbank if self.side is Side.Left else self.rbank
        combinations_nsize = [itertools.combinations(bank, r=i)
                              for i in range(1, BOAT_CAPACITY+1)]
        all_comb = set(group for group in itertools.chain(*combinations_nsize))
        return [list(comb) for comb in all_comb]

    def value(self):
        return len(self.rbank)

    def is_goal(self):
        return len(self.lbank) == 0

    def with_move(self, units) -> "State":
        """Next state based on move"""
        lbank, rbank = self.lbank[:], self.rbank[:]
        if self.side is Side.Left:
            from_side, to_side = lbank, rbank
        else:
            to_side, from_side = lbank, rbank
        for unit in units:
            from_side.remove(unit)
            to_side.append(unit)
        return State(lbank, rbank, ~self.side)

    def unwind(self, backtrack):
        """Restore solution path"""
        print("Solution:")
        path = []
        curr = backtrack[self]
        while curr is not None:
            path.insert(0, curr)
            curr = backtrack[curr[0]]
        for i, (s, a) in enumerate(path):
            ord = (str(i + 1)+".").ljust(4)
            pad_str = " "*4
            dir = "->" if s.side is Side.Left else "<-"
            print(f"{ord}State: {s}")
            print(f"{pad_str}Action: {a} {dir}\n")
        print(f"{i+2}. State: {self}")

    def hill_climb(self):
        """Stochastic hill-climbing"""
        current = self
        backtrack = {self: None}
        while True:
            h = current.value()
            better, non_better = [], []
            for m in current.possible_moves():
                next = current.with_move(m)
                if next.is_failed():
                    continue
                if next.is_goal():
                    return current.unwind(backtrack)
                    return
                nextvalue = next.value()
                if nextvalue > h:
                    better.append((next, m))
                else:
                    non_better.append((next, m))
            if better:
                next = random.choice(better)
            else:
                next = random.choice(non_better)
            backtrack[next[0]] = (current, next[1])
            current = next[0]

    def __str__(self):
        l = ",".join(str(u) for u in self.lbank)
        r = ",".join(str(u) for u in self.rbank)
        return f"{l} | {r} {self.side}"


if __name__ == "__main__":
    s = State()
    s.hill_climb()
