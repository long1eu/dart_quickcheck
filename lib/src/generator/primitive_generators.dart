// File created by
// Lung Razvan <long1eu>
// on 19/09/2018

import 'package:dart_quickcheck/src/extendible_generator.dart';
import 'package:dart_quickcheck/src/generator.dart';
import 'package:dart_quickcheck/src/generator/distribution/distribution.dart';
import 'package:dart_quickcheck/src/generator/support/character_generator.dart';
import 'package:dart_quickcheck/src/generator/support/cloning_generator.dart';
import 'package:dart_quickcheck/src/generator/support/datetime_generator.dart';
import 'package:dart_quickcheck/src/generator/support/double_generator.dart';
import 'package:dart_quickcheck/src/generator/support/fixed_values_generator.dart';
import 'package:dart_quickcheck/src/generator/support/integer_generator.dart';
import 'package:dart_quickcheck/src/generator/support/string_generator.dart';
import 'package:dart_quickcheck/src/generator/support/vetoable_generator.dart';

/**
 * <p>
 * {@link PrimitiveGenerators} contains factory methods for primitive value
 * generators. These can be used to build custom test case generators.
 * <p/>
 * <p>
 * The default distribution for generators is {@link Distribution#UNIFORM}.
 * </p>
 */
class PrimitiveGenerators {
  static const int DEFAULT_STRING_MAX_LENGTH = StringGenerator.MAX_LENGTH;

  /**
   * Create a new string generator.<br>
   *
   * The characters are from the Basic Latin and Latin-1 Supplement unicode blocks.
   */
  static ExtendibleGenerator<int, String> strings() {
    return new StringGenerator();
  }

  /**
   * Create a new string generator which generates strings of characters
   * ranging from lo to hi.
   *
   * @param lo
   *            lower boundary character
   * @param hi
   *            upper boundary character
   */
  static ExtendibleGenerator<int, String> stringsForCharacters(
      String lo, String hi) {
    return new StringGenerator.forCharacters(lo, hi);
  }

  /**
   * Create a new string generator which generates strings of characters from
   * the given string.
   */
  static ExtendibleGenerator<int, String> stringsForChars(
      String allowedCharacters) {
    return new StringGenerator.forCharactersGenerator(
        charactersFromString(allowedCharacters));
  }

  /**
   * Create a new string generator which generates strings of characters from
   * the given string with a length between min and max.
   */
  static ExtendibleGenerator<int, String> stringsForValuesAndSize(
      String allowedCharacters, int min, int max) {
    return new StringGenerator.forValues(
      new IntegerGenerator(min, max),
      charactersFromString(allowedCharacters),
    );
  }

  /**
   * Creates a new String genearator which generates strings whose length
   * ranges from zero to given length.
   */
  static ExtendibleGenerator<int, String> stringsForMaxSize(int max) {
    return stringsForSize(0, max);
  }

  /**
   * Create a new string generator which generates strings of sizes ranging
   * from loLength to hiLength.
   *
   * @param min
   *            lower size boundary
   * @param max
   *            upper size boundary
   */
  static ExtendibleGenerator<int, String> stringsForSize(int min, int max) {
    return new StringGenerator.forValues(
      new IntegerGenerator(min, max),
      new CharacterGenerator(),
    );
  }

  /**
   * Create a new string generator which creates strings of characters
   * generated by the given character generator with a length generated by the
   * length generator.
   *
   */
  static ExtendibleGenerator<int, String> stringsForValues(
      Generator<int> length, Generator<int> characters) {
    return new StringGenerator.forValues(length, characters);
  }

  /**
   * Create a new string generator which creates strings of characters
   * generated by the given character generator.
   *
   */
  static ExtendibleGenerator<int, String> forCharactersGenerator(
      Generator<int> characterGenerator) {
    return new StringGenerator.forCharactersGenerator(characterGenerator);
  }

  /**
   * Create a new string generator which creates strings of characters from
   * a-z and A-Z.
   */
  static ExtendibleGenerator<int, String> letterStrings() {
    return new StringGenerator.forCharactersGenerator(
            charactersForStringRange('a', 'z'))
        .add(charactersForStringRange('A', 'Z'));
  }

  /**
   * Create a new string generator which creates strings with sizes ranging
   * from loLengh to hiLength of characters from a-z and A-Z.
   */
  static ExtendibleGenerator<int, String> letterStringsForSize(
      int min, int max) {
    StringGenerator generator = new StringGenerator.forValues(
      new IntegerGenerator(min, max),
      charactersForStringRange('a', 'z'),
    );
    return generator.add(charactersForStringRange('A', 'Z'));
  }

  /**
   * Create a new string generator which creates strings of characters
   * generated by {@link PrimitiveGenerators#basicLatinCharacters()} and
   * {@link PrimitiveGenerators#latin1SupplementCharacters()}.
   */
  static ExtendibleGenerator<int, String> printableStrings() {
    return new StringGenerator.forCharactersGenerator(basicLatinCharacters())
        .add(latin1SupplementCharacters());
  }

  /**
   * Create a new string generator for strings that are not empty.
   */
  static ExtendibleGenerator<int, String> nonEmptyStrings() {
    return stringsForSize(1, StringGenerator.MAX_LENGTH);
  }

  /**
   * Create a new character generator.<br>
   *
   * The characters are from the Basic Latin and Latin-1 Supplement unicode blocks.
   */
  static Generator<int> characters() {
    return new CharacterGenerator();
  }

  /**
   * Create a new character generator which generates characters ranging from
   * lo to hi.
   */
  static Generator<int> charactersForStringRange(String lo, String hi) {
    return new CharacterGenerator(lo.codeUnitAt(0), hi.codeUnitAt(0));
  }

  /**
   * Create a new character generator which generates characters ranging from
   * lo to hi.
   */
  static Generator<int> charactersForRange(int lo, int hi) {
    return new CharacterGenerator(lo, hi);
  }

  /**
   * Create a new character generator which generates characters from the
   * given string.
   */
  static Generator<int> charactersFromString(String string) {
    return charactersFromCodePoints(string.codeUnits);
  }

  /**
   * Create a new character generator which generates characters from the
   * given character collection.
   */
  static Generator<int> charactersFromCodePoints(List<int> chars) {
    return new FixedValuesGenerator<int>(chars);
  }

  /**
   * Create a new character generator which generates latin-1 supplement
   * characters.
   */
  static Generator<int> latin1SupplementCharacters() {
    return charactersForRange(
      CharacterGenerator.latin1Supplement.first,
      CharacterGenerator.latin1Supplement.second,
    );
  }

  /**
   * Create a new character generator which generates latin characters.
   */
  static Generator<int> basicLatinCharacters() {
    return charactersForRange(
      CharacterGenerator.basicLatin.first,
      CharacterGenerator.basicLatin.second,
    );
  }

  /**
   * Create a new integer generator which creates integers ranging from
   * {@link int#MIN_VALUE} to {@link int#MAX_VALUE}.
   *
   */
  static Generator<int> integers() {
    return new IntegerGenerator();
  }

  /**
   * Create a new integer generator which creates integers that are at equal
   * or greater than low.
   */
  static Generator<int> integersFrom(int low) {
    return new IntegerGenerator(low, IntegerGenerator.MAX_VALUE);
  }

  /**
   * Create a new integer generator which creates integers ranging from lo to
   * hi.
   */
  static Generator<int> integersFromRange(int lo, int hi) {
    return new IntegerGenerator(lo, hi);
  }

  /**
   * Create a new integer generator which creates integers ranging from lo to
   * hi based on the given {@link Distribution}.
   */
  static Generator<int> integersFromRandAndDistribution(
      int lo, int hi, Distribution distribution) {
    return new IntegerGenerator(lo, hi, distribution);
  }

  /**
   * Create a new integer generator which creates positive integers.
   */
  static Generator<int> positiveIntegers() {
    return positiveIntegersUntil(IntegerGenerator.MAX_VALUE);
  }

  /**
   * Create a new integer generator which creates positive integers than are
   * equal or smaller than high.
   */
  static Generator<int> positiveIntegersUntil(int high) {
    return new IntegerGenerator(1, high);
  }

  /**
   * Create a new byte generator which creates byte values ranging from
   * {@link ByteGenerator#MIN_VALUE} to {@link ByteGenerator#MAX_VALUE}.
   *
   */
  static Generator<int> bytes() => new IntegerGenerator(-128, 127);

  /**
   * Create a new byte generator which creates byte values ranging from lo to
   * hi.
   */
  static Generator<int> bytesForRange(int lo, int hi) {
    return bytesForValues(lo, hi);
  }

  /**
   * Create a new integer generator which creates integers ranging from lo to
   * hi based on the given {@link Distribution}.
   */
  static Generator<int> bytesForValues(int lo, int hi,
      [Distribution distribution]) {
    assert(lo >= -128);
    assert(hi <= 127);
    return new IntegerGenerator(lo, hi, distribution);
  }

  /**
   * Create a new double generator which creates doubles ranging from
   * {@link double#MIN_VALUE} to {@link double#MAX_VALUE}.
   */
  static Generator<double> doubles() {
    return new DoubleGenerator();
  }

  /**
   * Create a new double generator which creates doubles ranging from lo to
   * hi.
   */
  static Generator<double> doublesForRange(double lo, double hi) {
    return new DoubleGenerator(lo, hi);
  }

  /**
   * Create a new double generator which creates doubles ranging from lo to hi
   * based on the given {@link Distribution}.
   */
  static Generator<double> doublesForValues(
      double lo, double hi, Distribution distribution) {
    return new DoubleGenerator(lo, hi, distribution);
  }

  /**
   * Create a generator for boolean values.
   */
  static Generator<bool> booleans() {
    return new FixedValuesGenerator<bool>([true, false]);
  }

  /**
   * Create a generator for null values.
   */
  static Generator<T> nulls<T>() {
    return new FixedValuesGenerator<T>([]);
  }

  /**
   * Create a generator for date values.
   */
  static Generator<DateTime> dates() {
    return datesWithPrecision(DatePrecision.milliseconds);
  }

  /**
   * Create a generator for date values with the given precision.
   */
  static Generator<DateTime> datesWithPrecision(DatePrecision precision) {
    return datesForValues(
        IntegerGenerator.MIN_VALUE, IntegerGenerator.MAX_VALUE, precision);
  }

  /**
   * Create a generator for date values from low to high.
   */
  static Generator<DateTime> datesForRange(int low, int high) {
    return datesForValues(low, high, DatePrecision.milliseconds);
  }

  /**
   * Create a generator for date values from low to high with the given
   * precision.
   */
  static Generator<DateTime> datesForValues(int low, int high,
      [DatePrecision precision]) {
    return new DateGenerator(
      precision,
      low,
      high,
      VetoableGenerator.DEFAULT_MAX_TRIES,
    );
  }

  /**
   * Create a generator for fixed value generator.
   */
  static Generator<T> fixedValuesSingle<T>(T value) {
    return FixedValuesGenerator<T>([value]);
  }

  /**
   * Create a fixed value generator returning one of the values from the
   * values array.
   */
  static Generator<T> fixedValuesFromList<T>(List<T> values) {
    return FixedValuesGenerator(values);
  }

  /**
   * A cloning generator which uses object serialization to create clones of
   * the prototype object. For each call a new copy of the prototype will be
   * generated.
   */
  static Generator<T> clonedValues<T extends Clonable<T>>(T prototype) {
    return new CloningGenerator<T>(prototype);
  }
}