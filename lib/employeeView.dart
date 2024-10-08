import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EmployeeView extends StatefulWidget {
  @override
  _EmployeeViewState createState() => _EmployeeViewState();
}

class _EmployeeViewState extends State<EmployeeView> {
  List<dynamic> employees = [];
  List<dynamic> filteredEmployees = [];
  bool isLoading = true;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchEmployees();
    searchController.addListener(_filterEmployees);
  }

// LOADE EMPLOYEE
  Future<void> _fetchEmployees() async {
    final url = Uri.parse(
        'https://free-skylark-sadly.ngrok-free.app/api/v1/employee/getAllEmployees');
    final response = await http.get(url);
    var jsonResponse = jsonDecode(response.body);

    setState(() {
      if (jsonResponse['code'] == "00") {
        employees = jsonResponse['content'];
        filteredEmployees = employees;
      } else {
        throw Exception('Failed to load employees: ${jsonResponse['message']}');
      }
      isLoading = false;
    });
  }
  // LOADE EMPLOYEE

  // SEARCH EMPLOYEE

  void _filterEmployees() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredEmployees = employees.where((employee) {
        return employee['first_name'].toLowerCase().contains(query) ||
            employee['last_name'].toLowerCase().contains(query) ||
            employee['nic'].toLowerCase().contains(query) ||
            employee['email'].toLowerCase().contains(query);
      }).toList();
    });
  }
  // SEARCH EMPLOYEE

  // DELETE EMPLOYEE

  Future<void> _deleteEmployee(String employeeId) async {
    final url = Uri.parse(
        'https://free-skylark-sadly.ngrok-free.app/api/v1/employee/deleteEmployee/$employeeId');
    final response = await http.get(url);

    setState(() {
      employees
          .removeWhere((employee) => employee['id'].toString() == employeeId);
      filteredEmployees
          .removeWhere((employee) => employee['id'].toString() == employeeId);
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Employee deleted successfully')));
  }

  // DELETE EMPLOYEE

  // UPDATE EMPLOYEE
  Future<void> _updateEmployee(Map<String, dynamic> employeeDTO) async {
    final url = Uri.parse(
        'https://free-skylark-sadly.ngrok-free.app/api/v1/employee/updateEmployee');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(employeeDTO),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse['code'] == "00") {
        setState(() {
          int index = employees.indexWhere((employee) =>
              employee['id'].toString() == employeeDTO['id'].toString());
          if (index != -1) {
            employees[index] = jsonResponse['content'];
            filteredEmployees[index] = jsonResponse['content'];
          }
        });
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Employee updated successfully')));
      } else {
        throw Exception(
            'Failed to update employee: ${jsonResponse['message']}');
      }
    } else {
      throw Exception('Failed to update employee');
    }
  }
//UPDATE EMPLOYE

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search Employee',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: filteredEmployees.length,
                    itemBuilder: (context, index) {
                      final employee = filteredEmployees[index];
                      return ListTile(
                        leading: CircleAvatar(
                          child: Text(employee['first_name'][0]),
                        ),
                        title: Text(
                            '${employee['first_name']} ${employee['last_name']}'),
                        subtitle:
                            Text('Department: ${employee['department_id']}'),
                        onTap: () {
                          _showEmployeeDetails(employee);
                        },
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            _confirmDeleteEmployee(employee['id'].toString());
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _showEmployeeDetails(dynamic employee) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController firstNameController =
            TextEditingController(text: employee['first_name']);
        TextEditingController lastNameController =
            TextEditingController(text: employee['last_name']);
        TextEditingController emailController =
            TextEditingController(text: employee['email']);
        TextEditingController nicController =
            TextEditingController(text: employee['nic']);

        return AlertDialog(
          title: Text('${employee['first_name']} ${employee['last_name']}'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: firstNameController,
                  decoration: InputDecoration(labelText: 'First Name'),
                ),
                TextField(
                  controller: lastNameController,
                  decoration: InputDecoration(labelText: 'Last Name'),
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: nicController,
                  decoration: InputDecoration(labelText: 'NIC'),
                ),
                // Add more fields as required
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Update', style: TextStyle(color: Colors.blue)),
              onPressed: () {
                Navigator.of(context).pop();
                Map<String, dynamic> updatedData = {
                  'first_name': firstNameController.text,
                  'last_name': lastNameController.text,
                  'email': emailController.text,
                  'nic': nicController.text,
                  // Add more fields as required
                };
                _updateEmployee(updatedData);
              },
            ),
            TextButton(
              child: Text('Delete', style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pop();
                _confirmDeleteEmployee(employee['id'].toString());
              },
            ),
          ],
        );
      },
    );
  }

  void _confirmDeleteEmployee(String employeeId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this employee?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete', style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pop();
                _deleteEmployee(employeeId);
              },
            ),
          ],
        );
      },
    );
  }
}
