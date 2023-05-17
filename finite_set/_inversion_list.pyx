# distutils: sources = finite_set/c-inversion-list/src/inversion-list/inversion-list.c finite_set/c-inversion-list/src/inversion-list/inversion-list.h finite_set/c-inversion-list/src/inversion-list/inversion-list.inc
# distutils: include_dirs = finite_set/c-inversion-list/src/inversion-list
# distutils: extra_compile_args = -O3

from typing import Optional, Iterable, Tuple, Iterator, AbstractSet

from libc.stdlib cimport malloc, free
cimport finite_set.c_inversion_list as fi

cimport finite_set.c_inversion_list

cdef _finish():
    fi.inversion_list_finish()

cdef _init():
    fi.inversion_list_init()
    import atexit
    atexit.register(_finish)

_init()

cdef fi.InversionList *_c_set

class IntegerSet(AbstractSet[int]):
    cdef __init__(
            self,
            intervals: Optional[Iterable[Tuple[int, int]]] = None,
    ) -> None:
        cdef unsigned int *values
        cdef unsigned int size
        
        if intervals is not None:
            size = sum(end - start + 1 for start, end in intervals)
            values = <unsigned int *>malloc(size * sizeof(unsigned int))
            if not values:
                raise MemoryError()

            idx = 0
            for start, end in intervals:
                for i in range(start, end + 1):
                    values[idx] = i
                    idx += 1

            self._c_set = fi.inversion_list_create(20, size, values)
            free(values)
        else:
            self._c_set = NULL

    @classmethod
    def from_iterable(cls, iterable: Optional[Iterable[int]] = None) -> 'IntegerSet':
        if iterable is not None:
            intervals = [(x, x) for x in iterable]
            return cls(intervals)
        else:
            return cls()

    def __repr__(self) -> str:
        return "IntegerSet()"

    def __hash__(self) -> int:
        return hash(tuple(self._c_set.intervals()))
"""
    def __contains__(self, item: object) -> bool:
        return fi.inversion_list_member(self._c_set, item)

    def __len__(self) -> int:
        return fi.inversion_list_support(self._c_set)

    def __iter__(self) -> Iterator[int]: 
        res = []
        _iterator = fi.inversion_list_iterator_create(self._set);
        while (fi.inversion_list_iterator_valid(_iterator)):
            res.append(fi.inversion_list_iterator_get(_iterator))
            iterator = fi.inversion_list_iterator_next(_iterator)
        return res

    def intervals(self) -> Iterator[Tuple[int, int]]: 
        res = []
        _iterator = fi.inversion_list_couple_iterator_create(self._set);
        while (fi.inversion_list_couple_iterator_valid(self._iterator)):
            res.append((fi.inversion_list_couple_iterator_inf(self._iterator), fi.inversion_list_couple_iterator_sup(self._iterator)))
            self._ = fi.inversion_list_couple_iterator_next(self._iterator)
        return res

    def ranges(self) -> Iterator[range]:
        return iter(self._set.ranges())

    def __eq__(self, other: object) -> bool:
         return fi.inversion_list_equals(self._set, self._other)

    def __ne__(self, other: object) -> bool:
         return fi.inversion_list_not_equals(self._set, self._other)

    def __lt__(self, other: "IntegerSet") -> bool:
          return fi.inversion_list_less(self._set, self._other)

    def __le__(self, other: "IntegerSet") -> bool:
          return fi.inversion_list_less_equals(self._set, self._other)

    def __gt__(self, other: "IntegerSet") -> bool:
         return fi.inversion_list_greater(self._set, self._other)

    def __ge__(self, other: "IntegerSet") -> bool:
         return fi.greater_equals(self._set, self._other)

    def isdisjoint(self, other: Iterable[int]) -> bool:
         return fi.disjoint(self._set, self._other)

    def __and__(self, other: "IntegerSet") -> "IntegerSet":
          return IntegerSet(IntegerSet(fi.inversion_list_intersection(self._set, self._other)))

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
