// File created by
// Lung Razvan <long1eu>
// on 20/09/2018

import 'package:dart_quickcheck/src/generator.dart';
import 'package:dart_quickcheck/src/generator/combined_generators.dart';
import 'package:dart_quickcheck/src/generator/iterable/iterables.dart';

class CombinedGeneratorsIterables {
  const CombinedGeneratorsIterables._();

  static Iterable<Map<K, V>> someMaps<K, V>(
      Generator<K> keys, Generator<V> values) {
    return Iterables.toIterable(CombinedGenerators.maps(keys, values));
  }

  static Iterable<Map<K, V>> someMapsFromKeysAndValuesOfSize<K, V>(
      Generator<K> keys, Generator<V> values, Generator<int> size) {
    return Iterables.toIterable(
        CombinedGenerators.mapsFromKeysAndValuesOfSize(keys, values, size));
  }
}
