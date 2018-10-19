// File created by
// Lung Razvan <long1eu>
// on 19/09/2018

import 'package:dart_quickcheck/src/generator.dart';
import 'package:dart_quickcheck/src/generator/support/integer_generator.dart';
import 'package:dart_quickcheck/src/generator/support/vetoable_generator.dart';

class DatePrecision {
  final Duration _d;

  static const DatePrecision days = DatePrecision._(Duration(days: 1));
  static const DatePrecision hours = DatePrecision._(Duration(hours: 1));
  static const DatePrecision microseconds =
      DatePrecision._(Duration(microseconds: 1));
  static const DatePrecision milliseconds =
      DatePrecision._(Duration(milliseconds: 1));
  static const DatePrecision minutes = DatePrecision._(Duration(minutes: 1));
  static const DatePrecision seconds = DatePrecision._(Duration(seconds: 1));

  const DatePrecision._(this._d);

  int get duration => _d.inMilliseconds;
}

class DateGenerator implements Generator<DateTime> {
  VetoableGenerator<int> generator;

  DateGenerator(DatePrecision precision, int low, int high, int tries) {
    generator = VetoableGenerator<int>(
      new _MillisGenerator(precision, low, high),
      (value) => value != null,
      tries,
    );
  }

  @override
  DateTime next() => new DateTime(generator.next());
}

class _MillisGenerator implements Generator<int> {
  final int precision;
  final IntegerGenerator times;
  final int low;
  final int high;

  _MillisGenerator(DatePrecision precision, this.low, this.high)
      : precision = precision.duration,
        times = IntegerGenerator(low, high);

  @override
  int next() {
    int millis = times.next() ~/ precision * precision;
    return _isOutOffBounds(millis) || _isOverflow(millis, millis)
        ? null
        : millis;
  }

  bool _isOutOffBounds(int correctedMillis) {
    return correctedMillis < low || correctedMillis > high;
  }

  // TODO define this differently (signum changes near 0 without overflow)
  bool _isOverflow(int millis, int correctedMillis) {
    return signum(correctedMillis) != signum(millis);
  }

  int signum(int millis) => millis == 0 ? 0 : millis > 0 ? 1 : -1;
}
