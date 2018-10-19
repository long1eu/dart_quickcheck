// File created by
// Lung Razvan <long1eu>
// on 19/09/2018

import 'package:dart_quickcheck/src/collection/pair.dart';

/**
 * A tuple of three values.
 *
 * @param <A>
 *            type of first entry
 * @param <B>
 *            type of second entry
 * @param <C>
 *            type of third entry
 *
 */
class Triple<A, B, C> extends Pair<A, B> {
  final C third;

  Triple(A first, B second, this.third) : super(first, second);

  @override
  String toString() => '[$first,$second,$third]';
}
