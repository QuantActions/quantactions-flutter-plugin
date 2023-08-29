import 'package:faker/faker.dart';

abstract class MockModelFactory<T> {
  Faker get faker => Faker();

  T generateFake();

  List<T> generateListFake({
    required int length,
  });
}
