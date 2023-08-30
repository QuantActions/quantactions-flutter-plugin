class JournalEvent {
  final String id;
  final String publicName;
  final String iconName;
  final DateTime created;
  final DateTime modified;

  JournalEvent({
    required this.id,
    required this.publicName,
    required this.iconName,
    required this.created,
    required this.modified,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "id": id,
      "publicName": publicName,
      "iconName": iconName,
      "created": created.millisecondsSinceEpoch,
      "modified": modified.millisecondsSinceEpoch,
    };
  }
}
