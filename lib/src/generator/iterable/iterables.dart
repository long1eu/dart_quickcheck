// File created by
// Lung Razvan <long1eu>
// on 19/09/2018

import 'package:dart_quickcheck/dart_quickcheck.dart';
import 'package:dart_quickcheck/src/util/util.dart';

class Iterables {
  Iterables._() {}

  /**
   * Convert a generator into a {@link Iterable iterable}.
   *
   * @param numberOfRuns to execute the runner
   */
  static Iterable<T> toIterable<T>(final Generator<T> generator,
      [int numberOfRuns]) {
    numberOfRuns ??= QuickCheck.MAX_NUMBER_OF_RUNS;
    Assert.notNull(generator, "generator");
    Assert.greaterOrEqual(0.0, numberOfRuns, "number of runs");

    return () sync* {
      int runs = 0;

      while (runs < numberOfRuns) {
        runs++;
        yield generator.next();
      }
    }();
  }
}
