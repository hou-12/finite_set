from unittest import TestCase
from _inversion_list import IntegerSet

class InversionTestCase(TestCase):
    def test_create(self):
        _set = IntegerSet( [(1, 3), (5, 7)] )
        repr(_set)
        

    
