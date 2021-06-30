import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

void main() {
  runApp(SfDataGridDemo());
}

class SfDataGridDemo extends StatefulWidget {
  SfDataGridDemo({Key? key}) : super(key: key);

  @override
  _SfDataGridDemoState createState() => _SfDataGridDemoState();
}

class _SfDataGridDemoState extends State<SfDataGridDemo> {
  late EmployeeDataSource _employeeDataSource;
  late CustomColumnSizer _customColumnSizer;

  @override
  void initState() {
    super.initState();
    _employeeDataSource = EmployeeDataSource(employees: populateData());
    _customColumnSizer = CustomColumnSizer();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Syncfusion Flutter DataGrid'),
          ),
          body: SfDataGrid(
            source: _employeeDataSource,
            columnSizer: _customColumnSizer,
            columnWidthMode: ColumnWidthMode.auto,
            columns: <GridColumn>[
              GridColumn(
                  columnName: 'ID',
                  autoFitPadding: EdgeInsets.all(12.0),
                  label: Container(
                      padding: EdgeInsets.all(12.0),
                      alignment: Alignment.center,
                      child: Text(
                        'ID',
                      ))),
              GridColumn(
                  columnName: 'Name',
                  autoFitPadding: EdgeInsets.all(12.0),
                  label: Container(
                      padding: EdgeInsets.all(12.0),
                      alignment: Alignment.center,
                      child: Text('Name',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic)))),
              GridColumn(
                  columnName: 'Designation',
                  autoFitPadding: EdgeInsets.all(12.0),
                  label: Container(
                      padding: EdgeInsets.all(12.0),
                      alignment: Alignment.center,
                      child: Text(
                        'Designation',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      ))),
              GridColumn(
                  columnName: 'Salary',
                  autoFitPadding: EdgeInsets.all(12.0),
                  label: Container(
                      padding: EdgeInsets.all(12.0),
                      alignment: Alignment.center,
                      child: Text('Salary'))),
            ],
          )),
    );
  }

  List<Employee> populateData() {
    return [
      Employee(10001, 'James', 'Project Lead', 20000),
      Employee(10002, 'Kathryn', 'UX Designer', 30000),
      Employee(10003, 'Lara', 'Software Developer', 15000),
      Employee(10004, 'Michael', 'UX Designer', 15000),
      Employee(10005, 'Martin', 'Testing Engineer', 15000),
      Employee(10006, 'Newberry', 'Team Lead', 15000),
      Employee(10007, 'Balnc', 'Network Engineer', 15000),
      Employee(10008, 'Perry', 'Software Developer', 15000),
      Employee(10009, 'Gable', 'Software Developer', 15000),
      Employee(10010, 'Grimes', 'Software Developer', 15000)
    ];
  }
}

class Employee {
  Employee(this.id, this.name, this.designation, this.salary);

  final int id;

  final String name;

  final String designation;

  final int salary;
}

class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource({required List<Employee> employees}) {
    _employeeData = employees
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'ID', value: e.id),
              DataGridCell<String>(columnName: 'Name', value: e.name),
              DataGridCell<String>(
                  columnName: 'Designation', value: e.designation),
              DataGridCell<int>(columnName: 'Salary', value: e.salary),
            ]))
        .toList();
  }

  List<DataGridRow> _employeeData = [];

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(12.0),
        child: Text(e.value.toString(),
            style: (e.columnName == 'Name' || e.columnName == 'Designation')
                ? TextStyle(
                    fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)
                : null),
      );
    }).toList());
  }
}

class CustomColumnSizer extends ColumnSizer {
  @override
  double computeHeaderCellWidth(GridColumn column, TextStyle style) {
    if (column.columnName == 'Name' || column.columnName == 'Designation') {
      style =
          TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic);
    }
    return super.computeHeaderCellWidth(column, style);
  }

  @override
  double computeCellWidth(GridColumn column, DataGridRow row, Object? cellValue,
      TextStyle textStyle) {
    if (column.columnName == 'Name' || column.columnName == 'Designation') {
      textStyle =
          TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic);
    }
    return super.computeCellWidth(column, row, cellValue, textStyle);
  }
}
