from unittest import TestCase
from finite_set import IntegerSet

class InversionTestCase(TestCase):
    def test_create(self):
        
        g = [(1, 5), (10, 15), (20, 25)]
        gg = [1, 2, 3, 4, 10, 11, 12, 13, 14, 20, 21, 22, 23, 24]
        ggg = []
        _set = IntegerSet( g )
        self.assertEqual(repr(_set), "[1, 2, 3, 4, 10, 11, 12, 13, 14, 20, 21, 22, 23, 24]")
        self.assertEqual(len(_set), 14)
        self.assertEqual(14 in _set, True)
      
        for i in _set:
            ggg.append(i)

        gg = [(1, 5)]
        ggg =  [(1, 5), (10, 15), (20, 25)]
        gggg = [(1, 5), (10, 15), (20, 30)]
        _set = IntegerSet( gg )
        _set1 = IntegerSet( ggg )
        _set3 = IntegerSet( gggg )

        self.assertEqual(_set == _set, True)

        self.assertEqual(_set <= _set, True)
        self.assertEqual(_set >= _set, True)
            
        self.assertEqual(_set < _set1, True)
        self.assertEqual(_set3 > _set1, True)
        
        _set = IntegerSet()
        self.assertEqual(repr(_set), "(null)")
