#!/usr/bin/env python
from enum import Enum
from dataclasses import dataclass
from typing import List


class Unit(Enum):
    Cannibal = 1
    Missionary = 2

    def __str__(self):
        return "C" if self is Unit.Cannibal else "M"


class BoatSide(Enum):
    Left = 1
    Right = 2

    def opposite(self):
        return BoatSide.Left if (self is BoatSide.Right) else BoatSide.Right


@dataclass
class Action:
    pass


@dataclass
class MoveUnits(Action):
    units: List[Unit]

    def __repr__(self):
        return "Move(" + ",".join(str(u) for u in self.units) + ")"


@dataclass
class Nop(Action):
    def __repr__(self):
        return "Nop"


class State:
    def __init__(self,
                 boat_side=BoatSide.Left,
                 lbank=[Unit.Cannibal]*3+[Unit.Missionary]*3,
                 rbank=[]):
        self.boat_side = boat_side
        self.lbank = lbank
        self.rbank = rbank

    def with_action(self, action: Action) -> "State":
        """Get next state based on `action`"""
        l, r = self.lbank[:], self.rbank[:]
        if isinstance(action, MoveUnits):
            for u in action.units:
                if self.boat_side == BoatSide.Left:
                    l.remove(u)
                    r.append(u)
                else:
                    r.remove(u)
                    l.append(u)
        return State(self.boat_side.opposite(), l, r)

    def is_goal(self) -> bool:
        """If state is desired (left bank should be empty)"""
        return not self.lbank

    def is_failed(self) -> bool:
        """If state isn't satisfying the requirements"""
        if (len([u for u in self.lbank if u is Unit.Cannibal]) !=
                len([u for u in self.lbank if u is Unit.Missionary])):
            return True
        return False

    def possible_actions(self) -> List[Action]:
        """Get possible next actions from current state"""
        result = []
        bank = self.lbank if self.boat_side is BoatSide.Left else self.rbank
        if len([u for u in bank if u is Unit.Cannibal]) >= 2:
            result.append(MoveUnits([Unit.Cannibal]*2))
        if len([u for u in bank if u is Unit.Missionary]) >= 2:
            result.append(MoveUnits([Unit.Missionary]*2))
        if Unit.Cannibal in bank and Unit.Missionary in bank:
            result.append(MoveUnits([Unit.Cannibal, Unit.Missionary]))
        if Unit.Cannibal in bank:
            result.append(MoveUnits([Unit.Cannibal]))
        if Unit.Missionary in bank:
            result.append(MoveUnits([Unit.Missionary]))
        result.append(Nop())
        return result

    def dfs(self):
        """Depth first search"""
        stack = [self]
        visited = set([self])
        # Used to build full path after algorithm finishes
        backtrack = {self: None}
        while stack:
            st = stack.pop()
            if st.is_goal():
                print("SOLUTION:")
                path, curr = [], (st, Nop())
                while curr is not None:
                    path.insert(0, curr)
                    curr = backtrack[curr[0]]
                for i, (s, a) in enumerate(path):
                    print(f"{i+1}. State: {s}")
                    print(f"   Action: {a}")
                return
            for action in st.possible_actions():
                next_state = st.with_action(action)
                if next_state not in visited and not next_state.is_failed():
                    visited.add(next_state)
                    stack.append(next_state)
                    backtrack[next_state] = (st, action)

    def __repr__(self):
        res = "[" + "".join(str(u) for u in self.lbank).rjust(6) + "]"
        if self.boat_side is BoatSide.Left:
            res += " ~B~~~~~~~~ "
        else:
            res += " ~~~~~~~~B~ "
        return res + "[" + "".join(str(u) for u in self.rbank).rjust(6) + "]"

    def __eq__(self, o):
        return (self.lbank == o.lbank
                and self.boat_side == o.boat_side
                and self.rbank == o.rbank)

    def __hash__(self):
        """Hash method to use `State` in `visited` set"""
        return hash((tuple(self.lbank), tuple(self.rbank), self.boat_side))


if __name__ == "__main__":
    State().dfs()
