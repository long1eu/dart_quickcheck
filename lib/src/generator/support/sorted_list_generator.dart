// File created by
// Lung Razvan <long1eu>
// on 19/09/2018

import 'package:dart_quickcheck/src/generator.dart';
import 'package:dart_quickcheck/src/generator/support/list_generator.dart';

class SortedListGenerator<T extends Comparable<T>>
    implements Generator<List<T>> {
  final ListGenerator<T> listGenerator;

  SortedListGenerator(Generator<T> input, [Generator<int> size])
      : listGenerator = new ListGenerator<T>.fromValues(input, size);

  @override
  List<T> next() {
    List<T> next = listGenerator.next();
    next.sort();
    return next;
  }
}
