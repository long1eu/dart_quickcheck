// File created by
// Lung Razvan <long1eu>
// on 19/09/2018

import 'package:dart_quickcheck/src/characteristic.dart';

/**
 * Indicates that a characteristic specification was not true for a given
 * instance.
 */
class CharacteristicError<T> extends StateError {
  final Object instance;
  final Error error;
  final Characteristic<T> charateristic;

  CharacteristicError(String message, this.error, this.charateristic,
      [this.instance])
      : super(message);
}
