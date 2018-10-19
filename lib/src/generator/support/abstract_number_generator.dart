// File created by
// Lung Razvan <long1eu>
// on 19/09/2018

import 'package:dart_quickcheck/src/generator.dart';
import 'package:dart_quickcheck/src/generator/distribution/distribution.dart';
import 'package:dart_quickcheck/src/util/util.dart';

abstract class AbstractNumberGenerator<T> implements Generator<T> {
  final Distribution distribution;
  final num min;
  final num max;
  final num range;

  AbstractNumberGenerator(this.min, this.max, this.distribution)
      : range = max - min {
    Assert.lessOrEqual(max, min, "min <= max");
  }

  // TODO precision of (-1.0,1.0) distribution.nextRandomNumber() ?
  int nextLong() {
    return longImpl();
  }

  int longImpl() {
    return min + (distribution.nextRandomNumber() * (range + 1.0)).floor();
  }
}
