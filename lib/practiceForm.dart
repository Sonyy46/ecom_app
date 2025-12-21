// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ecom_app/riverpod/app_notifier.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class Practiceform extends ConsumerWidget {
//   Practiceform({super.key});
//   final modelProvider = notifierStateProvider<Map<String, dynamic>>({});
//   final _formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Taking information")),
//       body: Form(
//         key: _formKey,
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextFormField(
//                 decoration: InputDecoration(
//                   isDense: true,
//                   hintText: "Enter your First name",
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return "Please enter your Name";
//                   }
//                   return null;
//                 },
//                 onChanged: (value) {
//                   ref
//                       .read(modelProvider.notifier)
//                       .update((state) => {...state, "firstName": value});
//                 },
//               ),
//             ),

//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextFormField(
//                 decoration: InputDecoration(
//                   isDense: true,
//                   hintText: "Enter your Last name",
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return "Please enter your Last Name";
//                   }
//                   return null;
//                 },
//                 onChanged: (value) {
//                   ref
//                       .read(modelProvider.notifier)
//                       .update((state) => {...state, "lastName": value});
//                 },
//               ),
//             ),

//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextFormField(
//                 decoration: InputDecoration(
//                   hintText: "Enter your Age",
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return "Please enter your age";
//                   }
//                   return null;
//                 },
//                 onChanged: (value) {
//                   ref
//                       .read(modelProvider.notifier)
//                       .update((state) => {...state, "age": value});
//                 },
//               ),
//             ),
//             SizedBox(height: 20),
//             FilledButton(
//               onPressed: () async {
//                 if (!_formKey.currentState!.validate()) {
//                   return;
//                 }
//                 await FirebaseFirestore.instance.collection("Practice").add({
//                   ...ref.watch(modelProvider),
//                   "timeStamp": FieldValue.serverTimestamp(),
//                 });
//                 _formKey.currentState!.reset();
//               },
//               child: Text("Submit"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
