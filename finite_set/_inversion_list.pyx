# distutils: sources = finite_set/c-inversion-list/src/inversion-list/inversion-list.c
# distutils: include_dirs = finite_set/c-inversion-list/src/inversion-list
# distutils: extra_compile_args = -O3

cimport finite_set.c_inversion_list

cdef _finish():
    finite_set.c_inversion_list.inversion_list_finish()

cdef _init():
    finite_set.c_inversion_list.inversion_list_init()
    import atexit
    atexit.register(_finish)

_init()


class IntegerSet(AbstractSet[int]):
    finite_set.IntegerSet *_set
    def __init__(
    self,
    intervals: Optional[Iterable[Tuple[int, int]]] = None,
    ) -> None: 
        if intervals is not None:
            self._set = set.InversionList(intervals)
        else:
            self._set = set.InversionList()
   
    @classmethod
    def from_iterable(
    cls,
    iterable: Optional[Iterable[int]] = None,
    ) -> IntegerSet: 
        if iterable is not None:
            intervals = [(i, i) for i in iterable]
            return cls(intervals)
        else:
            return cls()
        
    def __repr__(self) -> str:
        return finite_set.c_inversion_list.inversion_list_to_string(self._set)
                                  
    def __hash__(self) -> int: 
        return hash(tuple(self._set.intervals()))
                                  
    def __contains__(self, item: object) -> bool:
         return finite_set.c_inversion_list.inversion_list_member(item)
                                  
    def __len__(self) -> int:
         return finite_set.c_inversion_list.inversion_list_capacity
                                  
    def __iter__(self) -> Iterator[int]: 
        res = []
        finite_set.c_inversion_list.IteratorList *iterator = finite_set.c_inversion_list.list_iterator_create(self._set);
        while (finite_set.c_inversion_list.inversion_list_iterator_valid(iterator)):
            res.append(finite_set.c_inversion_list.inversion_list_iterator__get(iterator))
            iterator = finite_set.c_inversion_list.inversion_list_iterator_next(iterator)
         return res
                                  
    def intervals(self) -> Iterator[Tuple[int, int]]: 
         res = []
        finite_set.c_inversion_list.IteratorCoupleList *iterator = finite_set.c_inversion_list.list_couple_iterator_create(self._set);
        while (finite_set.c_inversion_list.inversion_list_couple_iterator_valid(iterator)):
            res.append((finite_set.c_inversion_list.inversion_list_couple_iterator_inf(iterator), finite_set.c_inversion_list.inversion_list_couple_iterator_sup(iterator))
            iterator = finite_set.c_inversion_list.inversion_list_couple_iterator_next(iterator)
         return res
                                  
    def ranges(self) -> Iterator[range]:
         return iter(self._set.ranges())
                                  
    def __eq__(self, other: object) -> bool:
         return finite_set.c_inversion_list.inversion_list_equals(self._set, self._other)
                                  
    def __ne__(self, other: object) -> bool:
         return finite_set.c_inversion_list.inversion_list_not_equals(self._set, self._other)
                                  
    def __lt__(self, other: "IntegerSet") -> bool:
          return finite_set.c_inversion_list.inversion_list_less(self._set, self._other)
                                  
    def __le__(self, other: "IntegerSet") -> bool:
          return finite_set.c_inversion_list.inversion_list_less_equals(self._set, self._other)
                                  
    def __gt__(self, other: "IntegerSet") -> bool:
         return finite_set.c_inversion_list.inversion_list_greater(self._set, self._other)
                                  
    def __ge__(self, other: "IntegerSet") -> bool:
         return finite_set.c_inversion_list.greater_equals(self._set, self._other)
                                  
    def isdisjoint(self, other: Iterable[int]) -> bool:
         return finite_set.c_inversion_list.disjoint(self._set, self._other)
                                  
    def __and__(self, other: "IntegerSet") -> "IntegerSet":
          return IntergerSet(IntergerSet(finite_set.c_inversion_list.inversion_list_intersection(self._other, other._set)))
                                  
    def intersection(self, *others: Iterator[int]) -> "IntegerSet":
          return IntergerSet(IntergerSet(finite_set.c_inversion_list.inversion_list_intersection(self._other, other._set)))
                                  
    def __or__(self, other: "IntegerSet") -> "IntegerSet":
          return IntergerSet(IntergerSet(finite_set.c_inversion_list.inversion_list_union(self._other, other._set)))
                             
    def union(self, *others: Iterator[int]) -> "IntegerSet":
          return IntergerSet(IntergerSet(finite_set.c_inversion_list.inversion_list_union(self._other, other._set)))
                                  
    def __sub__(self, other: "IntegerSet") -> "IntegerSet":
          return IntergerSet(IntergerSet(finite_set.c_inversion_list.inversion_list_difference(self._other, other._set)))
                                  
    def difference(self, *others: Iterator[int]) -> "IntegerSet":
          return IntergerSet(IntergerSet(finite_set.c_inversion_list.inversion_list_difference(self._other, other._set)))
                                  
    def __xor__(self, other: "IntegerSet") -> "IntegerSet":
          return IntergerSet(IntergerSet(finite_set.c_inversion_list.inversion_list_symetric_difference(self._other, other._set)))
                                  
    def symmetric_difference(self, other: Iterator[int]) -> "IntegerSet":
          return IntergerSet(IntergerSet(finite_set.c_inversion_list.inversion_list_symetric_difference(self._other, other._set)))
                                  
   
