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
  List<Map<String, dynamic>> _userTypes = [];

  @override
  void initState() {
    super.initState();
    _fetchUserTypes();
  }

  Future<void> _fetchUserTypes() async {
    final url = Uri.parse(
        'https://free-skylark-sadly.ngrok-free.app/api/v1/user/getAllUserTypes');

    try {
      final response = await http.get(url);

      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse['code'] == "00") {
        final List<dynamic> content = jsonResponse['content'];

        setState(() {
          _userTypes = content
              .map<Map<String, dynamic>>(
                  (item) => {"id": item['id'].toString(), "name": item['name']})
              .toList();

          if (_userTypes.isNotEmpty) {
            _selectedUserType = _userTypes[1]['id'];
          }
        });
      } else {
        // Handle API response indicating failure
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text('Failed to load user types: ${jsonResponse['message']}'),
        ));
      }
    } catch (e) {
      // Handle other errors like network issues
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to load user types: $e'),
      ));
    }
  }

  Future<void> _registerEmployee() async {
    final uri = 'https://free-skylark-sadly.ngrok-free.app';
    final url = Uri.parse('$uri/api/v1/user/saveUser');

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

    // Registration successful
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('User registered successfully!'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'First Name'),
                onSaved: (value) {
                  _firstName = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a first name';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Last Name'),
                onSaved: (value) {
                  _lastName = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a last name';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                onSaved: (value) {
                  _password = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Username'),
                onSaved: (value) {
                  _username = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'User Type'),
                value: _selectedUserType.isNotEmpty ? _selectedUserType : null,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedUserType = newValue!;
                  });
                },
                items: _userTypes.map<DropdownMenuItem<String>>(
                    (Map<String, dynamic> value) {
                  return DropdownMenuItem<String>(
                    value: value['id'],
                    child: Text(value['name']),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _registerEmployee();
                  }
                },
                child: Text('Register User'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
