# distutils: sources = arithmetic/c-arithmetic/src/numeric/arithmetic.c arithmetic/c-arithmetic/src/numeric/gcd.c
# distutils: include_dirs = arithmetic/c-arithmetic/src/numeric
# distutils: extra_compile_args = -O3

cimport finite_set.c_inversion-list

class IntegerSet(AbstractSet[int]):
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
        return f"IntegerSet({list(self})"
                                  
    def __hash__(self) -> int: 
        return hash(tuple(self._set.intervals()))
                                  
    def __contains__(self, item: object) -> bool:
         return self._set.contains(item)
                                  
    def __len__(self) -> int:
         return self._set.lenght()
                                  
    def __iter__(self) -> Iterator[int]: 
         return iter(self._set)
                                  
    def intervals(self) -> Iterator[Tuple[int, int]]: 
         return iter(self._set.intervals())
    def ranges(self) -> Iterator[range]:
         return iter(self._set.ranges())
    def __eq__(self, other: object) -> bool:
         if not isinstanceof(other, IntergerSet):
             return NotImplemented
         return self._set == other._set
                                  
    def __ne__(self, other: object) -> bool:
         if not isinstanceof(other, IntergerSet):
             return NotImplemented
         return self._set != other._set
                                  
    def __lt__(self, other: "IntegerSet") -> bool:
         return self._set < other._set
                                  
    def __le__(self, other: "IntegerSet") -> bool:
         return self._set <= other._set
                                  
    def __gt__(self, other: "IntegerSet") -> bool:
         return self._set > other._set
                                  
    def __ge__(self, other: "IntegerSet") -> bool:
         return self._set >= other._set
                                  
    def isdisjoint(self, other: Iterable[int]) -> bool:
         return self._set.isdisjoint(other)
                                  
    def __and__(self, other: "IntegerSet") -> "IntegerSet":
          return IntergerSet(self._set.intersection(other._set))
                                  
    def intersection(self, *others: Iterator[int]) -> "IntegerSet":
          setList = [self._set] + [set.InversionList(o) for o in other]
          return IntergerSet(self._set.intersection(*setList))
                                  
    def __or__(self, other: "IntegerSet") -> "IntegerSet":
          return IntergerSet(self._set.union(*setList))
                             
    def union(self, *others: Iterator[int]) -> "IntegerSet":
          setList = [self._set] + [set.InversionList(o) for o in other]
          return IntergerSet(self._set.union(*setList))
                                  
    def __sub__(self, other: "IntegerSet") -> "IntegerSet":
          return IntergerSet(self._set.difference(*setList))
                                  
    def difference(self, *others: Iterator[int]) -> "IntegerSet":
          setList = [self._set] + [set.InversionList(o) for o in other]
          return IntergerSet(self._set.difference(*setList))
                                  
    def __xor__(self, other: "IntegerSet") -> "IntegerSet":
          return IntergerSet(self._set.symetric_difference(*setList))
                                  
    def symmetric_difference(self, other: Iterator[int]) -> "IntegerSet":
          setList = [self._set] + [set.InversionList(o) for o in other]
          return IntergerSet(self._set.symetric_difference(*setList))
                                  
    def intervals(self) -> Iterator[Tuple[int, int]]:
           result = []
            for i in range(self.set):
                if self.contains(i):
                    if not result:
                        result.append((i, i))
                    else:
                        start, end = result[-1]
                        if i == end + 1:
                            result[-1] = (start, i)
                        else:
                            result.append((i, i))
                else:
                    if result and i == result[-1][1] + 1:
                        result[-1] = (result[-1][0], i - 1)
            return iter(result)
                                  
    def ranges(self) -> Iterator[range]:  
            return iter([range(start, end+1) for start, end in self.intervals])
   
