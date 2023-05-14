from typing import Optional, Iterable, Tuple, Iterator


class IntegerSet(AbstractSet[int]):
  def __init__(
  self,
  intervals: Optional[Iterable[Tuple[int, int]]] = None,
  ) -> None: ...
  @classmethod
  def from_iterable(
  cls,
  iterable: Optional[Iterable[int]] = None,
  ) -> IntegerSet: ...
  def __repr__(self) -> str: ...
  def __hash__(self) -> int: ...
  def __contains__(self, item: object) -> bool: ...
  def __len__(self) -> int: ...
  def __iter__(self) -> Iterator[int]: ...
  def intervals(self) -> Iterator[Tuple[int, int]]: ...
  def ranges(self) -> Iterator[range]: ...
  def __eq__(self, other: object) -> bool: ...
  def __ne__(self, other: object) -> bool: ...
  def __lt__(self, other: "IntegerSet") -> bool: ...
  def __le__(self, other: "IntegerSet") -> bool: ...
  def __gt__(self, other: "IntegerSet") -> bool: ...
  def __ge__(self, other: "IntegerSet") -> bool: ...
  def isdisjoint(self, other: Iterable[int]) -> bool: ...
  def __and__(self, other: "IntegerSet") -> "IntegerSet": ...
  def intersection(self, *others: Iterator[int]) -> "IntegerSet": ...
  def __or__(self, other: "IntegerSet") -> "IntegerSet": ...
  def union(self, *others: Iterator[int]) -> "IntegerSet": ...
  def __sub__(self, other: "IntegerSet") -> "IntegerSet": ...
  def difference(self, *others: Iterator[int]) -> "IntegerSet": ...
  def __xor__(self, other: "IntegerSet") -> "IntegerSet": ...
  def symmetric_difference(self, other: Iterator[int]) -> "IntegerSet":
  ...↪→
  def intervals(self) -> Iterator[Tuple[int, int]]: ...
  def ranges(self) -> Iterator[range]: ...
