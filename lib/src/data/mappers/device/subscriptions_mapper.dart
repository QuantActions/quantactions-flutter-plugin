import 'dart:convert';

import '../../../../quantactions_flutter_plugin.dart';

/// Subscriptions Mapper
class SubscriptionsMapper {
  /// List from a stream
  static List<Subscription> fromList(List<dynamic> list) {
    // if the type of json is a string the we use the first one
    // if (json is String) {
    //   return list.map((dynamic json) => Subscription.fromJson(json as Map<String, dynamic>)).toList();
    // } else {
    //   return list.map((dynamic json) => Subscription.fromJson(jsonDecode(json))).toList();
    // }

    return list.map(checkDynamicType).toList();
  }

  /// Check the dynamic type
  static Subscription checkDynamicType(dynamic json) {
    if (json is String) {
      // android
      return Subscription.fromJson(jsonDecode(json));
    } else {
      // ios
      return Subscription.fromJson(json as Map<String, dynamic>);
    }
  }
}
