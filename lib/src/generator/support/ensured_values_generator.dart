// File created by
// Lung Razvan <long1eu>
// on 19/09/2018

import 'package:dart_quickcheck/src/generator.dart';
import 'package:dart_quickcheck/src/generator/support/fixed_values_generator.dart';
import 'package:dart_quickcheck/src/statefull_generator.dart';
import 'package:dart_quickcheck/src/util/util.dart';

class EnsuredValuesGenerator<T> implements StatefulGenerator<T> {
  final List<T> ensured;
  final Generator<T> generator;
  Iterator<T> iterator;

  EnsuredValuesGenerator(this.ensured, [Generator<T> generator])
      : generator = generator ?? new FixedValuesGenerator<T>(ensured) {
    Assert.notNull(ensured, "ensured");
    Assert.notEmpty(ensured, "ensured");
    Assert.notNull(generator, "random");

    reset();
  }

  @override
  T next() {
    return this.iterator.moveNext()
        ? this.iterator.current
        : this.generator.next();
  }

  @override
  void reset() {
    iterator = ensured.iterator;
  }
}
