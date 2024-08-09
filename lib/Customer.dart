import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterCustomer extends StatefulWidget {
  @override
  _RegisterCustomerState createState() => _RegisterCustomerState();
}

class _RegisterCustomerState extends State<RegisterCustomer> {
  final _formKey = GlobalKey<FormState>();

  String _firstName = '';
  String _lastName = '';
  String _company = '';
  String _address = '';
  String _mobile = '';
  String _email = '';

  @override
  void initState() {
    super.initState();
  }

  Future<void> _registerCustomer() async {
    final uri = 'https://free-skylark-sadly.ngrok-free.app';
    final url = Uri.parse('$uri/api/v1/customer/saveCustomer');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "first_name": _firstName,
        "last_name": _lastName,
        "address": _address,
        "email": _email,
        "mobile": _mobile
      }),
    );

    if (response.statusCode == 200) {
      print(response.body);

      // Registration successful
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Customer registered successfully!'),
      ));
    } else {
      print(response.body);
      // Registration failed
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to register Customer: ${response.body}'),
      ));
    }
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
                decoration: InputDecoration(labelText: 'Email'),
                onSaved: (value) {
                  _email = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a Email';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Address'),
                onSaved: (value) {
                  _address = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a Address';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Company'),
                onSaved: (value) {
                  _company = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a Company';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _registerCustomer();
                  }
                },
                child: Text('Register Customer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
