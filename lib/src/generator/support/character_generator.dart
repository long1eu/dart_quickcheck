// File created by
// Lung Razvan <long1eu>
// on 19/09/2018

import 'package:dart_quickcheck/src/collection/pair.dart';
import 'package:dart_quickcheck/src/generator.dart';
import 'package:dart_quickcheck/src/generator/support/integer_generator.dart';

class CharacterGenerator implements Generator<int> {
  static const Pair<int, int> basicLatin = const Pair<int, int>(0x20, 0x7F);

  static const Pair<int, int> latin1Supplement =
      const Pair<int, int>(0xa0, 0xFF);

  final IntegerGenerator generator;

  CharacterGenerator([int first, int last])
      : generator = IntegerGenerator(
            first ?? basicLatin.first, last ?? basicLatin.second),
        assert(first <= last, 'first <= last');

  @override
  int next() {
    return nextChar();
  }

  int nextChar() {
    return this.generator.nextInt();
  }
}
