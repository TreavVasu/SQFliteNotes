import 'package:flutter/material.dart';
import 'package:noteapp/category.dart';
import 'package:noteapp/category_service.dart';
import 'package:noteapp/home.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  TextEditingController _controllerCategory = TextEditingController();
  TextEditingController _controllerDescription = TextEditingController();
  TextEditingController _editControllerCategory = TextEditingController();
  TextEditingController _editControllerDescription = TextEditingController();

  CategoryService categoryService = CategoryService();
  CategoryStore categoryStore = CategoryStore();
  var categoryStoreTemp;
  List<CategoryStore> _categoryList = List<CategoryStore>();

  @override
  void initState() {
    super.initState();
    getAllCategories();
  }

  getAllCategories() async {
    _categoryList = List<CategoryStore>();
    var categories = await categoryService.readCategories();

    categories.forEach((category) {
      setState(() {
        var categoryModel = CategoryStore();
        categoryModel.title = category['name'];
        categoryModel.description = category['description'];
        categoryModel.id = category['id'];
        _categoryList.add(categoryModel);
        print(_categoryList);
      });
    });
  }

  _editCategory(BuildContext context, categoryId) async {
    var categoryStoreTemp = await categoryService.readCategoryById(categoryId);
    setState(() {
      _editControllerCategory.text = categoryStoreTemp[0]['name'] ?? 'No Name';
      _editControllerDescription.text =
          categoryStoreTemp[0]['description'] ?? 'No Desc is given';
    });
    _editFormDialog(context, categoryId);
  }

  _showFormDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
                color: Colors.red,
              ),
              FlatButton(
                onPressed: () async {
                  categoryStore.title = _controllerCategory.text;
                  categoryStore.description = _controllerDescription.text;
                  var result =
                      await categoryService.saveCategory(categoryStore);
                  if (result > 0) {
                    print(result);
                    Navigator.pop(context);
                  }
                },
                child: Text('Save'),
                color: Colors.blue,
              ),
            ],
            title: Text('Categories Form'),
            content: SingleChildScrollView(
              child: Column(children: <Widget>[
                TextField(
                  controller: _controllerCategory,
                  decoration: InputDecoration(
                    hintText: 'Write a Category',
                    labelText: 'Category',
                  ),
                ),
                TextField(
                  controller: _controllerDescription,
                  decoration: InputDecoration(
                    hintText: 'Write a description',
                    labelText: 'Description',
                  ),
                )
              ]),
            ),
          );
        });
  }

  _deleteFormDialog(BuildContext context, categoryId) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
                color: Colors.green,
              ),
              FlatButton(
                onPressed: () async {
                  var result = await categoryService.deleteCategory(categoryId);

                  if (result > 0) {
                    print(result);
                    Navigator.pop(context);
                    getAllCategories();
                  }
                },
                child: Text('Delete'),
                color: Colors.red,
              ),
            ],
            title: Text('Are you sure?'),
          );
        });
  }

  _editFormDialog(BuildContext context, categoryId) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
                color: Colors.red,
              ),
              FlatButton(
                onPressed: () async {
                  categoryStore.id = categoryId;
                  categoryStore.title = _editControllerCategory.text;
                  categoryStore.description = _editControllerDescription.text;
                  var result =
                      await categoryService.updateCategory(categoryStore);
                  if (result > 0) {
                    print(result);
                    Navigator.pop(context);
                    getAllCategories();
                  }
                },
                child: Text('Update'),
                color: Colors.blue,
              ),
            ],
            title: Text('Edit Categories Form'),
            content: SingleChildScrollView(
              child: Column(children: <Widget>[
                TextField(
                  controller: _editControllerCategory,
                  decoration: InputDecoration(
                    hintText: 'Write a Category',
                    labelText: 'Edit Category',
                  ),
                ),
                TextField(
                  controller: _editControllerDescription,
                  decoration: InputDecoration(
                    hintText: 'Write a description',
                    labelText: 'Edit Description',
                  ),
                )
              ]),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: RaisedButton(
          color: Colors.blue,
          elevation: 0.0,
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => HomeScreen())),
          child: Icon(Icons.arrow_back),
        ),
        title: Text('Category'),
      ),
      body: ListView.builder(
          itemCount: _categoryList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 8.0,
                child: ListTile(
                  leading: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        _editCategory(context, _categoryList[index].id);
                      }),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(_categoryList[index].title),
                      IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            _deleteFormDialog(context, _categoryList[index].id);
                          }),
                    ],
                  ),
                  subtitle: Text(
                    _categoryList[index].description,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showFormDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
