from unittest import TestCase

"""
class InversionTestCase(TestCase):
    def test_create(self):
        _set = IntegerSet( [(1, 3), (5, 7)] )
        repr(_set)
 """

from finite_set import IntegerSet

# Créer un ensemble d'entiers
s = IntegerSet([(-10, -5), (0, 5), (10, 15)])

# Vérifier si un élément est dans l'ensemble
print(0 in s) # True
print(7 in s) # False

    
