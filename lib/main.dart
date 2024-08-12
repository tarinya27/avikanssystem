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
import 'package:flutter_application_1/panel.dart';
//import 'package:flutter_application_1/admin_dash.dart';
import 'package:flutter_application_1/dashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: RegisterCustomer(),
      home:CustomerView(),
      //home: RegisterEmployee(),
      //home: SupplierView(),
      //home:RegisterUser(),
      //home: RegisterSupplier(),
      //home: UserManageView(),
      //home: Panel(),
      //home: Dashboard(role: 'admin',),
    );
  }
}
