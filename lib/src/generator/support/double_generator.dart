// File created by
// Lung Razvan <long1eu>
// on 19/09/2018

import 'package:dart_quickcheck/src/generator/distribution/distribution.dart';
import 'package:dart_quickcheck/src/generator/support/abstract_number_generator.dart';

class DoubleGenerator extends AbstractNumberGenerator<double> {
  static double MAX_VALUE = double.maxFinite;
  static double MIN_VALUE = double.minPositive;

  DoubleGenerator([double min, double max, Distribution dist])
      : super(min ?? MIN_VALUE, max ?? MAX_VALUE,
            dist = dist ?? Distribution.uniform);

  @override
  double next() => _nextDouble();

  double _nextDouble() => distribution.nextRandomNumber() * (max - min) + min;
}
