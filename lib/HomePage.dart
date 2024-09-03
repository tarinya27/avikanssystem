import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Page',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              icon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Icon(Icons.reorder),
              ),
              onChanged: (String? value) {
                // Handle dropdown item selection
                print('Selected: $value');
              },
              items: [
                DropdownMenuItem<String>(
                  value: 'Profit',
                  child: Row(
                    children: [
                      Image.asset('images/r2.png', width: 24, height: 24),
                      SizedBox(width: 8.0),
                      Text('Profit'),
                    ],
                  ),
                ),
                DropdownMenuItem<String>(
                  value: 'Stock',
                  child: Row(
                    children: [
                      Image.asset('images/r1.png', width: 24, height: 24),
                      SizedBox(width: 8.0),
                      Text('Stock'),
                    ],
                  ),
                ),
                DropdownMenuItem<String>(
                  value: 'Salary',
                  child: Row(
                    children: [
                      Image.asset('images/r3.png', width: 24, height: 24),
                      SizedBox(width: 8.0),
                      Text('Salary'),
                    ],
                  ),
                ),
                DropdownMenuItem<String>(
                  value: 'Daily Work',
                  child: Row(
                    children: [
                      Image.asset('images/r5.png', width: 24, height: 24),
                      SizedBox(width: 8.0),
                      Text('Daily Work'),
                    ],
                  ),
                ),
                DropdownMenuItem<String>(
                  value: 'Most Selling',
                  child: Row(
                    children: [
                      Image.asset('images/r4.png', width: 24, height: 24),
                      SizedBox(width: 8.0),
                      Text('Most Selling'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildSection(
                      title: 'JOB ITEM HANDLING',
                      steps: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Image.asset('images/customers.png'),
                                  SizedBox(height: 8.0),
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: Text('Customer'),
                                  ),
                                ],
                              ),
                            ),
                            Icon(Icons.arrow_forward),
                            Expanded(
                              child: Column(
                                children: [
                                  Image.asset('images/job.png'),
                                  SizedBox(height: 8.0),
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: Text('Job'),
                                  ),
                                ],
                              ),
                            ),
                            Icon(Icons.arrow_forward),
                            Expanded(
                              child: Column(
                                children: [
                                  Image.asset('images/products.png'),
                                  SizedBox(height: 8.0),
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: Text('Product'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    buildSection(
                      title: 'PRODUCT',
                      steps: [
                        CostingStep(
                          image: 'images/ptype.png',
                          buttonLabel: 'Product type',
                          nextStepImage: 'images/products.png',
                          nextStepButtonLabel: 'Product',
                          isHorizontal: true,
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    buildSection(
                      title: 'MATERIAL',
                      steps: [
                        CostingStep(
                          image: 'images/mtype.png',
                          buttonLabel: 'Material type',
                          nextStepImage: 'images/material.png',
                          nextStepButtonLabel: 'Material',
                          isHorizontal: true,
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    buildSection(
                      title: 'SALARY',
                      steps: [
                        CostingStep(
                          image: 'images/attendance.png',
                          buttonLabel: 'View attendance',
                          nextStepImage: 'images/salary.png',
                          nextStepButtonLabel: 'Salary',
                          isHorizontal: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.0),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildCostingContainer(),
                    SizedBox(height: 16.0),
                    buildInventoryContainer(),
                    SizedBox(height: 16.0),
                    buildReportContainer(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSection({required String title, required List<Widget> steps}) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 16.0),
          Column(children: steps),
        ],
      ),
    );
  }

  Widget buildCostingContainer() {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('COSTING HANDLING', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: CostingStep(
                  image: 'images/mcost.png',
                  buttonLabel: 'Material Cost',
                  nextStepImage: 'images/mapproval.png',
                  nextStepButtonLabel: 'Material Approval',
                  isHorizontal: true,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: CostingStep(
                  image: 'images/lcost.png',
                  buttonLabel: 'Labour Cost',
                  nextStepImage: 'images/lapproval.png',
                  nextStepButtonLabel: 'Labour Approval',
                  isHorizontal: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildInventoryContainer() {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('INVENTORY', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: InventoryStep(
                  image: 'images/supplier.png',
                  buttonLabel: 'Supplier',
                  isHorizontal: true,
                ),
              ),
              Icon(Icons.arrow_forward),
              Expanded(
                child: GrnStep(
                  image: 'images/grn.png',
                  buttonLabel: 'GRN',
                  nextStepImage: 'images/gdn.png',
                  nextStepButtonLabel: 'GDN',
                  isHorizontal: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildReportContainer() {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('DAILY WORK', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: DailyworkStep(
                  image: 'images/emp.png',
                  buttonLabel: 'Employee',
                  isHorizontal: true,
                ),
              ),
              Icon(Icons.arrow_forward),
              Expanded(
                child: AttendanceStep(
                  image: 'images/attendance.png',
                  buttonLabel: 'Attendance',
                  nextStepImage: 'images/wp.png',
                  nextStepButtonLabel: 'Working Progress',
                  isHorizontal: true,
                ),
              ),
              Icon(Icons.arrow_forward),
              Expanded(
                child: WorkingprogressStep(
                  image: 'images/dc.png',
                  buttonLabel: 'Day Close',
                  nextStepImage: 'images/mc.png',
                  nextStepButtonLabel: 'Month Close',
                  isHorizontal: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CostingStep extends StatelessWidget {
  final String image;
  final String buttonLabel;
  final String nextStepImage;
  final String nextStepButtonLabel;
  final bool isHorizontal;

  CostingStep({
    required this.image,
    required this.buttonLabel,
    required this.nextStepImage,
    required this.nextStepButtonLabel,
    this.isHorizontal = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Image.asset(image),
              SizedBox(height: 8.0),
              ElevatedButton(
                onPressed: () {},
                child: Text(buttonLabel),
              ),
            ],
          ),
        ),
        isHorizontal ? Icon(Icons.arrow_forward) : Container(),
        Expanded(
          child: Column(
            children: [
              Image.asset(nextStepImage),
              SizedBox(height: 8.0),
              ElevatedButton(
                onPressed: () {},
                child: Text(nextStepButtonLabel),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class InventoryStep extends StatelessWidget {
  final String image;
  final String buttonLabel;
  final bool isHorizontal;

  InventoryStep({
    required this.image,
    required this.buttonLabel,
    this.isHorizontal = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(image),
        SizedBox(height: 8.0),
        ElevatedButton(
          onPressed: () {},
          child: Text(buttonLabel),
        ),
      ],
    );
  }
}

class GrnStep extends StatelessWidget {
  final String image;
  final String buttonLabel;
  final String nextStepImage;
  final String nextStepButtonLabel;
  final bool isHorizontal;

  GrnStep({
    required this.image,
    required this.buttonLabel,
    required this.nextStepImage,
    required this.nextStepButtonLabel,
    this.isHorizontal = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Image.asset(image),
              SizedBox(height: 8.0),
              ElevatedButton(
                onPressed: () {},
                child: Text(buttonLabel),
              ),
            ],
          ),
        ),
        isHorizontal ? Icon(Icons.arrow_forward) : Container(),
        Expanded(
          child: Column(
            children: [
              Image.asset(nextStepImage),
              SizedBox(height: 8.0),
              ElevatedButton(
                onPressed: () {},
                child: Text(nextStepButtonLabel),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DailyworkStep extends StatelessWidget {
  final String image;
  final String buttonLabel;
  final bool isHorizontal;

  DailyworkStep({
    required this.image,
    required this.buttonLabel,
    this.isHorizontal = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(image),
        SizedBox(height: 8.0),
        ElevatedButton(
          onPressed: () {},
          child: Text(buttonLabel),
        ),
      ],
    );
  }
}

class AttendanceStep extends StatelessWidget {
  final String image;
  final String buttonLabel;
  final String nextStepImage;
  final String nextStepButtonLabel;
  final bool isHorizontal;

  AttendanceStep({
    required this.image,
    required this.buttonLabel,
    required this.nextStepImage,
    required this.nextStepButtonLabel,
    this.isHorizontal = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Image.asset(image),
              SizedBox(height: 8.0),
              ElevatedButton(
                onPressed: () {},
                child: Text(buttonLabel),
              ),
            ],
          ),
        ),
        isHorizontal ? Icon(Icons.arrow_forward) : Container(),
        Expanded(
          child: Column(
            children: [
              Image.asset(nextStepImage),
              SizedBox(height: 8.0),
              ElevatedButton(
                onPressed: () {},
                child: Text(nextStepButtonLabel),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class WorkingprogressStep extends StatelessWidget {
  final String image;
  final String buttonLabel;
  final String nextStepImage;
  final String nextStepButtonLabel;
  final bool isHorizontal;

  WorkingprogressStep({
    required this.image,
    required this.buttonLabel,
    required this.nextStepImage,
    required this.nextStepButtonLabel,
    this.isHorizontal = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Image.asset(image),
              SizedBox(height: 8.0),
              ElevatedButton(
                onPressed: () {},
                child: Text(buttonLabel),
              ),
            ],
          ),
        ),
        isHorizontal ? Icon(Icons.arrow_forward) : Container(),
        Expanded(
          child: Column(
            children: [
              Image.asset(nextStepImage),
              SizedBox(height: 8.0),
              ElevatedButton(
                onPressed: () {},
                child: Text(nextStepButtonLabel),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
