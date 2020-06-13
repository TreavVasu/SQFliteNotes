import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:noteapp/strings.dart' as Const;

///This file marks beginning of DB config
class DataConnection {
  setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_todolist_sqflite');
    var database =
        await openDatabase(path, version: 1, onCreate: _onCreatingDatabase);
    return database;
  }

  var todo = Const.ConstStrings.todoTable;
  _onCreatingDatabase(Database database, int version) async {
    await database.execute(
        "CREATE TABLE categories(id INTEGER PRIMARY KEY, name TEXT , description TEXT)");
    // Table notes here
    await database.execute(
        "CREATE TABLE $todo(id INTEGER PRIMARY KEY,title TEXT,description TEXT,category TEXT,isDone INTEGER)");
  }
}
