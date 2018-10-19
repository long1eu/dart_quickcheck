// File created by
// Lung Razvan <long1eu>
// on 19/09/2018

import 'package:dart_quickcheck/src/generator/distribution/random_configuration.dart';

/**
 * <a
 * href="http://en.wikipedia.org/wiki/Image:Normal_distribution_pdf.png">Normal
 * distribution</a> and <a
 * href="http://en.wikipedia.org/wiki/Image:Uniform_distribution_PDF.png">uniform
 * distribution</a> distribution functions.
 *
 * @author $Id$
 */
abstract class Distribution {
  const Distribution();

  static const Distribution positiveNormal = const PositiveNormalDistribution();
  static const Distribution negativeNormal = const NegativeNormalDistribution();
  static const Distribution invertedNormal = const InvertedNormalDistribution();
  static const Distribution uniform = const UniformDistribution();

  /**
   * Generate the next random number for this distribution function.
   *
   * @return double 0 <= x <= 1.0
   */
  double nextRandomNumber();
}

abstract class AbstractDistribution implements Distribution {
  const AbstractDistribution();

  static final int N_SIGMA = 3;

  double nextGausian([int sigma]) {
    sigma ??= N_SIGMA;
    // n * sigma range normalized to 1.0
    return (RandomConfiguration.nextGaussian() % sigma) / sigma;
  }
}

/**
 * Right side of the bell curve. Values range from 0.0 to 1.0. Values near
 * 0.0 are the most probable.
 */
class PositiveNormalDistribution extends AbstractDistribution {
  const PositiveNormalDistribution();

  @override
  nextRandomNumber() => nextGausian().abs();
}

/**
 * Left side of the bell curve. Values range from 0.0 to 1.0. Values near
 * 1.0 are the most probable.
 */
class NegativeNormalDistribution extends AbstractDistribution {
  const NegativeNormalDistribution();

  @override
  double nextRandomNumber() => (-1 + (nextGausian().abs())).abs();
}

/**
 * An inverted bell curve. Values range from 0.0 to 1.0. Values near 0.0 and
 * 1.0 are the most probable.
 */
class InvertedNormalDistribution extends AbstractDistribution {
  const InvertedNormalDistribution();

  @override
  nextRandomNumber() {
    double next = nextGausian(AbstractDistribution.N_SIGMA * 2);
    return (next < 0) ? 1 + next : next;
  }
}

/**
 * A uniform distribution function. Values range from 0.0 to 1.0.
 */
class UniformDistribution extends AbstractDistribution {
  const UniformDistribution();

  @override
  double nextRandomNumber() {
    return RandomConfiguration.random.nextDouble();
  }
}
