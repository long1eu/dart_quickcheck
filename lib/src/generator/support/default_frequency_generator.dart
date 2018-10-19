// File created by
// Lung Razvan <long1eu>
// on 19/09/2018

import 'package:dart_quickcheck/src/frequency_generator.dart';
import 'package:dart_quickcheck/src/generator.dart';
import 'package:dart_quickcheck/src/generator/support/integer_generator.dart';
import 'package:dart_quickcheck/src/util/util.dart';

class DefaultFrequencyGenerator<T> implements FrequencyGenerator<T> {
  /**
   * Weight used to generate equal weighted frequency generator.
   */
  static const int EQUAL_WEIGHT_OF_GENERATORS = 1;

  final List<_Frequency<T>> _frequencies = new List<_Frequency<T>>();
  IntegerGenerator _choose;
  int sum = 0;

  DefaultFrequencyGenerator(Generator<T> generator, [int weight]) {
    add(generator, weight ?? EQUAL_WEIGHT_OF_GENERATORS);
  }

  @override
  FrequencyGenerator<T> add(Generator<T> generator, [int weight]) {
    weight ??= EQUAL_WEIGHT_OF_GENERATORS;
    Assert.notNull(generator, "generator");
    Assert.greaterOrEqual(EQUAL_WEIGHT_OF_GENERATORS, weight, "weight");

    this._frequencies.add(new _Frequency<T>(generator, weight));
    this.sum += weight;
    this._choose = null;
    return this;
  }

  @override
  T next() {
    Assert.greaterOrEqual(1, this.sum, "number of generators");

    int next = __choose().nextInt();
    for (_Frequency<T> pair in this._frequencies) {
      int weight = pair.weight;
      if (next <= weight) {
        return pair.generator.next();
      }
      next -= weight;
    }
    throw new StateError('');
  }

  IntegerGenerator __choose() {
    if (this._choose == null) {
      this._choose = new IntegerGenerator(1, this.sum);
    }
    return this._choose;
  }
}

class _Frequency<T> {
  final Generator<T> generator;
  final int weight;

  _Frequency(this.generator, this.weight);
}
