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
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Determine the size category (mobile, tablet, desktop)
          bool isMobile = constraints.maxWidth < 600;
          bool isTablet = constraints.maxWidth >= 600 && constraints.maxWidth < 1200;
          bool isDesktop = constraints.maxWidth >= 1200;

          double formWidth;
          if (isMobile) {
            formWidth = constraints.maxWidth * 0.9;
          } else if (isTablet) {
            formWidth = constraints.maxWidth * 0.7;
          } else {
            formWidth = constraints.maxWidth * 0.4;
          }

          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/user_reg.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Glassmorphism effect
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        width: formWidth,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                          ),
                        ),
                        child: Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'USER REGISTRATION',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: isMobile ? 24 : 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 20),
                                TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    labelText: 'First Name',
                                    labelStyle: TextStyle(color: Colors.white),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                    ),
                                  ),
                                  onSaved: (value) {
                                    _firstName = value!;
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter your first name';
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    labelText: 'Last Name',
                                    labelStyle: TextStyle(color: Colors.white),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                    ),
                                  ),
                                  onSaved: (value) {
                                    _lastName = value!;
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter your last name';
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    labelStyle: TextStyle(color: Colors.white),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                    ),
                                  ),
                                  onSaved: (value) {
                                    _email = value!;
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter your Email';
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    labelText: 'Address',
                                    labelStyle: TextStyle(color: Colors.white),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                    ),
                                  ),
                                  onSaved: (value) {
                                    _address = value!;
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter your Address';
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    labelText: 'Company',
                                    labelStyle: TextStyle(color: Colors.white),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                    ),
                                  ),
                                  onSaved: (value) {
                                    _company = value!;
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter your Company';
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
                                  child: Text('Register'),
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
    );
  }
}
