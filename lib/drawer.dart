import 'package:flutter/material.dart';
import 'package:noteapp/category_service.dart';
import 'package:noteapp/home.dart';
import 'package:noteapp/todo_by_category.dart';

import 'category_screen.dart';

class DrawerNavigation extends StatefulWidget {
  @override
  _DrawerNavigationState createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  List<Widget> _categoryList = List<Widget>();
  CategoryService _categoryService = CategoryService();

  initState() {
    super.initState();
    getAllCategories();
  }

  getAllCategories() async {
    var categories = await _categoryService.readCategories();
    categories.forEach((category) {
      setState(() {
        _categoryList.add(InkWell(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TodoByCategory(
                        category: category['name'],
                      ))),
          child: ListTile(
            leading: Icon(Icons.description),
            title: Text(category['name']),
          ),
        ));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('college.png'),
              ),
              accountName: Text("Vasu Soni"),
              accountEmail: Text("write2treav@gmail.com"),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomeScreen())),
            ),
            ListTile(
              leading: Icon(Icons.calendar_view_day),
              title: Text("Category"),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Category())),
            ),
            Divider(),
            Column(
              children: _categoryList,
            )
          ],
        ),
      ),
    );
  }
}
