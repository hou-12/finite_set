from unittest import TestCase
from finite_set import IntegerSet

class InversionTestCase(TestCase):
    def test_create(self):
         _set = IntegerSet([(1, 3), (5, 7)])
        print(repr(_set))
        print(len(_set))

    
