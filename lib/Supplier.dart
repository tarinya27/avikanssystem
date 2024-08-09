import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterSupplier  extends StatefulWidget {
  @override
  _RegisterSupplierState createState() => _RegisterSupplierState ();
}

class _RegisterSupplierState  extends State<RegisterSupplier > {
  final _formKey = GlobalKey<FormState>();

  String _firstName = '';
  String _lastName = '';
  
  String _email = '';
  String _mobile = '';
  
  String _company= '';

  

  Future<void> _registerSupplier() async {
    final  uri = 'https://free-skylark-sadly.ngrok-free.app';

    final url = Uri.parse(
        'https://free-skylark-sadly.ngrok-free.app/api/v1/supplier/saveSupplier');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "first_name": _firstName,
        "last_name": _lastName,
        "email":_email,
        "mobile": _mobile,
        "company":_company
      
      }),
    );

    if (response.statusCode == 200) {
      print(response.body);

      // Registration successful
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Supplier registered successfully!'),
      ));
    } else {
      print(response.body);
      // Registration failed
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(response.body),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Supplier'),
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
                    return 'Please enter Email';
                  }
                  return null;
                },
              ),
             
              TextFormField(
                decoration: InputDecoration(labelText: 'Mobile'),
                onSaved: (value) {
                  _mobile = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an mobile';
                  }
                  return null;
                },
              ),
              
              TextFormField(
                decoration: InputDecoration(labelText: 'Company Name'),
                onSaved: (value) {
                  _company = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Supplier Company Name';
                  }
                  return null;
                },
              ),
             
             
                
              
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _registerSupplier();
                  }
                },
                child: Text('Register Supplier'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
