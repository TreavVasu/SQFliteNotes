import 'package:flutter/material.dart';
import 'package:noteapp/drawer.dart';
import 'package:noteapp/todo.dart';
import 'package:noteapp/todo_screen.dart';
import 'package:noteapp/todo_service.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HomeScreen();
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TodoService _todoService;

  List<Todo> _listTodo = List<Todo>();

  @override
  initState() {
    super.initState();
    getAllTodos();
  }

  getAllTodos() async {
    _todoService = TodoService();
    _listTodo = List<Todo>();
    var todos = await _todoService.readTodo();
    todos.forEach((notes) {
      setState(() {
        var model = Todo();
        model.id = notes['id'];
        model.title = notes['title'];
        model.description = notes['description'];
        model.category = notes['category'];
        model.isDone = notes['isDone'];
        _listTodo.add(model);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TodoList"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(_listTodo[index].title ?? 'No title')
                  ],
                ),
                subtitle:
                    Text(_listTodo[index].description ?? 'No Description'),
                trailing: Text(_listTodo[index].isDone.toString()),
              ),
            ),
          );
        },
        itemCount: _listTodo.length,
      ),
      drawer: DrawerNavigation(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => TodoScreen())),
        child: Icon(Icons.add),
      ),
    );
  }
}
