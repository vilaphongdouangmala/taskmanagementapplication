// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:date_picker_timeline/date_picker_timeline.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import 'package:task_management_application/models/Employee.dart';
// import 'package:task_management_application/models/Task.dart';
// import 'package:task_management_application/screens/TaskScreen.dart';
// import 'package:task_management_application/styles/AppStyle.dart';

// import '../components/BottomNav.dart';
// import '../components/StatusBox.dart';
// import '../main.dart';
// import '/styles/AppColor.dart';
// import 'CreateTaskScreen.dart';

// class HomePage2 extends StatelessWidget {
//   bool first = true;

//   @override
//   Widget build(BuildContext context) {
//     //store reference
//     var store = Provider.of<Store>(context);
//     if (first) {
//       store.getDisplayedTasksByDate();
//       first = false;
//     } //end if
//     return Scaffold(
//       //appBar
//       appBar: AppBar(
//         title: const Text("AppBar"),
//         backgroundColor: AppColor.primaryRed,
//         actions: [],
//       ),
//       //body
//       body: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.all(AppStyle.defaultPadding),
//             child: DatePicker(
//               DateTime(
//                 DateTime.now().year,
//                 DateTime.now().month,
//                 DateTime.now().day - 5,
//               ),
//               initialSelectedDate: DateTime.now(),
//               selectionColor: AppColor.primaryColor,
//               onDateChange: (date) {
//                 store.getDisplayedTasksByDate(filteredDate: date);
//               },
//             ),
//           ),
//           Expanded(
//             child: RefreshIndicator(
//               onRefresh: () async {
//                 store.getTasks(refresh: true);
//                 store.getDisplayedTasksByDate();
//               },
//               child: FutureBuilder<List<Task>>(
//                 future: store.getTasks(),
//                 builder: (context, snapshot) {
//                   if (!snapshot.hasData) {
//                     //return progress
//                     return const Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   } else {
//                     //return widget
//                     return ListView.separated(
//                       itemCount: store.displayedTasks.length,
//                       itemBuilder: (BuildContext context, int i) {
//                         return GestureDetector(
//                           onTap: () {
//                             //move to new screen
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) =>
//                                     TaskScreen(task: store.displayedTasks[i]),
//                               ),
//                             );
//                           },
//                           child: Padding(
//                             padding: EdgeInsets.all(AppStyle.defaultPadding),
//                             child: ListTile(
//                               leading: Text(store.displayedTasks[i].taskName),
//                               title: Text(store.displayedTasks[i].startDate),
//                               trailing: StatusBox(
//                                 task: store.displayedTasks[i],
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                       separatorBuilder: (context, index) => const Divider(),
//                     );
//                   }
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: BottomNav(),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           //move to new creen
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => CreateTaskScreen(),
//             ),
//           );
//         },
//         backgroundColor: AppColor.primaryRed,
//         child: const Icon(
//           Icons.add,
//         ),
//       ),
//     );
//   } //ef
// }
