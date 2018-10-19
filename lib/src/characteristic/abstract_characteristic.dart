// File created by
// Lung Razvan <long1eu>
// on 19/09/2018

import 'package:dart_quickcheck/src/characteristic.dart';
import 'package:dart_quickcheck/src/characteristic/classification.dart';

/**
 * {@link AbstractCharacteristic} is an implementation of {@link Characteristic}
 * with {@link Classification} handling. The methods
 * {@link AbstractCharacteristic#classify(Object)} and
 * {@link AbstractCharacteristic#classify(bool, Object)} can be used to
 * classify test data.
 *
 * @param <T>
 *            Type of generated random test instances.
 *
 */
abstract class AbstractCharacteristic<T> implements Characteristic<T> {
  final Classification classification = new Classification();
  @override
  final String name;

  AbstractCharacteristic(this.name);

  /**
   * {@inheritDoc}
   *
   * {@link AbstractCharacteristic#specify(Object)} will call
   * {@link AbstractCharacteristic#doSpecify(Object)}.
   */
  @override
  void specify(T any) {
    doSpecify(any);
    this.classification.call();
  }

  /**
   * Add a classification with the given key if the predicate is true.
   *
   * @param classification
   *            classification key.
   */
  void classify(Object classification, [bool predicate]) {
    this.classification.doClassify(classification, predicate);
  }

  /**
   * Implement this method to specify the characteristic ({@link Characteristic#specify(Object)}).
   */

  void doSpecify(T any);

  /**
   * {@inheritDoc}
   */
  @override
  void setUp() {}

  /**
   * {@inheritDoc}
   */
  @override
  void tearDown() {}
}
