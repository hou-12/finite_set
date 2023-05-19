# distutils: sources = finite_set/c-inversion-list/src/inversion-list/inversion-list.c 
# distutils: include_dirs = finite_set/c-inversion-list/src/inversion-list
# distutils: extra_compile_args = -O3

from typing import Optional, Iterable, Tuple, Iterator, AbstractSet

from libc.stdlib cimport malloc, free
cimport finite_set.c_inversion_list as fi


cdef _finish():
    fi.inversion_list_finish()

cdef _init():
    fi.inversion_list_init()
    import atexit
    atexit.register(_finish)

_init()


    
cdef fi.InversionList *_c_set
cdef fi.InversionListIterator *_iterator
cdef fi.InversionListCoupleIterator *_iteratorCouple
class IntegerSet:

    def __init__(
            self,
            intervals: Optional[Iterable[Tuple[int, int]]] = None,
    ) -> None:
        cdef unsigned int *values
        cdef unsigned int size
        #cdef fi.InversionList *_c_set
        
        self._intervals = intervals
        self._string = "(null)"
        self._support = 0
        self._cap = 0
        self._member = False
        self._iterator = ()
        self._value = []
        

        if intervals is not None:
            size = sum(end - start for start, end in intervals)
            values = <unsigned int *>malloc(size * sizeof(unsigned int))
            if not values:
                raise MemoryError()

            idx = 0
            for start, end in intervals:
                for i in range(start, end):
                    values[idx] = i
                    self._value.append(i)
                    idx += 1

            _c_set = fi.inversion_list_create(100, size, values)
            
            free(values)

            self._support =  fi.inversion_list_support(_c_set)
            self._string = fi.inversion_list_to_string(_c_set).decode('utf-8')
            
            #self._cap = fi.inversion_list_capacity(_c_set)
            

            assert _c_set != NULL, "erreur nullll"

            assert fi.inversion_list_support(_c_set) == size, fi.inversion_list_to_string(_c_set)
            
        else:
            _c_set = NULL
            

        
            

    @classmethod
    def from_iterable(cls, iterable: Optional[Iterable[int]] = None) -> 'IntegerSet':
        if iterable is not None:
            intervals = [(x, x) for x in iterable]
            return cls(intervals)
        else:
            return cls()

    def __repr__(self) -> str:
        return self._string
    
    
    def __hash__(self) -> int:
        return hash(tuple(self._intervals))

    def __contains__(self, item: object) -> bool:
        return item in self._value
    
    def __len__(self) -> int:
        return self._support

    def __iter__(self) -> Iterator[int]: 
        res = []
        cdef unsigned int *values
        cdef unsigned int cap, size
        

        if self._intervals is not None:
            values = <unsigned int *>malloc(len(self._value) * sizeof(unsigned int))
            cap = max(self._value)
            size = len(self._value)
            idx = 0
            for i in self._value:
                values[idx] = i
                idx += 1

        
        

            _c_set = fi.inversion_list_create(cap * 2, size, values)

            assert _c_set != NULL, "nullll"
            
            _iterator = fi.inversion_list_iterator_create(_c_set);
            
            assert _iterator != NULL, "erreur nullll"

            while (fi.inversion_list_iterator_valid(_iterator)):
                yield fi.inversion_list_iterator_get(_iterator)
                _iterator = fi.inversion_list_iterator_next(_iterator)

            free(_c_set)
            free(values)
            free(_iterator)
        

    def intervals(self) -> Iterator[Tuple[int, int]]: 
        res = []
        cdef unsigned int *values
        cdef unsigned int cap, size
       

        if self._intervals is not None:
            values = <unsigned int *>malloc(len(self._value) * sizeof(unsigned int))
            cap = max(self._value)
            size = len(self._value)
            idx = 0
            for i in self._value:
                values[idx] = i
                idx += 1

            _c_set = fi.inversion_list_create(cap, size, values)

            _iteratorCouple = fi.inversion_list_couple_iterator_create(_c_set);
            
            while (fi.inversion_list_iterator_couple_valid(_iteratorCouple)):
                yield (fi.inversion_list_couple_iterator_get_inf(_iteratorCouple), fi.inversion_list_couple_iterator_get_sup(_iteratorCouple))
                _iterator = fi.inversion_list_couple_iterator_next(_iteratorCouple)
        
        free(_c_set)
        free(values)
        free(_iteratorCouple)
        

    def ranges(self) -> Iterator[range]:
        return iter(self._set.ranges())

    def __eq__(self, other: object) -> bool:
            return self._value == other._value

    def __ne__(self, other: object) -> bool:
            return self._value != other._value

    def __lt__(self, other: "IntegerSet") -> bool:
            return self._value < other._value


    def __le__(self, other: "IntegerSet") -> bool:
            return self._value <= other._value

    def __gt__(self, other: "IntegerSet") -> bool:
            return self._value > other._value

    def __ge__(self, other: "IntegerSet") -> bool:
            return self._value >= other._value

"""
    def isdisjoint(self, other: Iterable[int]) -> bool:
        
        cdef unsigned int *values
        cdef unsigned int cap, size
        cap = 0
        size = 0

        if self._intervals is not None:
            
            values = <unsigned int *>malloc(len(self._value) * sizeof(unsigned int))
            
            size = len(self._value)
            idx = 0
            for i in self._value:
                values[idx] = i
                if i > cap:
                    cap = i
                idx += 1

            _c_set = fi.inversion_list_create(cap, size, values)
            free(values)
            
        cdef fi.InversionList * _oth
        if other is not None:
            
            values = <unsigned int *>malloc(len(other) * sizeof(unsigned int))
            
            size = len(other)
            idx = 0
            cap = 0
            for i in other:
                values[idx] = i
                if i > cap:
                    cap = i
                idx += 1

            _oth = fi.inversion_list_create(100, size, values)
            free(values)
            
        assert _oth != NULL, "nulll"
        return fi.inversion_list_disjoint(_c_set, _oth)


    def __and__(self, other: "IntegerSet") -> "IntegerSet":
        cdef unsigned int *values
        cdef unsigned int cap, size
        cdef fi.InversionList * _oth
       

        if self._intervals is not None:
            values = <unsigned int *>malloc(len(self._value) * sizeof(unsigned int))
            cap = max(self._value)
            size = len(self._value)
            idx = 0
            for i in self._value:
                values[idx] = i
                idx += 1

            _c_set = fi.inversion_list_create(cap, size, values)
        
            free(values)

        if other._intervals is not None:
            cap = max(other._value)
            size = len(other._value)
            idx = 0
            for i in other._value:
                values[idx] = i
                idx += 1

            _oth = fi.inversion_list_create(cap * 2, size, values)

            free(values)
        return fi.inversion_list_intersection(_c_set, _oth)

    def intersection(self, *others: Iterator[int]) -> "IntegerSet":
            _iset = self._set
            for i in others:
                iset = IntegerSet(fi.inversion_list_intersection(_iset, i._set))
            return IntegerSet(_iset)

    def __or__(self, other: "IntegerSet") -> "IntegerSet":
            return IntegerSet(IntegerSet(fi.inversion_list_union(self._set, self._other)))

    def union(self, *others: Iterator[int]) -> "IntegerSet":
            _iset = self._set
            for i in others:
                iset = IntegerSet(fi.inversion_list_union(_iset, i._set))
            return IntegerSet(_iset)

    def __sub__(self, other: "IntegerSet") -> "IntegerSet":
            return IntegerSet(IntegerSet(fi.inversion_list_difference(self._set, self._other)))

    def difference(self, *others: Iterator[int]) -> "IntegerSet":
            _iset = self._set
            for i in others:
                iset = IntegerSet(fi.inversion_list_difference(_iset, i._set))
            return IntegerSet(_iset)

    def __xor__(self, other: "IntegerSet") -> "IntegerSet":
            return IntegerSet(IntegerSet(fi.inversion_list_symetric_difference(self._set, self._other)))

    def symmetric_difference(self, other: Iterator[int]) -> "IntegerSet":
            _iset = self._set
            for i in other:
                iset = IntegerSet(fi.inversion_list_symetric_difference(_iset, i._set))
            return IntegerSet(_iset)
 """
