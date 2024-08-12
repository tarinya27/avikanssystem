import 'package:flutter/material.dart';
import 'dart:ui'; // Required for the glassmorphism effect

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Dashboard(role: 'admin'), // Change the role here for testing
    );
  }
}

class Dashboard extends StatefulWidget {
  final String role;

  Dashboard({required this.role});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onButtonPressed(String label) {
    if ((widget.role == 'supervisor' || widget.role == 'user') && label == 'Profit & Performances') {
      _showPermissionWarning();
    } else {
      // Handle the button press for other roles or buttons
      print('$label button pressed');
    }
  }

  void _showPermissionWarning() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Permission Denied'),
          content: Text('You do not have permission to access this feature.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  bool canViewCheckPoints(String role) {
    // Define permissions based on role
    return role == 'admin' || role == 'supervisor' || role == 'user';
  }

  bool canViewStatus(String role) {
    // Define permissions based on role
    return role == 'admin' || role == 'supervisor' || role == 'user';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/Admin_dash.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Glassmorphism Effect for the whole screen
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      width: 1.5,
                      color: Colors.white.withOpacity(0.2),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Appbar with the glassmorphism effect
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () => _onItemTapped(0),
                                child: Column(
                                  children: [
                                    Text(
                                      'Dashboard',
                                      style: TextStyle(
                                        color: _selectedIndex == 0 ? Colors.black : Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        shadows: [
                                          Shadow(
                                            offset: Offset(2.0, 2.0),
                                            blurRadius: 4.0,
                                            color: Colors.black.withOpacity(0.7),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (_selectedIndex == 0)
                                      Container(
                                        margin: EdgeInsets.only(top: 4),
                                        height: 2,
                                        width: 160,
                                        color: Colors.deepPurple,
                                      ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () => _onItemTapped(1),
                                child: Column(
                                  children: [
                                    Text(
                                      'Notifications',
                                      style: TextStyle(
                                        color: _selectedIndex == 1 ? Colors.black : Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        shadows: [
                                          Shadow(
                                            offset: Offset(2.0, 2.0),
                                            blurRadius: 4.0,
                                            color: Colors.black.withOpacity(0.7),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (_selectedIndex == 1)
                                      Container(
                                        margin: EdgeInsets.only(top: 4),
                                        height: 2,
                                        width: 130,
                                        color: Colors.deepPurple,
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: IndexedStack(
                          index: _selectedIndex,
                          children: <Widget>[
                            Center(
                              child: GridView.count(
                                crossAxisCount: 3,
                                mainAxisSpacing: 20,
                                crossAxisSpacing: 20,
                                padding: EdgeInsets.all(20),
                                children: <Widget>[
                                  if (canViewCheckPoints(widget.role))
                                    DashboardButton(
                                      imageAsset: 'images/check point.png',
                                      buttonText: 'Check Points',
                                      onPressed: () => _onButtonPressed('Check Points'),
                                    ),
                                  if (canViewStatus(widget.role))
                                    DashboardButton(
                                      imageAsset: 'images/status.jpg',
                                      buttonText: 'Status',
                                      onPressed: () => _onButtonPressed('Status'),
                                    ),
                                  DashboardButton(
                                    imageAsset: 'images/profit.jpg',
                                    buttonText: 'Profit & Performances',
                                    onPressed: () => _onButtonPressed('Profit & Performances'),
                                    isWide: true, 
                                  ),
                                ],
                              ),
                            ),
                            Center(
                              child: Text(
                                'Notifications Screen',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DashboardButton extends StatelessWidget {
  final String imageAsset;
  final String buttonText;
  final VoidCallback onPressed;
  final bool isWide; 

  DashboardButton({required this.imageAsset, required this.buttonText, required this.onPressed, this.isWide = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: isWide ? 180 : 150, 
        height: 200, // Adjust height to fit image and button
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: Image.asset(
                imageAsset,
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.deepPurple, // Text color
                minimumSize: Size(isWide ? 180 : 150, 50), // Adjust size
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
                padding: EdgeInsets.zero, // Remove default padding
              ),
              child: Text(
                buttonText,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
