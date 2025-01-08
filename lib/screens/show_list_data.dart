import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:list_show/data/data_source.dart';
import 'package:list_show/models/users.dart';

class ShowListData extends StatefulWidget {
  const ShowListData({super.key});

  @override
  State<ShowListData> createState() {
    return _ShowListDataState();
  }
}

class _ShowListDataState extends State<ShowListData> {
  final key = new GlobalKey<PaginatedDataTableState>();
  List<Users> userData = [];
  bool _sortAscending = true;
  int _currentPage = 0;
  int? _sortColumnIndex;
  bool isLoading = false;
  final url = 'http://192.168.1.34:8000/api/users/';

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      final List<Users> userList =
          jsonData.map((user) => Users.fromMap(user)).toList();

      setState(() {
        userData.addAll(userList);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception("Failed to load data");
    }
  }

  void onSort(int columnIndex, bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
      key.currentState!.pageTo(0);
      switch (columnIndex) {
        case 0: // Sort by ID
          userData.sort((a, b) => compare<int>(a.id, b.id, ascending));
          break;
        case 1: // Sort by Name
          userData.sort((a, b) => compare<String>(a.name, b.name, ascending));
          break;
        case 2: // Sort by Address
          userData
              .sort((a, b) => compare<String>(a.address, b.address, ascending));
          break;
        case 3: // Sort by Phone
          userData.sort((a, b) => compare<String>(a.phone, b.phone, ascending));
          break;
        case 4: // Sort by Email
          userData.sort((a, b) => compare<String>(a.email, b.email, ascending));
          break;
        default:
          break;
      }
    });

    _resetPagination(); // Reset to the first page after sorting
  }

  void _resetPagination() {
    setState(() {
      _currentPage = 0;
    });
  }

  int compare<T extends Comparable>(T value1, T value2, bool ascending) {
    return ascending ? value1.compareTo(value2) : value2.compareTo(value1);
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(Object context) {
    Widget content = const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Please wait",
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(
            height: 20,
          ),
          CircularProgressIndicator()
        ],
      ),
    );

    if (!isLoading) {
      content = SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: PaginatedDataTable(
            key: key,
            arrowHeadColor: Colors.white,
            sortAscending: _sortAscending,
            sortColumnIndex: _sortColumnIndex,
            header: const Text(
              "Pagination Table",
              style: TextStyle(color: Colors.white),
            ),
            rowsPerPage: 20,
            columns: [
              DataColumn(
                label: Text("id"),
                onSort: (columnIndex, ascending) =>
                    onSort(columnIndex, ascending),
              ),
              DataColumn(
                label: Text("Name"),
                onSort: (columnIndex, ascending) =>
                    onSort(columnIndex, ascending),
              ),
              DataColumn(
                label: Text("Address"),
                onSort: (columnIndex, ascending) =>
                    onSort(columnIndex, ascending),
              ),
              DataColumn(
                label: Text("Phone"),
                onSort: (columnIndex, ascending) =>
                    onSort(columnIndex, ascending),
              ),
              DataColumn(
                label: Text("Email"),
                onSort: (columnIndex, ascending) =>
                    onSort(columnIndex, ascending),
              ),
              DataColumn(label: Text("Status")),
            ],
            source: DataSource(userData: userData, reset: _resetPagination),
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("DataTable"),
      ),
      body: content,
    );
  }

  compareString(bool ascending, String name, String name2) {
    ascending ? name.compareTo(name2) : name2.compareTo(name);
  }
}
