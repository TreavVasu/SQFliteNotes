class Todo {
  int id;
  String title;
  String description;
  String category;
  int isDone;

  todoMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['category'] = category;
    map['isDone'] = isDone;
    return map;
  }
}
