import 'package:flutter/material.dart';
import 'package:noteapp/category_service.dart';
import 'package:noteapp/todo.dart';
import 'package:noteapp/todo_service.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  TextEditingController todoControllerTitle = TextEditingController();
  TextEditingController todoControllerDescription = TextEditingController();
  TextEditingController todoControllerDate = TextEditingController();

  var _selectedValues;

  var _catagories = List<DropdownMenuItem>();

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  _loadCategories() async {
    var _categoryService = CategoryService();
    var categories = await _categoryService.readCategories();
    categories.forEach((category) {
      setState(() {
        _catagories.add(DropdownMenuItem(
          child: Text(category['name']),
          value: category['name'],
        ));
      });
    });
  }

  _showSnackBar(message) {
    var _snackBar = SnackBar(content: message);
    _globalKey.currentState.showSnackBar(_snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text("Create Note"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: todoControllerTitle,
              decoration: InputDecoration(
                labelText: 'Title',
                hintText: 'Write Todo Title',
              ),
            ),
            TextField(
              controller: todoControllerDescription,
              decoration: InputDecoration(
                labelText: 'Description',
                hintText: 'Write Todo Description',
              ),
            ),
            /*
            TextField(
              controller: todoControllerDate,
              decoration: InputDecoration(
                labelText: 'Time',
                hintText: 'Pick a Date!',
                prefixIcon: InkWell(
                  onTap: () {},
                  child: Icon(Icons.calendar_today),
                ),
              ),
            ),*/
            DropdownButtonFormField(
                items: _catagories,
                value: _selectedValues,
                hint: Text("Categories"),
                onChanged: (value) {
                  setState(() {
                    _selectedValues = value;
                  });
                }),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              onPressed: () async {
                var todoObject = Todo();
                todoObject.title = todoControllerTitle.text;
                todoObject.description = todoControllerDescription.text;
                todoObject.isDone = 0;
                todoObject.category = _selectedValues.toString();

                var _todoService = TodoService();
                var result = await _todoService.saveTodo(todoObject);
                print(result);
                if (result > 0) {
                  _showSnackBar(Text("Created"));
                }
              },
              color: Colors.blue,
              child: Text('Save'),
            )
          ],
        ),
      ),
    );
  }
}
