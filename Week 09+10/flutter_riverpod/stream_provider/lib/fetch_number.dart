Stream<int> fetchNumbers() {
  return Stream<int>.periodic(
    Duration(seconds:2),
      (number) => number
  ).take(100);
}