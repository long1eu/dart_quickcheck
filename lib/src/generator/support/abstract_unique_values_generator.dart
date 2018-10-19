// File created by
// Lung Razvan <long1eu>
// on 19/09/2018

import 'package:dart_quickcheck/src/generator.dart';
import 'package:dart_quickcheck/src/generator/support/vetoable_generator.dart';
import 'package:dart_quickcheck/src/statefull_generator.dart';
import 'package:dart_quickcheck/src/util/util.dart';

abstract class AbstractUniqueValuesGenerator<T> extends VetoableGenerator<T>
    implements StatefulGenerator<T> {
  Set<T> values;

  AbstractUniqueValuesGenerator(
      this.values, Generator<T> generator, int maxTries)
      : super(generator, (T value) => values.add(value), maxTries) {
    Assert.notNull(values, "values");
    reset();
  }

  @override
  void reset() {
    values.clear();
  }
}
