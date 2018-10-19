// File created by
// Lung Razvan <long1eu>
// on 19/09/2018
import 'package:dart_quickcheck/src/generator.dart';
import 'package:dart_quickcheck/src/generator/support/set_generator.dart';
import 'package:dart_quickcheck/src/util/util.dart';

class MapGenerator<K, V> implements Generator<Map<K, V>> {
  final Generator<Set<K>> keys;
  final Generator<V> values;

  MapGenerator(Generator<K> keys, this.values, [Generator<int> size])
      : keys = size == null
            ? SetGenerator.fromContent(keys)
            : SetGenerator<K>(keys, size, SetGenerator.MAX_TRIES) {
    Assert.notNull(keys, "keys");
    Assert.notNull(values, "values");
  }

  @override
  Map<K, V> next() {
    Map<K, V> next = new Map<K, V>();
    for (K key in keys.next()) {
      next[key] = values.next();
    }
    return next;
  }
}
