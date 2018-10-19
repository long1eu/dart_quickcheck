// File created by
// Lung Razvan <long1eu>
// on 19/09/2018

import 'package:dart_quickcheck/src/generator.dart';
import 'package:dart_quickcheck/src/generator/support/subset_generator.dart';
import 'package:dart_quickcheck/src/util/util.dart';

class SubmapGenerator<K, V> implements Generator<Map<K, V>> {
  final SubsetGenerator<MapEntry<K, V>> subsets;

  SubmapGenerator(Map<K, V> supermap, [Generator<int> sizes])
      : subsets = sizes == null
            ? SubsetGenerator<MapEntry<K, V>>(supermap.entries)
            : SubsetGenerator<MapEntry<K, V>>(supermap.entries, sizes) {
    Assert.notNull(supermap, "supermap");
    Assert.notNull(sizes, "sizes");
  }

  @override
  Map<K, V> next() {
    Set<MapEntry<K, V>> entries = subsets.next();
    Map<K, V> submap = new Map<K, V>();
    for (MapEntry<K, V> e in entries) submap[e.key] = e.value;
    return submap;
  }
}
