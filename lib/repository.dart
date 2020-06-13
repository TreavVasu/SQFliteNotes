import 'package:noteapp/databae_connection.dart';
import 'package:sqflite/sqflite.dart';

class Repository {
  DataConnection _databaseConnection;

  Repository() {
    //Initialise dbconnection
    _databaseConnection = DataConnection();
  }
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _databaseConnection.setDatabase();
    return _database;
  }

  //Inserting Database into Table method
  insertData(table, data) async {
    var connection = await database;
    return await connection.insert(table, data);
  }

  //ReadData From Table
  readData(table) async {
    var connection = await database;
    return await connection.query(table);
  }

  //Read Data by ID
  readDataById(table, itemId) async {
    var connection = await database;
    return await connection.query(table, where: 'id=?', whereArgs: [itemId]);
  }

  //Update Data
  updateDate(table, data) async {
    var connection = await database;
    return await connection
        .update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }

  //Delete Data
  deleteData(table, itemId) async {
    var connection = await database;
    return await connection.rawDelete("DELETE FROM $table WHERE id = $itemId");
  }

  //Read Data By Column Name
  readByColumn(table, columnName, columnValue) async {
    var connection = await database;
    return await connection
        .query(table, where: '$columnName=?', whereArgs: [columnValue]);
  }
}
