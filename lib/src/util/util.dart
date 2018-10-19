// File created by
// Lung Razvan <long1eu>
// on 19/09/2018

class Assert {
  static const String MISSING = "MISSING";

  Assert._();

  static void notNull(Object arg, String argName) {
    if (arg == null) {
      throw new ArgumentError(
          "Argument ${caption(argName)} expected to be not null");
    }
  }

  /// Only strings and lists
  static void notEmpty(dynamic arg, String argName) {
    if (arg.isEmpty) {
      throw new ArgumentError(
          "String ${caption(argName)} expected to be not empty");
    }
  }

  static void lessOrEqual(num threshold, num arg, String argName) {
    if (arg > threshold) {
      throw new ArgumentError(
          "Value ${value(arg)} of argument ${caption(argName)} expected to be not greater than ${value(threshold)}");
    }
  }

  static void equal(num expected, num arg, String argName) {
    if (arg != expected) {
      throw new ArgumentError(
          "Value ${value(arg)} of argument ${caption(argName)} expected to be not equal to ${value(expected)}");
    }
  }

  static void greaterOrEqual(num threshold, num arg, String argName) {
    if (arg < threshold) {
      throw new ArgumentError(
          'Value ${value(arg)} of argument ${caption(argName)} expected to be not less than ${value(threshold)}');
    }
  }

  static String caption(Object obj) {
    return "[" + (obj == null ? MISSING : obj) + "]";
  }

  static String value(Object value) {
    return "<" + (value == null ? MISSING : value) + ">";
  }
}
