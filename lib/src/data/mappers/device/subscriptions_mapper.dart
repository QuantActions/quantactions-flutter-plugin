import '../../../../qa_flutter_plugin.dart';

class SubscriptionsMapper {
  static List<Subscription> fromList(List<dynamic> list) {
    return list.map((dynamic json) => Subscription.fromJson(json as Map<String, dynamic>)).toList();
  }
}
