class StudyModel {
  final int? id;
  final String title;

  StudyModel({
    this.id,
    required this.title,
  });
  Map<String, dynamic> toMap() {
    return ({
      "id": id,
      "title": title,
    });
  }

  @override
  String toString() {
    return 'StudyModel{id: $id, title: $title}';
  }
}
