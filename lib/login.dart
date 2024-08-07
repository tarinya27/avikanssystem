import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import "package:get/get.dart";
import 'package:mysql1/mysql1.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreen createState() => _SignInScreen();
}

class _SignInScreen extends State<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 800,
          height: 400,
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
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "WELCOME",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        // Logo Image
                        CircleAvatar(
                          radius: 60,
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
                            fontSize: 16,
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
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Required for ShaderMask
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: "Username",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: passwordController,
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
                          login();
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

  Future<void> login() async {
    final String username = emailController.text;
    final String password = passwordController.text;
    final String url = "http://192.168.208.123:8080/api/v1";

    final response = await http.get(
      Uri.parse('$url/login/getUsernamePassword/$username/$password'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic>? responseData = json.decode(response.body);

      if (responseData != null && responseData.containsKey('user_type_id')) {
        final int adminType = responseData['user_type_id'] as int;
        final String username = responseData['username'] as String;

        if (adminType == 1) {
          print(adminType);
          // Navigator.push(

          // );
        } else if (adminType == 2) {
          // Navigator.push(
          //   context,

          // );
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(

          //   ),
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Invalid admin type. Please contact support.'),
            ),
          );
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid username or password. Please try again.'),
        ),
      );
    }
  }
}
