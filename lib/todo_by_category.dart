import 'package:flutter/material.dart';
import 'package:noteapp/todo.dart';
import 'package:noteapp/todo_service.dart';

class TodoByCategory extends StatefulWidget {
  final String category;

  const TodoByCategory({Key key, this.category}) : super(key: key);

  @override
  _TodoByCategoryState createState() => _TodoByCategoryState();
}

class _TodoByCategoryState extends State<TodoByCategory> {
  List<Todo> _todoList = List<Todo>();
  TodoService _todoService = TodoService();

  void initState() {
    super.initState();
    getTodoByCategory();
  }

  getTodoByCategory() async {
    print(this.widget.category);
    var todos = await _todoService.readTodoByCategory(this.widget.category);
    todos.forEach((todo) {
      var model = Todo();
      model.title = todo['title'];
      model.description = todo['descrption'];
      model.category = todo['category'];
      model.isDone = todo['isDone'];
      _todoList.add(model);
      print(_todoList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(_todoList[index].title ?? 'No title')
                    ],
                  ),
                  subtitle:
                      Text(_todoList[index].description ?? 'No Description'),
                  trailing: Text(_todoList[index].isDone.toString()),
                ),
              );
            },
            itemCount: _todoList.length,
          ))
        ],
      ),
    );
  }
}
