// File created by
// Lung Razvan <long1eu>
// on 19/09/2018

import 'dart:math';

import 'package:dart_quickcheck/src/generator.dart';
import 'package:dart_quickcheck/src/generator/support/integer_generator.dart';
import 'package:dart_quickcheck/src/util/util.dart';

class IteratorGenerator<T> implements Generator<Iterator<T>> {
  static const int MIN_SIZE = 0;

  // why call the default size max_size if this size does not limit the upper
  // bound for all lists? ListGenerator(Generator, int int) does not define
  // any limit on max, so i think max_size does not reflect what the value
  // is used for. previously it was named default_size but should better
  // be named like default_max_size
  static const int MAX_SIZE = 10;

  final Generator<T> content;
  final Generator<int> size;

  factory IteratorGenerator.withContent(Generator<T> content) {
    return IteratorGenerator.withContentAndRange(content, MIN_SIZE, MAX_SIZE);
  }

  factory IteratorGenerator.withContentAndRange(
      Generator<T> content, int min, int max) {
    return IteratorGenerator(content, new IntegerGenerator(min, max));
  }

  IteratorGenerator(this.content, this.size) {
    Assert.notNull(content, "content");
    Assert.notNull(size, "size");
  }

  @override
  Iterator<T> next() {
    return () sync* {
      final int size = max(MIN_SIZE, this.size.next());
      int i = 0;
      while (i < size) {
        i++;
        yield content.next();
      }
    }()
        .iterator;
  }
}
