from dataclasses import dataclass
from enum import Enum
import itertools
from typing import List


class PriorityQueue:
    def __init__(self):
        self.queue, self.priorities = [], []

    def enqueue(self, elem, priority):
        it = (i for i, p in enumerate(self.priorities) if priority < p)
        try:
            index = next(it)
            self.queue.insert(index, elem)
            self.priorities.insert(index, priority)
        except:
            self.queue.append(elem)
            self.priorities.append(priority)

    def dequeue(self):
        return self.queue.pop(0), self.priorities.pop(0)

    def front(self):
        return self.queue[-1], self.priorities[-1]

    def __bool__(self):
        return bool(self.queue)

    def __repr__(self):
        return repr(list(zip(self.queue, self.priorities)))


class Unit(Enum):
    Human = 1
    BigMonkey = 2
    SmallMonkey = 3

    def can_drive_boat(self):
        return self is not Unit.SmallMonkey

    def __str__(self):
        return {
            Unit.Human: "🧍",
            Unit.SmallMonkey: "🐒",
            Unit.BigMonkey: "🦍",
        }[self]


class Side(Enum):
    Left = 1
    Right = 2

    def __invert__(self):
        return Side.Left if self is Side.Right else Side.Right


@dataclass
class MoveUnits:
    units: List[Unit]

    def __str__(self):
        u = " ".join(str(u) for u in self.units)
        return f"Move({u})"


class State:
    INITIAL = [Unit.Human]*3 + [Unit.BigMonkey] + [Unit.SmallMonkey]*2

    def __init__(self, g_score=0, boat_side: Side = Side.Left,
                 lbank=INITIAL, rbank=[]):
        self.boat_side: Side = boat_side
        self.lbank: List[Unit] = lbank
        self.rbank: List[Unit] = rbank
        self.g_score: int = g_score

    def with_action(self, action: MoveUnits) -> "State":
        lbank, rbank = self.lbank[:], self.rbank[:]
        if self.boat_side is Side.Left:
            from_side, to_side = lbank, rbank
        else:
            to_side, from_side = lbank, rbank
        for unit in action.units:
            from_side.remove(unit)
            to_side.append(unit)
        return State(self.g_score, ~self.boat_side, lbank, rbank)

    def is_goal(self):
        return not self.lbank

    def is_failed(self):
        h = len([u for u in self.lbank if u is Unit.Human])
        m = len([u for u in self.lbank
                 if u in (Unit.SmallMonkey, Unit.BigMonkey)])
        return abs(h - m) > 1

    def possible_actions(self) -> List[MoveUnits]:
        """Get all possible children of current node"""
        bank = self.lbank if self.boat_side is Side.Left else self.rbank
        all_comb = itertools.chain(itertools.combinations(bank, r=2),
                                   itertools.combinations(bank, r=1))
        all_comb = set(pair for pair in all_comb
                       if any(unit.can_drive_boat() for unit in pair))
        return [MoveUnits(list(comb)) for comb in all_comb]

    def heuristics(self):
        """h(x)"""
        return len(self.lbank)

    def a_star(self):
        # Already visited nodes
        closed = set()
        # Priority queue
        open = PriorityQueue()
        open.enqueue(self, self.heuristics())
        # Dict for restoring the path
        backtrack = {self: None}
        while open:
            current, cur_priority = open.dequeue()
            closed.add(current)
            if current.is_goal():
                print("Found goal!")
                current.unwind(backtrack)
                return
            for action in current.possible_actions():
                next_state = current.with_action(action)
                if next_state in closed or next_state.is_failed():
                    continue
                next_state.g_score = current.g_score + 1
                f_score = next_state.g_score + next_state.heuristics()
                backtrack[next_state] = (current, action)
                open.enqueue(next_state, f_score)
        print("Couldn't find the solution")

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
            dir = "->" if s.boat_side is Side.Left else "<-"
            print(f"{ord}State: {s}")
            g, h = s.g_score, s.heuristics()
            print(f"{pad_str}g(x) = {g}, h(x) = {h}, f(x) = {g+h}")
            print(f"{pad_str}Action: {a} {dir}\n")
        print(f"{i+2}. State: {self}")

    def __str__(self):
        """Readable representation of State"""
        res = "[" + "".join(str(u) for u in self.lbank).rjust(6) + "]"
        if self.boat_side is Side.Left:
            res += " \__/~~~~~~ "
        else:
            res += " ~~~~~~\__/ "
        return res + "[" + "".join(str(u) for u in self.rbank).rjust(6) + "]"

    def __hash__(self):
        return hash((self.boat_side, tuple(self.lbank), tuple(self.rbank)))


if __name__ == "__main__":
    State().a_star()
