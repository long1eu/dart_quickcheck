// File created by
// Lung Razvan <long1eu>
// on 19/09/2018

import 'package:dart_quickcheck/src/generator.dart';

/**
 * Declarative object generator definition.
 * <p>
 * User should call implementation of ObjectGenerator as follows:
 * <pre><code>
    ObjectGenerator<T> g;
    Generator<R> methodGenerator;
    g.on(g.getRecorder().method()).returns(methodGenerator);</code></pre>
 * </p>
 *
 * @param <T>
 *            type of object generated
 */
abstract class ObjectGenerator<T> extends Generator<T> {
  /**
   * Implementation of T that is used to define the method a generator should
   * be defined for.
   *
   * @return an implementation of T used only to record method calls
   */
  T getRecorder();

  /**
   * Define a method a generator should be defined for.
   *
   * @param <R>
   *            type of the return type
   * @param value
   *            is ignored
   * @return {@link ReturnValue} instance to define a generator for this
   *         method
   */
  ReturnValue<R> on<R>(R value);
}

abstract class ReturnValue<R> {
  void returns<T extends R>(Generator<R> generator);
}
