// File created by
// Lung Razvan <long1eu>
// on 19/09/2018

/**
 * A generator creates instances of type T supposed to be checked against a
 * {@link Characteristic} specification.
 *
 * @param <T>
 *            type of generated instances
 */
abstract class Generator<T> {
  /**
   * Generates the next instance.
   *
   * @return a newly created instance
   */
  T next();
}
