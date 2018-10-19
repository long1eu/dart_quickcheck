// File created by
// Lung Razvan <long1eu>
// on 19/09/2018

import 'package:dart_quickcheck/src/generator.dart';
import 'package:dart_quickcheck/src/generator/support/integer_generator.dart';
import 'package:dart_quickcheck/src/generator/support/list_generator.dart';
import 'package:dart_quickcheck/src/generator/support/unique_values_generator.dart';
import 'package:dart_quickcheck/src/generator/support/vetoable_generator.dart';
import 'package:dart_quickcheck/src/statefull_generator.dart';

class SetGenerator<T> implements Generator<Set<T>> {
  static const int MAX_SIZE = ListGenerator.MAX_SIZE;
  static const int MAX_TRIES = VetoableGenerator.DEFAULT_MAX_TRIES;

  ListGenerator<T> lists;
  StatefulGenerator<T> content;

  factory SetGenerator.fromContent(Generator<T> content) {
    return SetGenerator.fromContentWithRetries(content, MAX_TRIES);
  }

  factory SetGenerator.fromContentWithRetries(Generator<T> content, int tries) {
    return SetGenerator(
      content,
      IntegerGenerator(0, MAX_SIZE),
      tries,
    );
  }

  SetGenerator(Generator<T> content, Generator<int> size, int tries) {
    this.content = UniqueValuesGenerator<T>(content, tries);
    this.lists = new ListGenerator<T>.fromValues(this.content, size);
  }

  @override
  Set<T> next() {
    content.reset();
    return new Set<T>.from(lists.next());
  }
}
