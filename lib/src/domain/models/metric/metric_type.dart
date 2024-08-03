import 'package:dartx/dartx.dart';

import '../../../../quantactions_flutter_plugin.dart';

abstract class MetricType {
  const MetricType({
    required this.id,
    required this.code,
    this.eta,
    this.populationRange
  });

  final String id;
  final String code;
  final int? eta;
  final PopulationRange? populationRange;
}

class Range {
  final double low;
  final double high;

  const Range(this.low, this.high);
}

class SexRange {
  final Range young;
  final Range mid;
  final Range old;

  const SexRange(this.young, this.mid, this.old);

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

class PopulationRange {
  final Range global;
  final Range globalMale;
  final Range globalFemale;
  final SexRange male;
  final SexRange female;
  final SexRange other;

  const PopulationRange({
    required this.global,
    required this.globalMale,
    required this.globalFemale,
    required this.male,
    required this.female,
    required this.other,
  });

  Pair<int, int> getPopulationRange(
      {int yearOfBirth = 0, Gender gender = Gender.unknown}) {
    return Pair(getLow(yearOfBirth: yearOfBirth, gender: gender).round(),
        getHigh(yearOfBirth: yearOfBirth, gender: gender).round());
  }

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
