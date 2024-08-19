import 'package:dartx/dartx.dart';

import '../../../../quantactions_flutter_plugin.dart';

/// Metric type, generic class for all metrics
abstract class MetricType {
  /// Constructor
  const MetricType(
      {required this.id, required this.code, this.eta, this.populationRange});

  /// Unique identifier for the metric type
  final String id;

  /// Code for the metric type
  final String code;

  /// Estimated time of arrival in days (how long before the first estimate)
  final int? eta;

  /// Population range for the metric type
  final PopulationRange? populationRange;
}

/// Range for a metric
class Range {
  /// 25th percentile
  final double low;

  /// 75th percentile
  final double high;

  /// Constructor
  const Range(this.low, this.high);
}

/// Range for all age groups for a specific sex group
class SexRange {
  /// < 30 years
  final Range young;

  /// 30-50 years
  final Range mid;

  /// > 50 years
  final Range old;

  /// Constructor
  const SexRange(this.young, this.mid, this.old);

  /// Get the 25th percentile for a specific year of birth
  double getLow(int yearOfBirth) {
    final int age = DateTime.now().year - yearOfBirth;
    if (age <= 30) {
      return young.low;
    } else if (age <= 50) {
      return mid.low;
    } else {
      return old.low;
    }
  }

  /// Get the 75th percentile for a specific year of birth
  double getHigh(int yearOfBirth) {
    final int age = DateTime.now().year - yearOfBirth;
    if (age <= 30) {
      return young.high;
    } else if (age <= 50) {
      return mid.high;
    } else {
      return old.high;
    }
  }
}

/// Range for the whole population
class PopulationRange {
  /// Range for the whole population
  final Range global;

  /// Range for the male population
  final Range globalMale;

  /// Range for the female population
  final Range globalFemale;

  /// Range for male population stratified by age group
  final SexRange male;

  /// Range for female population stratified by age group
  final SexRange female;

  /// Range for other population stratified by age group
  final SexRange other;

  /// Constructor
  const PopulationRange({
    required this.global,
    required this.globalMale,
    required this.globalFemale,
    required this.male,
    required this.female,
    required this.other,
  });

  /// Get the population range for a specific year of birth and gender
  Pair<int, int> getPopulationRange(
      {int yearOfBirth = 0, Gender gender = Gender.unknown}) {
    return Pair<int, int>(
        getLow(yearOfBirth: yearOfBirth, gender: gender).round(),
        getHigh(yearOfBirth: yearOfBirth, gender: gender).round());
  }

  /// Get the 25th percentile for a specific year of birth and gender
  double getLow({int yearOfBirth = 0, Gender gender = Gender.unknown}) {
    if (yearOfBirth == 0) {
      switch (gender) {
        case Gender.male:
          return globalMale.low;
        case Gender.female:
          return globalFemale.low;
        default:
          return global.low;
      }
    }
    switch (gender) {
      case Gender.male:
        return male.getLow(yearOfBirth);
      case Gender.female:
        return female.getLow(yearOfBirth);
      default:
        return other.getLow(yearOfBirth);
    }
  }

  /// Get the 75th percentile for a specific year of birth and gender
  double getHigh({int yearOfBirth = 0, Gender gender = Gender.unknown}) {
    if (yearOfBirth == 0) {
      switch (gender) {
        case Gender.male:
          return globalMale.high;
        case Gender.female:
          return globalFemale.high;
        default:
          return global.high;
      }
    }
    switch (gender) {
      case Gender.male:
        return male.getHigh(yearOfBirth);
      case Gender.female:
        return female.getHigh(yearOfBirth);
      default:
        return other.getHigh(yearOfBirth);
    }
  }
}
