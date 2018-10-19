// File created by
// Lung Razvan <long1eu>
// on 19/09/2018

import 'dart:math';

import 'package:dart_quickcheck/src/generator.dart';
import 'package:dart_quickcheck/src/generator/support/integer_generator.dart';
import 'package:dart_quickcheck/src/util/util.dart';

class ListGenerator<T> implements Generator<List<T>> {
  static const int MIN_SIZE = 0;

  // why call the default size max_size if this size does not limit the upper
  // bound for all lists? ListGenerator(Generator, int int) does not define
  // any limit on max, so i think max_size does not reflect what the value
  // is used for. previously it was named default_size but should better
  // be named like default_max_size
  static const int MAX_SIZE = 10;

  final Generator<T> content;
  final Generator<int> size;

  factory ListGenerator.withContent(Generator<T> content) {
    return ListGenerator.withSize(content, MIN_SIZE, MAX_SIZE);
  }

  factory ListGenerator.withSize(Generator<T> content, [int min, int max]) {
    return ListGenerator.fromValues(
      content,
      new IntegerGenerator(min ?? MIN_SIZE, max ?? MAX_SIZE),
    );
  }

  ListGenerator.fromValues(this.content, this.size) {
    Assert.notNull(content, "content");
    Assert.notNull(size, "size");
  }

  @override
  List<T> next() {
    int size = max(MIN_SIZE, this.size.next());
    List<T> list = List<T>();
    for (int i = 0; i < size; i++) {
      list.add(this.content.next());
    }
    return list;
  }
}
