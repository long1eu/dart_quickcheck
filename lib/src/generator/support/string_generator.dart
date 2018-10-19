// File created by
// Lung Razvan <long1eu>
// on 19/09/2018

import 'package:dart_quickcheck/src/extendible_generator.dart';
import 'package:dart_quickcheck/src/frequency_generator.dart';
import 'package:dart_quickcheck/src/generator.dart';
import 'package:dart_quickcheck/src/generator/support/character_generator.dart';
import 'package:dart_quickcheck/src/generator/support/default_frequency_generator.dart';
import 'package:dart_quickcheck/src/generator/support/integer_generator.dart';

class StringGenerator implements ExtendibleGenerator<int, String> {
  static const int MIN_LENGTH = 0;
  static const int MAX_LENGTH = 30;

  final FrequencyGenerator<int> characters;
  final Generator<int> length;

  factory StringGenerator() => StringGenerator.forCharacters(null, null);

  StringGenerator.forValues(this.length, Generator<int> characters)
      : characters = DefaultFrequencyGenerator<int>(characters);

  factory StringGenerator.forCharactersGenerator(Generator<int> characters) {
    return StringGenerator.forValues(
      IntegerGenerator(MIN_LENGTH, MAX_LENGTH),
      characters,
    );
  }

  factory StringGenerator.forCharacters(String first, String last) {
    return StringGenerator.forCharactersGenerator(
      CharacterGenerator(
        first.codeUnitAt(0),
        last.codeUnitAt(0),
      ),
    );
  }

  @override
  String next() {
    int size = length.next();
    StringBuffer builder = new StringBuffer();
    for (int count = 0; count < size; count++) {
      builder.write(characters.next());
    }
    return builder.toString();
  }

  @override
  ExtendibleGenerator<int, String> add(Generator<int> characterGenerator) {
    characters.add(characterGenerator);
    return this;
  }
}
