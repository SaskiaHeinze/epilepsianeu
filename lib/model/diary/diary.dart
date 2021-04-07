class Diary {
  String id;
  DateTime daySelection;

  Diary({this.id, this.daySelection});

  factory Diary.fromJson(Map<String, dynamic> data) {
    DateTime dateTime = DateTime.parse(data['daySelection']);
    return Diary(
      id: data['id'],
      daySelection: dateTime,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'daySelection': daySelection.toIso8601String(),
    };
  }
}
