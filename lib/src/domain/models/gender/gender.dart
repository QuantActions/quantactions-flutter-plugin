/// Gender, will be used to provide comparison with healthy peer groups.
enum Gender {
  /// Unknown, the user does not want to disclose this.
  unknown(id: 'unknown'),

  /// Male
  male(id: 'male'),

  /// Female
  female(id: 'female'),

  /// Other
  other(id: 'other');

  const Gender({
    required this.id,
  });

  /// Id of the gender
  final String id;
}
