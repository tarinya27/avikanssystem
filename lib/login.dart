import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 900,
          height: 500,
          child: Row(
            children: [
              // Left Panel with Logo and Gradient Background
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFC779D0), Color(0xFF834d9b)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "WELCOME",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        // Logo Image
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.white,
                          child: ClipOval(
                            child: Image.asset(
                              'images/logo.jpg', // Replace with your logo image path
                              fit: BoxFit.cover,
                              width: 120,
                              height: 120,
                            ),
                          ),
                        ),
                        SizedBox(height: 40), // Spacing between logo and text
                        // Placeholder for Text
                        Text(
                          "Avikans manufactures high-quality, elegantly designed lighting fixtures.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Right Panel with Form
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.all(32.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: 20),
                          IconButton(
                            icon: Icon(Icons.close, color: Colors.grey),
                            onPressed: () {
                              // Handle close button press
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      // "LOGIN" Text with Gradient Color
                      ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: [Color(0xFF834d9b), Color(0xFFC779D0)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ).createShader(bounds),
                        child: Text(
                          "LOGIN",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Required for ShaderMask
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Username",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      ElevatedButton.icon(
                        onPressed: () {
                          // Handle login button press
                        },
                        icon: Icon(Icons.login),
                        label: Text("Login"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFC779D0),
                          padding: EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 40,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}