class Diary {
  String id;
  DateTime tagesauswahl;

  Diary({this.id, this.tagesauswahl});

  factory Diary.fromJson(Map<String, dynamic> data) {
    DateTime dateTime = DateTime.parse(data['tagesauswahl']);
    return Diary(
      id: data['id'],
      tagesauswahl: dateTime,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tagesauswahl': tagesauswahl.toIso8601String(),
    };
  }
}
