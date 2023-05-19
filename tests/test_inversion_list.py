from unittest import TestCase


class InversionTestCase(TestCase):
    def test_create(self):
        _set = IntegerSet( [(1, 3), (5, 7)] )
        self.assertEqual(repr(_set), "NULL")

        _set = IntegerSet()
        self.assertEqual(repr(_set), "NULL")
 

from finite_set import IntegerSet

# Créer un ensemble d'entiers
intervals = [(1,2),(3,5),(6,9)]
integer_set = IntegerSet(intervals)



    
