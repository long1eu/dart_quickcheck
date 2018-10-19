// File created by
// Lung Razvan <long1eu>
// on 19/09/2018

import 'package:dart_quickcheck/src/characteristic.dart';
import 'package:dart_quickcheck/src/characteristic_error.dart';
import 'package:dart_quickcheck/src/generator.dart';
import 'package:dart_quickcheck/src/generator_error.dart';
import 'package:dart_quickcheck/src/quick_check.dart';
import 'package:dart_quickcheck/src/runner.dart';
import 'package:dart_quickcheck/src/util/util.dart';

import 'guard_error.dart';

class RunnerImpl<T> implements Runner<T> {
  int maxRuns;
  int currentRuns;
  int runs;
  StringBuffer writer;
  Characteristic<T> characteristic;
  Generator<T> generator;

  RunnerImpl(this.characteristic, int runs, this.generator, this.writer) {
    _setRuns(runs);
  }

  @override
  void forAll() {
    Assert.notNull(characteristic, "characteristic");
    Assert.notNull(generator, "generator");
    for (int count = 0; count < runs; count++) {
      try {
        _doSetup();
        _check(generator);
      } finally {
        _doTearDown();
      }
    }
  }

  void _check(Generator<T> generator) {
    Assert.notNull(generator, "generator");

    while (currentRuns < maxRuns) {
      currentRuns++;
      T value = generator.next();
      _printCurrentValue(currentRuns, value);
      try {
        characteristic.specify(value);
        return;
      } on GuardError catch (e) {
        _print("$currentRuns: skipped [$value]");
      } catch (e) {
        _throwFailedException(value, e, characteristic, currentRuns);
      }
    }
    String message =
        "Generator max tries ($maxRuns) reached. Check your guard expressions.";
    throw GeneratorError<T>(message, generator);
  }

  static int getMaxGeneratorTries(int maxRuns) {
    return maxRuns * 10;
  }

  void _doTearDown() {
    try {
      characteristic.tearDown();
    } catch (e) {
      throw CharacteristicError("teardown failed", e, characteristic);
    }
  }

  void _doSetup() {
    try {
      characteristic.setUp();
    } catch (e) {
      throw new CharacteristicError("setup failed", e, characteristic);
    }
  }

  void _print(String msg) {
    print(writer.toString());
    writer.clear();
  }

  void _printCurrentValue(int currentRuns, T value) {
    _print('$currentRuns:[$value]');
  }

  void _throwFailedException(
      T value, Error e, Characteristic<T> characteristic, int currentRuns) {
    String characteristicName =
        characteristic.name == null ? "" : characteristic.name;
    String message =
        "Characteristic $characteristicName is not true for value(# $currentRuns):[$value] message: >$e<";

    _print(message);
    throw new CharacteristicError(message, e, characteristic, value);
  }

  void _setRuns(int runs) {
    Assert.greaterOrEqual(QuickCheck.MIN_NUMBER_OF_RUNS, runs, "runs");
    maxRuns = 10 * runs;
    this.runs = runs;
  }
}
