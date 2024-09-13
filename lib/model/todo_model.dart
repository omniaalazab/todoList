class ToDoModel {
  int? id;
  String? toDoText;
  String? toDoDescription;
  bool? isDone;
  String? category;
  ToDoModel(
      {required this.id,
      required this.toDoText,
      required this.toDoDescription,
      this.category,
      this.isDone = false});

  factory ToDoModel.fromjson(Map<String, dynamic> json) {
    return ToDoModel(
      id: json['id'],
      toDoText: json['toDoText'],
      toDoDescription: json['toDoDescription'],
      category: json['category'],
      isDone: json['isDone'] == 1,
    );
  }
  Map<String, dynamic> tojson() => {
        'id': id,
        'toDoText': toDoText,
        'category': category,
        'toDoDescription': toDoDescription,
        'isDone': isDone == true ? 1 : 0,
      };
}
