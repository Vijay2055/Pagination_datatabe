// import 'dart:convert';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:http/http.dart' as http;

// // Data model for the records
// class User {
//   final int id;
//   final String name;
//   final int age;

//   User({required this.id, required this.name, required this.age});

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['id'],
//       name: json['name'],
//       age: json['age'],
//     );
//   }
// }

// // State to manage fetching data and pagination
// class DataState {
//   final List<User> data;
//   final bool isLoading;
//   final int totalRecords;

//   DataState({
//     required this.data,
//     required this.isLoading,
//     required this.totalRecords,
//   });

//   DataState.initial() : data = [], isLoading = false, totalRecords = 0;
// }

// // StateNotifier to manage the logic for fetching data
// class DataNotifier extends StateNotifier<DataState> {
//   DataNotifier() : super(DataState.initial());

//   Future<void> fetchData(int startIndex, int limit) async {
//     if (state.isLoading) return;

//     state = DataState(data: state.data, isLoading: true, totalRecords: state.totalRecords);

//     final response = await http.get(Uri.parse(
//         'https://api.example.com/data?start=$startIndex&limit=$limit'));

//     if (response.statusCode == 200) {
//       final result = jsonDecode(response.body);
//       final List<User> newData = (result['data'] as List)
//           .map((item) => User.fromJson(item))
//           .toList();
//       final totalRecords = result['total']; // Assuming API returns total count.

//       state = DataState(
//         data: List.from(state.data)..addAll(newData),
//         isLoading: false,
//         totalRecords: totalRecords,
//       );
//     }
//   }
// }

// // Riverpod provider for the data notifier
// final dataProvider = StateNotifierProvider<DataNotifier, DataState>((ref) {
//   return DataNotifier();
// });






// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'data_provider.dart'; // Import the provider

// class LazyDataTable extends ConsumerStatefulWidget {
//   @override
//   _LazyDataTableState createState() => _LazyDataTableState();
// }

// class _LazyDataTableState extends ConsumerState<LazyDataTable> {
//   final int _rowsPerPage = 10;

//   @override
//   Widget build(BuildContext context) {
//     final dataState = ref.watch(dataProvider);

//     return Scaffold(
//       appBar: AppBar(title: Text('Lazy Loading DataTable')),
//       body: SingleChildScrollView(
//         child: PaginatedDataTable(
//           header: Text('Users'),
//           columns: [
//             DataColumn(label: Text('ID')),
//             DataColumn(label: Text('Name')),
//             DataColumn(label: Text('Age')),
//           ],
//           source: MyDataTableSource(dataState: dataState),
//           rowsPerPage: _rowsPerPage,
//         ),
//       ),
//     );
//   }
// }

// class MyDataTableSource extends DataTableSource {
//   final DataState dataState;
//   MyDataTableSource({required this.dataState});

//   @override
//   DataRow getRow(int index) {
//     if (index >= dataState.data.length) {
//       return DataRow.byIndex(
//         index: index,
//         cells: [
//           DataCell(Text('Loading...')),
//           DataCell(Text('Loading...')),
//           DataCell(Text('Loading...')),
//         ],
//       );
//     }

//     final item = dataState.data[index];
//     return DataRow.byIndex(
//       index: index,
//       cells: [
//         DataCell(Text(item.id.toString())),
//         DataCell(Text(item.name)),
//         DataCell(Text(item.age.toString())),
//       ],
//     );
//   }

//   @override
//   bool get isRowCountApproximate => false;

//   @override
//   int get rowCount => dataState.totalRecords;

//   @override
//   int get selectedRowCount => 0;
// }


// update this

// PaginatedDataTable(
//   header: Text('Users'),
//   columns: [
//     DataColumn(label: Text('ID')),
//     DataColumn(label: Text('Name')),
//     DataColumn(label: Text('Age')),
//   ],
//   source: MyDataTableSource(dataState: dataState),
//   rowsPerPage: _rowsPerPage,
//   onPageChanged: (pageIndex) {
//     final startIndex = pageIndex * _rowsPerPage;
//     ref.read(dataProvider.notifier).fetchData(startIndex, _rowsPerPage);
//   },
// )


// ################second approach##########################
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:http/http.dart' as http;

// // Data model for the records
// class User {
//   final int id;
//   final String name;
//   final int age;
//   final String phone;
//   final bool isAccepted;

//   User({
//     required this.id,
//     required this.name,
//     required this.age,
//     required this.phone,
//     required this.isAccepted,
//   });

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['id'],
//       name: json['name'],
//       age: json['age'],
//       phone: json['phone'],
//       isAccepted: json['is_accepted'] ?? false,
//     );
//   }

//   // Convert to JSON for update
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'age': age,
//       'phone': phone,
//       'is_accepted': isAccepted,
//     };
//   }
// }

// // State to manage fetching data and pagination
// class DataState {
//   final List<User> data;
//   final bool isLoading;
//   final int totalRecords;

//   DataState({
//     required this.data,
//     required this.isLoading,
//     required this.totalRecords,
//   });

//   DataState.initial() : data = [], isLoading = false, totalRecords = 0;
// }

// // StateNotifier to manage the logic for fetching data
// class DataNotifier extends StateNotifier<DataState> {
//   DataNotifier() : super(DataState.initial());

//   Future<void> fetchData(int startIndex, int limit) async {
//     if (state.isLoading) return;

//     state = DataState(data: state.data, isLoading: true, totalRecords: state.totalRecords);

//     final response = await http.get(Uri.parse(
//         'https://api.example.com/data?start=$startIndex&limit=$limit'));

//     if (response.statusCode == 200) {
//       final result = jsonDecode(response.body);
//       final List<User> newData = (result['data'] as List)
//           .map((item) => User.fromJson(item))
//           .toList();
//       final totalRecords = result['total']; // Assuming API returns total count.

//       state = DataState(
//         data: List.from(state.data)..addAll(newData),
//         isLoading: false,
//         totalRecords: totalRecords,
//       );
//     }
//   }

//   Future<void> updateUserAcceptance(int userId, bool isAccepted) async {
//     final response = await http.post(
//       Uri.parse('https://api.example.com/update_user_acceptance'),
//       body: {
//         'user_id': userId.toString(),
//         'is_accepted': isAccepted.toString(),
//       },
//     );
//     if (response.statusCode == 200) {
//       // Handle successful update if necessary
//     }
//   }
// }

// // Riverpod provider for the data notifier
// final dataProvider = StateNotifierProvider<DataNotifier, DataState>((ref) {
//   return DataNotifier();
// });

// class LazyDataTable extends ConsumerStatefulWidget {
//   @override
//   _LazyDataTableState createState() => _LazyDataTableState();
// }

// class _LazyDataTableState extends ConsumerState<LazyDataTable> {
//   final int _rowsPerPage = 10;

//   @override
//   Widget build(BuildContext context) {
//     final dataState = ref.watch(dataProvider);

//     return Scaffold(
//       appBar: AppBar(title: Text('User Data Table')),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             if (dataState.isLoading)
//               Center(child: CircularProgressIndicator()),
//             if (!dataState.isLoading)
//               PaginatedDataTable(
//                 header: Text('Users'),
//                 columns: [
//                   DataColumn(label: Text('ID')),
//                   DataColumn(label: Text('Name')),
//                   DataColumn(label: Text('Age')),
//                   DataColumn(label: Text('Phone')),
//                   DataColumn(label: Text('Action')),
//                   DataColumn(label: Text('Show Details')),
//                 ],
//                 source: MyDataTableSource(
//                   dataState: dataState,
//                 ),
//                 rowsPerPage: _rowsPerPage,
//                 onPageChanged: (pageIndex) {
//                   final startIndex = pageIndex * _rowsPerPage;
//                   ref.read(dataProvider.notifier).fetchData(startIndex, _rowsPerPage);
//                 },
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class MyDataTableSource extends DataTableSource {
//   final DataState dataState;

//   MyDataTableSource({required this.dataState});

//   @override
//   DataRow getRow(int index) {
//     final item = dataState.data[index];

//     return DataRow.byIndex(
//       index: index,
//       cells: [
//         DataCell(Text(item.id.toString())),
//         DataCell(Text(item.name)),
//         DataCell(Text(item.age.toString())),
//         DataCell(Text(item.phone)),
//         DataCell(
//           ElevatedButton(
//             onPressed: () => _showAcceptancePopup(item),
//             child: Text(item.isAccepted ? 'Accepted' : 'Accept'),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: item.isAccepted ? Colors.green : Colors.blue,
//             ),
//           ),
//         ),
//         DataCell(
//           ElevatedButton(
//             onPressed: () {
//               _showUserDetailsPopup(item);
//             },
//             child: Text('Show Details'),
//           ),
//         ),
//       ],
//     );
//   }

//   @override
//   bool get isRowCountApproximate => false;

//   @override
//   int get rowCount => dataState.totalRecords;

//   @override
//   int get selectedRowCount => 0;

//   void _showAcceptancePopup(User user) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Accept User'),
//           content: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text('ID: ${user.id}'),
//               Text('Name: ${user.name}'),
//               Text('Age: ${user.age}'),
//               Text('Phone: ${user.phone}'),
//               Text('Do you want to accept this user?'),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 _acceptUser(user);
//               },
//               child: Text('Accept'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Cancel'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _acceptUser(User user) async {
//     await ref.read(dataProvider.notifier).updateUserAcceptance(user.id, true);
//     // Update the button color to green
//     setState(() {
//       user.isAccepted = true;
//     });
//   }

//   void _showUserDetailsPopup(User user) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('User Details'),
//           content: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text('ID: ${user.id}'),
//               Text('Name: ${user.name}'),
//               Text('Age: ${user.age}'),
//               Text('Phone: ${user.phone}'),
//               Text('Email: user@example.com'), // Add more details here
//               Text('Address: 123 Main St'), // Additional fields
//               // Continue with other fields up to 15 details
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Close'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
