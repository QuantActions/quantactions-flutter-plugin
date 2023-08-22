enum Gender {
  unknown(id: 'unknown'),
  male(id: 'male'),
  female(id: 'female'),
  other(id: 'other');

  const Gender({
    required this.id,
  });

  final String id;
}
