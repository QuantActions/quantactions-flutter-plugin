import 'dart:convert';

import '../../domain/domain.dart';

class MapperWrapper {
  static T handleErrors<T>({
    required dynamic data,
    required T Function() mapper,
  }) {
    final Map<String, dynamic> map = jsonDecode(data);

    if (map['error'] != null) {
      throw QAError(
        description: map['description'],
        reason: map['reason'],
      );
    }

    try {
      return mapper();
    } catch (e) {
      throw QAError(
        description: e.toString(),
      );
    }
  }
}
