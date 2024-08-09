import 'package:flutter/material.dart';
import 'package:flutter_application_1/login.dart';
import 'dart:ui';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Panel(),
    );
  }
}

class Panel extends StatefulWidget {
  @override
  _PanelState createState() => _PanelState();
}

class _PanelState extends State<Panel> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getSelectedView() {
    switch (_selectedIndex) {
      case 0:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.home, size: 100, color: Colors.blue),
              SizedBox(height: 20),
              Text(
                'Home',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      case 1:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.dashboard, size: 100, color: Colors.green),
              SizedBox(height: 20),
              Text(
                'Dashboard',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      case 2:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.account_circle, size: 100, color: Colors.orange),
              SizedBox(height: 20),
              Text(
                'Account',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      default:
        return Center(child: Text('Unknown View'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/panel_wallpaper.jpeg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  color: Colors.white.withOpacity(0.3), // glass effect
                  child: Row(
                    children: [
                      // Left panel
                      Container(
                        width: constraints.maxWidth * 0.25, // Responsive width
                        color: Colors.grey[200]?.withOpacity(0.5), // glass effect
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Larger logo
                            CircleAvatar(
                              radius: 50, // Increased size
                              backgroundImage: AssetImage('images/logo.jpg'),
                            ),
                            Divider(color: Colors.black, thickness: 2), // Darker divider
                            // Home button
                            ListTile(
                              leading: Icon(Icons.home),
                              title: Text('Home'),
                              onTap: () {
                                _onItemTapped(0); // Navigate to Home view
                              },
                            ),
                            Divider(color: Colors.black, thickness: 2), // Darker divider
                            // Dashboard button
                            ListTile(
                              leading: Icon(Icons.dashboard),
                              title: Text('Dashboard'),
                              onTap: () {
                                _onItemTapped(1); // Navigate to Dashboard view
                              },
                            ),
                            Divider(color: Colors.black, thickness: 2), // Darker divider
                            // Account button
                            ListTile(
                              leading: Icon(Icons.account_circle),
                              title: Text('Account'),
                              onTap: () {
                                _onItemTapped(2); // Navigate to Account view
                              },
                            ),
                            Divider(color: Colors.black, thickness: 2), // Darker divider
                            // Log out button at the bottom
                            ListTile(
                              leading: Icon(Icons.logout),
                              title: Text('Log out'),
                              onTap: () {
                                // Navigate to Login screen
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => SignInScreen()),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      // Main content area
                      Expanded(
                        child: Container(
                          color: Colors.white.withOpacity(0.5), //glass effect
                          child: _getSelectedView(), // Display the selected view
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
