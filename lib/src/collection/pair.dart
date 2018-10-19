// File created by
// Lung Razvan <long1eu>
// on 19/09/2018

/**
 * A tuple of two values.
 *
 * @param <A>
 *            type of first entry
 * @param <B>
 *            type of second entry
 *
 */
class Pair<A, B> {
  final A first;
  final B second;

  const Pair(this.first, this.second);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Pair &&
          runtimeType == other.runtimeType &&
          first == other.first &&
          second == other.second;

  @override
  int get hashCode => first.hashCode ^ second.hashCode;

  @override
  String toString() => '[$first,$second]';
}
