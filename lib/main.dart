import 'package:flutter/material.dart';
import 'package:flutter_application_1/login.dart';
import 'package:flutter_application_1/employee.dart';
import 'package:flutter_application_1/employeeView.dart';
import 'package:flutter_application_1/Supplier.dart';
import 'package:flutter_application_1/SupplierManage.dart';
import 'package:flutter_application_1/User.dart';
import 'package:flutter_application_1/UserManage.dart';
import 'package:flutter_application_1/Customer.dart';
import 'package:flutter_application_1/CustomerManage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: SignInScreen() ,
      // home: CustomerView(),
      home: RegisterCustomer(),

      // home: RegisterEmployee(),
      // home: EmployeeView(),
      // home: RegisterSupplier(),
      // home: UserManegeView(),
    );
  }
}

