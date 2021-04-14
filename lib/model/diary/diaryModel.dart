class Diary {
  String id;
  DateTime daySelection;

  Diary({this.id, this.daySelection});

  ///Erhaltene Daten werden aus JSON extrahiert
  factory Diary.fromJson(Map<String, dynamic> data) {
    DateTime dateTime = DateTime.parse(data['daySelection']);
    return Diary(
      id: data['id'],
      daySelection: dateTime,
    );
  }

  ///Daten Werden in JSON geschrieben
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'daySelection': daySelection.toIso8601String(),
    };
  }
}
