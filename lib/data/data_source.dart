import 'package:flutter/material.dart';
import 'package:list_show/models/users.dart';

class DataSource extends DataTableSource {
  DataSource({required this.userData, required this.reset});
  int current_page = 0;

  final List<Users> userData;
  void Function() reset;

  @override
  DataRow? getRow(int index) {
    if (index > userData.length) {
      return null;
    }

    final item = userData[index];

    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(
        item.id.toString(),
        style: TextStyle(color: Colors.white),
      )),
      DataCell(
        Text(
          item.name,
          style: TextStyle(color: Colors.white),
        ),
      ),
      DataCell(Text(
        item.address,
        style: TextStyle(color: Colors.white),
      )),
      DataCell(Text(
        item.phone,
        style: TextStyle(color: Colors.white),
      )),
      DataCell(Text(
        item.email,
        style: TextStyle(color: Colors.white),
      )),
      DataCell(ElevatedButton(
        onPressed: () {},
        child: Text(item.status == "Accepted" ? "Accepted" : "Accept"),
      ))
    ]);
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => userData.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}
