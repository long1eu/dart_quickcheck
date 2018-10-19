// File created by
// Lung Razvan <long1eu>
// on 19/09/2018
import 'dart:collection';

import 'package:dart_quickcheck/src/generator.dart';
import 'package:dart_quickcheck/src/generator/support/abstract_unique_values_generator.dart';

class UniqueComparableValuesGenerator<T>
    extends AbstractUniqueValuesGenerator<T> {
  UniqueComparableValuesGenerator(
      Generator<T> generator, Comparator<T> comparator, int maxTries)
      : super(SplayTreeSet<T>(comparator), generator, maxTries);
}
