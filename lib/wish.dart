class Wish {
  final int? id;
  final String title;
  final String date;
  final String importance;

  Wish({this.id, required this.title, required this.date, required this.importance});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date': date,
      'importance': importance,
    };
  }

  factory Wish.fromMap(Map<String, dynamic> map) {
    return Wish(
      id: map['id'],
      title: map['title'],
      date: map['date'],
      importance: map['importance'],
    );
  }
}
