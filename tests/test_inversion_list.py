from unittest import TestCase
import finite_set


class InversionTestCase(TestCase):
    def test_create(self):
        set = IntegerSet([ (1,3), (5,7)])
        repr(set)
        print(len(set))

    
