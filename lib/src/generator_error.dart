// File created by
// Lung Razvan <long1eu>
// on 19/09/2018

import 'package:dart_quickcheck/src/generator.dart';

/**
 * GeneratorException is thrown if the creation of a new instance failed.
 *
 */
class GeneratorError<T> extends StateError {
  final Generator<T> generator;

  /**
   * @param message
   *            error message
   */
  GeneratorError(String message, this.generator) : super(message);
}
