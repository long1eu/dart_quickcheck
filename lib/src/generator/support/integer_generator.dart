// File created by
// Lung Razvan <long1eu>
// on 19/09/2018

import 'package:dart_quickcheck/src/generator/distribution/distribution.dart';
import 'package:dart_quickcheck/src/generator/support/abstract_number_generator.dart';

class IntegerGenerator extends AbstractNumberGenerator<int> {
  static int MAX_VALUE = 2 ^ 53;
  static int MIN_VALUE = -2 ^ 53;

  IntegerGenerator([int min, int max, Distribution dist])
      : super(min = min ?? MIN_VALUE, max = max ?? MAX_VALUE,
            dist = dist ?? Distribution.uniform);

  @override
  int next() => nextInt();

  int nextInt() => nextLong();
}
