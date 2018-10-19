// File created by
// Lung Razvan <long1eu>
// on 19/09/2018

import 'package:dart_quickcheck/src/collection/pair.dart';

/**
 * Gather frequency information about test values.
 * <p>
 * {@link Classification}s are used to categories test cases. While
 * {@link Characteristic#specify(Object)} is executed characteristic instances
 * can add classifications with
 * {@link Classification#doClassify(boolean, Object)}. For each execution of
 * {@link Characteristic#specify(Object)} {@link Classification#call()} has to
 * be executed once.
 * </p>
 */
class Classification {
  final Map<Object, int> classifications = new Map<Object, int>();
  int _total;
  bool _reportState;

  // derived value
  Map<Object, double> _classifiedWithPercents;

  // derived value
  List<Object> _sortedCategories;

  /**
   * Get the frequency of the given category.
   *
   * @return per cent of test cases with this classification.
   */
  double getFrequency(Object classification) {
    __reportState();
    double frequency = _getClassified()[classification];
    return frequency == null ? 0 : frequency;
  }

  /**
   * Get a list of known categories. Categories are sorted in descending
   * frequency.
   */
  List<Object> getCategories() {
    __reportState();
    if (_sortedCategories == null) {
      List<Pair<Object, double>> toSort = _buildCategoryFrequencyList();
      _sortByFrequency(toSort);
      _sortedCategories = _transFormPairListToCategoryList(toSort);
    }
    return _sortedCategories;
  }

  /**
   * {@inheritDoc}
   */
  @override
  String toString() {
    StringBuffer builder = new StringBuffer();
    Map<Object, double> classified = _getClassified();
    builder.write("Classifications :");
    List<Object> categories = getCategories();
    for (Object key in categories) {
      builder.write("\n$key = ${classified[key].toStringAsFixed(2)}");
    }
    if (classified.isEmpty) {
      builder.write("none");
    }
    return builder.toString();
  }

  /**
   * Increment the classification counter for the given classification.
   *
   * @param predicate
   *            increment only if the predicate is true.
   * @param classification
   *            classification key
   */
  void doClassify(Object classification, [bool predicate = true]) {
    _checkReportState();
    if (!predicate) return;
    bool categoryFound = classifications.containsKey(classification);
    int current = categoryFound ? classifications[classification] : 0;
    classifications[classification] = ++current;
  }

  /**
   * Count the number of calls.
   */
  void call() {
    _checkReportState();
    _total++;
  }

  Map<Object, double> _getClassified() {
    if (_classifiedWithPercents == null) {
      _classifiedWithPercents = new Map<Object, double>();
      for (Object key in classifications.keys) {
        int count = classifications[key];
        double percent = count * 100 / _total;
        _classifiedWithPercents[key] = percent;
      }
    }
    return _classifiedWithPercents;
  }

  void __reportState() {
    _reportState = true;
  }

  List<Pair<Object, double>> _buildCategoryFrequencyList() {
    Map<Object, double> classified = _getClassified();
    List<Pair<Object, double>> toSort = new List<Pair<Object, double>>();
    for (MapEntry<Object, double> e in classified.entries) {
      toSort.add(new Pair<Object, double>(e.key, e.value));
    }
    return toSort;
  }

  List<Object> _transFormPairListToCategoryList(
      List<Pair<Object, double>> toSort) {
    List<Object> sortedCategoryList = new List<Object>();
    for (Pair<Object, double> pair in toSort) {
      sortedCategoryList.add(pair.first);
    }
    return sortedCategoryList;
  }

  void _sortByFrequency(List<Pair<Object, double>> toSort) {
    toSort.sort((o1, o2) => o2.second.compareTo(o1.second));
  }

  // this is the easiest implementation report calculation can be resource
  // demanding
  void _checkReportState() {
    if (_reportState)
      throw new StateError("do not call after report was started.");
  }

  void classifyCall(Object classification, [bool predicate = true]) {
    doClassify(classification, predicate);
    call();
  }
}
