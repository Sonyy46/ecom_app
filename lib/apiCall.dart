// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class Apicall extends StatefulWidget {
//   Apicall({super.key});

//   @override
//   State<Apicall> createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<Apicall> {
//   List<dynamic> users = [];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Api Call")),
//       body: ListView.builder(
//         itemCount: users.length,

//         itemBuilder: (context, index) {
//           final data = users[index];
//           print(data);
//           return ListTile(title: Text(data["email"]));
//         },
//       ),

//       floatingActionButton: FloatingActionButton(onPressed: fetchUser),
//     );
//   }

//   void fetchUser() async {
//     const url = "https://randomuser.me/api/?results=50";
//     final uri = Uri.parse(url);
//     final response = await http.get(uri);
//     final body = response.body;
//     final json = jsonDecode(body);
//     setState(() {
//       users = json['results'];
//     });
//   }
// }
