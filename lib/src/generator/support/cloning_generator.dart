// File created by
// Lung Razvan <long1eu>
// on 19/09/2018

import 'package:dart_quickcheck/src/generator.dart';

abstract class Clonable<T> {
  T clone();
}

class CloningGenerator<T> implements Generator<T> {
  final Clonable<T> prototype;

  const CloningGenerator(this.prototype);

  @override
  T next() => prototype.clone();
}
