import 'package:flutter/material.dart';
import 'package:flutter_application_1/employee.dart';
import 'package:flutter_application_1/supplier.dart';
import 'package:flutter_application_1/Customer.dart';
import 'package:flutter_application_1/User.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Category Screen',
      home: Manage(),
    );
  }
}

class Manage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: Colors.black),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Row(
          children: [
            _buildNavButton(context, 'Users', ManageCategoryPage(title: 'Users')),
            _buildNavButton(context, 'Customers', ManageCategoryPage(title: 'Customers')),
            _buildNavButton(context, 'Suppliers', ManageCategoryPage(title: 'Suppliers')),
          ],
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.notifications),
                color: Colors.black,
                onPressed: () {},
              ),
              Positioned(
                right: 4,
                top: 4,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '3',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 16),
          Text(
            'Tarinya Perera',
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(width: 16),
          CircleAvatar(
            backgroundColor: Colors.brown,
            child: Text(
              'T',
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(width: 16),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.people,
                    color: Colors.white,
                    size: 40,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'DEPARTMENT',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text('All'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.admin_panel_settings),
              title: Text('Painting'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.admin_panel_settings),
              title: Text('Casting'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: ManageCategoryPage(title: 'Employees'),
    );
  }

  Widget _buildNavButton(BuildContext context, String title, Widget page) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        child: Text(
          title,
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}

class ManageCategoryPage extends StatelessWidget {
  final String title;

  ManageCategoryPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => _navigateToNewPage(title),
                      ),
                    );
                  },
                  child: Text(
                    'New',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyle(fontSize: 20),
                ),
                Spacer(),
                Container(
                  width: 200,
                  child: TextField(
                    onSubmitted: (value) {
                      // Implement search functionality here
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    SizedBox(width: 20),
                    Tooltip(
                      message: 'Edit',
                      child: IconButton(
                        icon: Icon(Icons.edit_note),
                        onPressed: () {},
                      ),
                    ),
                    Tooltip(
                      message: 'Update',
                      child: IconButton(
                        icon: Icon(Icons.update),
                        onPressed: () {},
                      ),
                    ),
                    Tooltip(
                      message: 'Delete',
                      child: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Registered $title',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _navigateToNewPage(String title) {
    switch (title) {
      case 'Employees':
        return RegisterEmployee();
      case 'Users':
        return RegisterUser();
      case 'Customers':
        return RegisterCustomer();
      case 'Suppliers':
        return RegisterSupplier();
      default:
        return ManageCategoryPage(title: title);
    }
  }
}
