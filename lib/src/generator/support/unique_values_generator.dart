// File created by
// Lung Razvan <long1eu>
// on 19/09/2018

import 'package:dart_quickcheck/src/generator.dart';
import 'package:dart_quickcheck/src/generator/support/abstract_unique_values_generator.dart';

class UniqueValuesGenerator<T> extends AbstractUniqueValuesGenerator<T> {
  UniqueValuesGenerator(Generator<T> generator, int defaultMaxTries)
      : super(Set<T>(), generator, defaultMaxTries);
}
