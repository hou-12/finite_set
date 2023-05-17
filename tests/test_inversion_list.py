from unittest import TestCase
import finite_set as f

class InversionTestCase(TestCase):
    def test_create(self):
        set = f.__init__([ (1,3), (5,7)])
        repr(set)
        print(len(set))

    
