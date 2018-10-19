// File created by
// Lung Razvan <long1eu>
// on 19/09/2018

import 'package:dart_quickcheck/src/generator.dart';

/**
 * Generator which depends upon other generator instances. After creation new
 * input generators could be added.
 *
 * @param <I>
 *            type of input generator
 * @param <T>
 *            type of generated values
 *
 */
abstract class ExtendibleGenerator<I, T> extends Generator<T> {
  /**
   * Add a new generator.
   *
   * @return this generator instance
   */
  ExtendibleGenerator<I, T> add(Generator<I> newGenerator);
}
