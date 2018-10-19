// File created by
// Lung Razvan <long1eu>
// on 19/09/2018
import 'package:dart_quickcheck/src/generator.dart';
import 'package:dart_quickcheck/src/generator/support/integer_generator.dart';
import 'package:dart_quickcheck/src/util/util.dart';

class FixedValuesGenerator<T> implements Generator<T> {
  final List<T> values;
  final IntegerGenerator index;

  factory FixedValuesGenerator(List<T> values) {
    Assert.notNull(values, "values");
    Assert.notEmpty(values, "values");

    final index = new IntegerGenerator(0, values.length - 1);

    return FixedValuesGenerator._(values, index);
  }

  FixedValuesGenerator._(this.values, this.index) {}

  @override
  T next() {
    return this.values[this.index.nextInt()];
  }
}
