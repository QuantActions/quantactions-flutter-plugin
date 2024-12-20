import 'package:faker/faker.dart';

/// Abstract class for generating fake data for models.
abstract class MockModelFactory<T> {
  /// Instance of [Faker] for generating fake data.
  Faker get faker => Faker();

  /// Generates a fake instance of [T].
  T generateFake([dynamic data]);

  /// Generates a list of fake instances of [T].
  List<T> generateListFake({required int length});

  /// Generates a random ID.
  String get generateId => faker.randomGenerator.fromCharSet('1234567890', 10);

  /// Generates a random [DateTime] between 2 years ago and now.
  DateTime get generateDateTime => faker.date.dateTime(
        minYear: DateTime.now().year - 2,
        maxYear: DateTime.now().year,
      );

  /// Generates a random [double] between 0 and 100.
  double get generateDouble => faker.randomGenerator.decimal(scale: 100);
}
