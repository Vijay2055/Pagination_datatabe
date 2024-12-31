import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:list_show/main.dart';

class DataTablePaginationExample extends StatelessWidget {
  var tableRow = new TableRow();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Data Table Pagination Example Code',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: colorScheme.onPrimary,
          ),
          body: Container(
            width: double.infinity,
           
            child: SingleChildScrollView(
              child: PaginatedDataTable(
                header: Text("Pagination Example"),
                onRowsPerPageChanged: (perPage) {},
                rowsPerPage: 10,
                columns: <DataColumn>[
                  DataColumn(
                    label: Text('Country'),
                    onSort: (columnIndex, ascending) {
                      print("$columnIndex $ascending");
                    },
                  ),
                  const DataColumn(
                    label: Text('Code'),
                  ),
                  const DataColumn(
                    label: Text('Continent'),
                  ),
                  const DataColumn(
                    label: Text('Other'),
                  ),
                  const DataColumn(
                    label: Text('Some submit'),
                  ),
                  const DataColumn(
                    label: Text(
                      'Some Action',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
                source: tableRow,
              ),
            ),
          )),
    );
  }
}

class TableRow extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text("Cell $index")),
      DataCell(Text("Cell $index")),
      DataCell(Text("Cell $index")),
      DataCell(Text("Cell $index")),
      DataCell(TextButton(
        onPressed: () {},
        child: Text("Submit"),
      )),
      DataCell(TextButton(
        onPressed: () {},
        child: Text("Actions"),
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => true;

  @override
  int get rowCount => 50;

  @override
  int get selectedRowCount => 0;
}