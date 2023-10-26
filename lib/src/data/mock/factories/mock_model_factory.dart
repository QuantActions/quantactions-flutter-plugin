import 'package:faker/faker.dart';

abstract class MockModelFactory<T> {
  Faker get faker => Faker();

  T generateFake([dynamic data]);

  List<T> generateListFake({required int length});

  String get generateId => faker.randomGenerator.fromCharSet('1234567890', 10);

  DateTime get generateDateTime => faker.date.dateTime(
        minYear: 1990,
        maxYear: DateTime.now().year,
      );

  double get generateDouble => faker.randomGenerator.decimal(scale: 100);
}
