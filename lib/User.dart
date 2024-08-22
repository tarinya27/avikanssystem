import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterUser extends StatefulWidget {
  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  final _formKey = GlobalKey<FormState>();

  String _firstName = '';
  String _lastName = '';
  String _username = '';
  String _password = '';
  String _selectedUserType = '';
  List<Map<String, dynamic>> _userTypes = [
    {"id": "admin", "name": "Admin"},
    {"id": "supervisor", "name": "Supervisor"},
    {"id": "super_admin", "name": "Super Admin"}
  ];

  Future<void> _registerEmployee() async {
    final url = Uri.parse('https://free-skylark-sadly.ngrok-free.app/api/v1/user/saveUser');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "first_name": _firstName,
        "last_name": _lastName,
        "username": _username,
        "password": _password,
        "userType": {"id": _selectedUserType}
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('User registered successfully!'),
        backgroundColor: Colors.green,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to register user: ${response.body}'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FAFB),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 4,
                  blurRadius: 8,
                  offset: Offset(0, 4), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'User Registration',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 24),
                    _buildTextFormField('First Name', Icons.person, (value) {
                      _firstName = value!;
                    }, 'Please enter a first name'),
                    SizedBox(height: 16),
                    _buildTextFormField('Last Name', Icons.person, (value) {
                      _lastName = value!;
                    }, 'Please enter a last name'),
                    SizedBox(height: 16),
                    _buildTextFormField('Username', Icons.person_outline, (value) {
                      _username = value!;
                    }, 'Please enter a username'),
                    SizedBox(height: 16),
                    _buildTextFormField('Password', Icons.lock, (value) {
                      _password = value!;
                    }, 'Please enter a password', obscureText: true),
                    SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'User Type',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.assignment_ind),
                      ),
                      value: _selectedUserType.isNotEmpty ? _selectedUserType : null,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedUserType = newValue!;
                        });
                      },
                      items: _userTypes
                          .map<DropdownMenuItem<String>>((Map<String, dynamic> value) {
                        return DropdownMenuItem<String>(
                          value: value['id'],
                          child: Text(value['name']),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 24),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple, // Background color
                          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                          textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            _registerEmployee();
                          }
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white, // Text color
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(String label, IconData icon, FormFieldSetter<String> onSaved, String validatorMessage, {bool obscureText = false}) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        prefixIcon: Icon(icon),
      ),
      obscureText: obscureText,
      onSaved: onSaved,
      validator: (value) {
        if (value!.isEmpty) {
          return validatorMessage;
        }
        return null;
      },
    );
  }
}
