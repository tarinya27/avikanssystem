import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterEmployee extends StatefulWidget {
  @override
  _RegisterEmployeeState createState() => _RegisterEmployeeState();
}

class _RegisterEmployeeState extends State<RegisterEmployee> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _nicController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _mobileNoController = TextEditingController();
  final TextEditingController _bankDetailsController = TextEditingController();

  // Department Dropdown items
  final List<String> _departments = [
    'Fabrication',
    'Lathe',
    'Polishing',
    'Spinning',
    'Painting',
    'Casting',
    'Assemble'
  ];
  String? _selectedDepartment;

  Future<void> _registerEmployee() async {
    if (_formKey.currentState!.validate() && _selectedDepartment != null) {
      final url = Uri.parse(
          'https://free-skylark-sadly.ngrok-free.app/api/v1/employee/saveEmployee');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "first_name": _firstNameController.text,
          "last_name": _lastNameController.text,
          "address": _addressController.text,
          "nic": _nicController.text,
          "email": _emailController.text,
          "mobile": _mobileNoController.text,
          "bank_details": _bankDetailsController.text,
          "departments": _selectedDepartment,
        }),
      );

      if (response.statusCode == 200) {
        print(response.body);

        // Registration successful
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Employee registered successfully!'),
          backgroundColor: Colors.green,
        ));
      } else {
        print(response.body);
        // Registration failed
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Registration failed: ${response.body}'),
          backgroundColor: Colors.red,
        ));
      }
    } else {
      
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('All fields are required, including the department.'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], 
      body: Center(
        child: Card(
          elevation: 15,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 40), 
          child: Padding(
            padding: const EdgeInsets.all(20.0), 
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Employee Registration',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    SizedBox(height: 20),
                    _buildTextFormField(
                      controller: _firstNameController,
                      labelText: 'First Name',
                      icon: Icons.person,
                      validator: (value) => value!.isEmpty ? 'First Name is required' : null,
                    ),
                    SizedBox(height: 12),
                    _buildTextFormField(
                      controller: _lastNameController,
                      labelText: 'Last Name',
                      icon: Icons.person_outline,
                      validator: (value) => value!.isEmpty ? 'Last Name is required' : null,
                    ),
                    SizedBox(height: 12),
                    _buildTextFormField(
                      controller: _addressController,
                      labelText: 'Address',
                      icon: Icons.home,
                      validator: (value) => value!.isEmpty ? 'Address is required' : null,
                    ),
                    SizedBox(height: 12),
                    _buildTextFormField(
                      controller: _nicController,
                      labelText: 'NIC',
                      icon: Icons.perm_identity,
                      validator: (value) => value!.isEmpty ? 'NIC is required' : null,
                    ),
                    SizedBox(height: 12),
                    _buildTextFormField(
                      controller: _mobileNoController,
                      labelText: 'Mobile No',
                      icon: Icons.phone,
                      validator: (value) => value!.isEmpty ? 'Mobile No is required' : null,
                    ),
                    SizedBox(height: 12),
                    _buildTextFormField(
                      controller: _emailController,
                      labelText: 'Email Address',
                      icon: Icons.email,
                      validator: (value) => value!.isEmpty ? 'Email Address is required' : null,
                    ),
                    SizedBox(height: 12),
                    _buildTextFormField(
                      controller: _bankDetailsController,
                      labelText: 'Bank Details',
                      icon: Icons.account_balance,
                      validator: (value) => value!.isEmpty ? 'Bank Details are required' : null,
                    ),
                    SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity, 
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Department',
                          prefixIcon: Icon(Icons.work),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          filled: true,
                          fillColor: Colors.white, 
                        ),
                        value: _selectedDepartment,
                        items: _departments
                            .map((department) => DropdownMenuItem<String>(
                                  value: department,
                                  child: Text(department),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedDepartment = value;
                          });
                        },
                        validator: (value) => value == null ? 'Department is required' : null,
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _registerEmployee(); 
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple, 
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30), 
                        ),
                        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                        shadowColor: Colors.deepPurpleAccent, 
                        elevation: 10, 
                      ),
                      child: Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 20,
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

  
  Widget _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    required FormFieldValidator<String> validator,
  }) {
    return SizedBox(
      width: double.infinity, // Full width for the TextFormField
      child: TextFormField(
        controller: controller,
        maxLength: 50, // Limit the input length to 50 characters
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(icon, color: Colors.deepPurple),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          filled: true,
          fillColor: Colors.white, 
          counterText: '', 
        ),
        validator: validator, 
      ),
    );
  }
}
