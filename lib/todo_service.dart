import 'package:noteapp/repository.dart';
import 'package:noteapp/strings.dart' as C;
import 'package:noteapp/todo.dart';

class TodoService {
  Repository _repository;
  TodoService() {
    _repository = Repository();
  }

  //Save TODOs
  saveTodo(Todo todo) async {
    return await _repository.insertData('todo', todo.todoMap());
  }

  //Read TODOs
  readTodo() async {
    return await _repository.readData(C.ConstStrings.todoTable);
  }

  //Read Todos By Category
  readTodoByCategory(category) async {
    return await _repository.readByColumn(
        C.ConstStrings.todoTable, 'category', category);
  }
}
