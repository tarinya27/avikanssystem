import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterSupplier extends StatefulWidget {
  @override
  _RegisterSupplierState createState() => _RegisterSupplierState();
}

class _RegisterSupplierState extends State<RegisterSupplier> {
  final _formKey = GlobalKey<FormState>();

  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _mobile = '';
  String _company = '';

  Future<void> _registerSupplier() async {
    final url = Uri.parse('https://free-skylark-sadly.ngrok-free.app/api/v1/supplier/saveSupplier');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "first_name": _firstName,
        "last_name": _lastName,
        "email": _email,
        "mobile": _mobile,
        "company": _company
      }),
    );

    if (response.statusCode == 200) {
      print(response.body);

      // Registration successful
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Supplier registered successfully!'),
        backgroundColor: Colors.green,
      ));
    } else {
      print(response.body);
      // Registration failed
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Registration failed. Please try again.'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0), // Horizontal padding
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              constraints: BoxConstraints(maxWidth: 600), // Optional max width
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0), 
                child: Column(
                  mainAxisSize: MainAxisSize.min, 
                  children: <Widget>[
                    Text(
                      'Supplier Registration',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    _buildTextField('First Name', (value) => _firstName = value!),
                    SizedBox(height: 16),
                    _buildTextField('Last Name', (value) => _lastName = value!),
                    SizedBox(height: 16),
                    _buildTextField('Email', (value) => _email = value!),
                    SizedBox(height: 16),
                    _buildTextField('Mobile', (value) => _mobile = value!),
                    SizedBox(height: 16),
                    _buildTextField('Company Name', (value) => _company = value!),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          _registerSupplier();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
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

  Widget _buildTextField(String label, FormFieldSetter<String> onSaved) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      onSaved: onSaved,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }
}
