import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterEmployee extends StatefulWidget {
  @override
  _RegisterEmployeeState createState() => _RegisterEmployeeState();
}

class _RegisterEmployeeState extends State<RegisterEmployee> {
  final _formKey = GlobalKey<FormState>();

  String _firstName = '';
  String _lastName = '';
  String _nic = '';
  String _email = '';
  String _address = '';
  String _mobile = '';
  DateTime _registerDate = DateTime.now();
  String _bankDetails = '';
  String _employeeType = '1';
  String _departmentId = '2';

  final List<String> _employeeTypes = ['1', 'Part-Time', 'Contract'];
  final List<String> _departments = [
    '2',
    'Finance',
    'Engineering',
    'Marketing'
  ];

  Future<void> _registerEmployee() async {
    final  uri = 'https://free-skylark-sadly.ngrok-free.app';

    final url = Uri.parse(
        'https://free-skylark-sadly.ngrok-free.app/api/v1/employee/saveEmployee');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "first_name": _firstName,
        "last_name": _lastName,
        "address": _address,
        "nic": _nic,
        "email": _email,
        "mobile": _mobile,
        "bank_details": _bankDetails,
        "employeeType": {"id": _employeeType},
        "department_id": _departmentId
      }),
    );

    if (response.statusCode == 200) {
      print(response.body);

      // Registration successful
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Employee registered successfully!'),
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
        title: Text('Register Employee'),
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
                decoration: InputDecoration(labelText: 'NIC'),
                onSaved: (value) {
                  _nic = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter NIC';
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
                    return 'Please enter an email';
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
                    return 'Please enter an address';
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
                    return 'Please enter a mobile number';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Bank Details'),
                onSaved: (value) {
                  _bankDetails = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter bank details';
                  }
                  return null;
                },
              ),
              ListTile(
                title: Text(
                    'Register Date: ${_registerDate.toLocal()}'.split(' ')[0]),
                trailing: Icon(Icons.calendar_today),
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: _registerDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null && picked != _registerDate)
                    setState(() {
                      _registerDate = picked;
                    });
                },
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Employee Type'),
                value: _employeeType,
                onChanged: (String? newValue) {
                  setState(() {
                    _employeeType = newValue!;
                  });
                },
                items: _employeeTypes
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Department ID'),
                value: _departmentId,
                onChanged: (String? newValue) {
                  setState(() {
                    _departmentId = newValue!;
                  });
                },
                items:
                    _departments.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
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
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
