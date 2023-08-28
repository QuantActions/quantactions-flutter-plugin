import '../gender/gender.dart';

class BasicInfo {
  final int yearOfBirth;
  final Gender gender;
  final bool selfDeclaredHealthy;

  BasicInfo({
    required this.yearOfBirth,
    required this.gender,
    required this.selfDeclaredHealthy,
  });
}
