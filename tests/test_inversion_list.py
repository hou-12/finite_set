from unittest import TestCase
import finite_set as f

class InversionTestCase(TestCase):
    def test_create(self):
        set = f.IntegerSet([ (1,3), (5,7)])
        repr(set)
        print(len(set))

    
