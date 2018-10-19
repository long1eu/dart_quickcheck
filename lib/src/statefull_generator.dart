// File created by
// Lung Razvan <long1eu>
// on 19/09/2018

import 'package:dart_quickcheck/src/generator.dart';

/**
 * Any generator keeping state information has to implemet this interface.
 *
 * @param <T>
 *            type of the generated instance
 */
abstract class StatefulGenerator<T> extends Generator<T> {
  /**
   * Resets the state of the generator to the state it had immediately after
   * construction.
   *
   * Makes a heavy weight generator reusable.
   */
  void reset();
}
