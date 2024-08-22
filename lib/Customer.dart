import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:ui'; // For the glassmorphism effect

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
        "mobile": _mobile,
        "company": _company,
      }),
    );

    if (response.statusCode == 200) {
      print(response.body);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Customer registered successfully!'),
      ));
    } else {
      print(response.body);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to register Customer: ${response.body}'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double formWidth = constraints.maxWidth * 0.9;
            double labelFontSize = 18;
            double inputFontSize = 16;

            return Stack(
              children: [
                Container(
                  color: Colors.white, // Solid white background
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: SingleChildScrollView(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            width: formWidth,
                            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.3), // Glass effect color
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.4), // Border color and opacity
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 20,
                                  offset: Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    'CUSTOMER REGISTRATION',
                                    style: TextStyle(
                                      color: Colors.deepPurple,
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 30),
                                  _buildTextField('First Name', Icons.person, (value) {
                                    _firstName = value!;
                                  }, 'Enter your first name', inputFontSize, labelFontSize),
                                  SizedBox(height: 20),
                                  _buildTextField('Last Name', Icons.person, (value) {
                                    _lastName = value!;
                                  }, 'Enter your last name', inputFontSize, labelFontSize),
                                  SizedBox(height: 20),
                                  _buildTextField('Email', Icons.email, (value) {
                                    _email = value!;
                                  }, 'Enter your email', inputFontSize, labelFontSize),
                                  SizedBox(height: 20),
                                  _buildTextField('Company', Icons.business, (value) {
                                    _company = value!;
                                  }, 'Enter your company', inputFontSize, labelFontSize),
                                  SizedBox(height: 20),
                                  _buildTextField('Address', Icons.home, (value) {
                                    _address = value!;
                                  }, 'Enter your address', inputFontSize, labelFontSize),
                                  SizedBox(height: 20),
                                  _buildTextField('Mobile', Icons.phone, (value) {
                                    _mobile = value!;
                                  }, 'Enter your mobile number', inputFontSize, labelFontSize),
                                  SizedBox(height: 30),
                                  Center(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();
                                          _registerCustomer();
                                        }
                                      },
                                      child: Text('Register'),
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white, backgroundColor: Colors.deepPurple, // Text color
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                                        elevation: 10,
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
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon, FormFieldSetter<String>? onSaved, String? validatorMessage, double inputFontSize, double labelFontSize) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.6), // Glass effect color
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white.withOpacity(0.4)), // Border color and opacity
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  style: TextStyle(color: Colors.black, fontSize: inputFontSize),
                  decoration: InputDecoration(
                    prefixIcon: Icon(icon, color: Colors.deepPurple),
                    labelText: label,
                    labelStyle: TextStyle(color: Colors.deepPurple, fontSize: labelFontSize),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                  ),
                  onSaved: onSaved,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return validatorMessage;
                    }
                    return null;
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
