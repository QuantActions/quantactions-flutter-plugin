import 'package:sugar/sugar.dart';

class AverageMapper {
  static int getListAverageInt(List<int> values) {
    if (values.isEmpty) return 0;

    return (values.reduce((int a, int b) => a + b) / values.length).round();
  }

  static double getListAverageDouble(List<double> values) {
    if (values.isEmpty) return double.nan;

    final List<double> listWithoutNaNValues = <double>[];
    for (int i = 0; i < values.length; i++) {
      if (values[i].isNaN) continue;

      listWithoutNaNValues.add(values[i]);
    }

    return listWithoutNaNValues.isEmpty
        ? double.nan
        : listWithoutNaNValues.reduce((double a, double b) => a + b) / listWithoutNaNValues.length;
  }
}


extension ZonedDateTimeNaN on ZonedDateTime {
  ZonedDateTime get nan => ZonedDateTime.fromEpochMilliseconds(Timezone('UTC'), 0);
}


