// File created by
// Lung Razvan <long1eu>
// on 19/09/2018

import 'package:dart_quickcheck/src/extendible_generator.dart';
import 'package:dart_quickcheck/src/generator.dart';

/**
 * <p>
 * Create a frequency generator. The frequency of {@link Generator} usage
 * depends on the generator weight.
 * </p>
 *
 */
abstract class FrequencyGenerator<T> extends ExtendibleGenerator<T, T> {
  /**
   * Add a new input generator.
   *
   * @param gen
   *            input generator
   * @param weight
   *            weight of this generator
   * @return this generator
   */
  FrequencyGenerator<T> add(Generator<T> gen, [int weight]);
}
