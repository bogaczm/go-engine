import copy
from goengine.gotypes import Player, Point

class Move():
    """Class factory, which represents all possible moves"""
    def __init__(self, point = None, is_pass: bool = False, is_resign: bool = False):
        assert (point is not None) ^ is_pass ^ is_resign
        self.point = point
        self.is_play = (self.point is not None)
        self.is_pass = is_pass
        self.is_resign = is_resign

    @classmethod
    def play(cls, point):
        return Move(point = point)

    @classmethod
    def pass_turn(cls):
        return Move(is_pass=True)

    @classmethod
    def resign(cls):
        return Move(is_resign=True)


class GoString():
    """
    Class representing a group of same colored stones,
    group has one set of liberties.
    """
    def __init__(self, color, stones, liberties):
        self.color = color
        self.stones = set(stones)
        self.liberties = set(liberties)
    
    def remove_liberty(self, point):
        self.liberties.remove(point)

    def add_liberty(self, point):
        self.liberties.add(point)

    def merge_with(self, go_string):
        assert go_string.color = self.color
        combined_stones = self.stones | go_string.stones
        return GoString(self.color, 
                        combined_stones, 
                        (self.liberties | go_string.liberties) - combined_stones)  

    @property
    def num_liberties(self):
        return len(self.liberties)

    def __eq__(self, other):
        return isinstance(other, GoString) and \
            self.color == other.color and \
            self.stones == other.stones and \
            self.liberties == other.liberties


class Board():
    """
    Class used to represent board of the game
    """
    def __init__(self):
        