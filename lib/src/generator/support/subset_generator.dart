// File created by
// Lung Razvan <long1eu>
// on 19/09/2018

import 'package:dart_quickcheck/src/generator.dart';
import 'package:dart_quickcheck/src/generator/support/integer_generator.dart';
import 'package:dart_quickcheck/src/util/util.dart';

class SubsetGenerator<T> implements Generator<Set<T>> {
  final List<T> superset;
  final Generator<int> sizes;

  SubsetGenerator(Set<T> superset, [Generator<int> size])
      : sizes = size ?? IntegerGenerator(0, maxSize(superset.toList())),
        superset = superset.toList() {
    Assert.notNull(superset, "superset");
    Assert.notNull(size, "size");
  }

  @override
  Set<T> next() {
    superset.shuffle();
    int size = sizes.next();
    Assert.greaterOrEqual(minSize(superset), size, "subset size");
    Assert.lessOrEqual(maxSize(superset), size, "subset size");
    return new Set<T>.from(superset.sublist(0, size));
  }

  static int maxSize<T>(List<T> superset) => superset.length;

  static int minSize<T>(List<T> superset) => 0;
}
