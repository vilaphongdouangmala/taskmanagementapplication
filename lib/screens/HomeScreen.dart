import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_application/models/Employee.dart';
import 'package:task_management_application/models/Task.dart';
import 'package:task_management_application/screens/TaskScreen.dart';
import 'package:task_management_application/styles/AppStyle.dart';

import '../components/BottomNav.dart';
import '/styles/AppColor.dart';
import '../main.dart';
import 'CreateTaskScreen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //store reference
    var store = Provider.of<Store>(context);
    return Scaffold(
      //appBar
      appBar: AppBar(
        title: const Text("AppBar"),
        backgroundColor: AppColor.primaryRed,
        actions: [],
      ),
      //body
      body: FutureBuilder<List<Task>>(
        future: store.getTasks(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            //return progress
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            //return widget
            return ListView.separated(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int i) {
                return GestureDetector(
                  onTap: () {
                    //move to new creen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            TaskScreen(task: snapshot.data![i]),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.all(AppStyle.defaultPadding),
                    child: Text(
                      snapshot.data![i].taskName,
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
            );
          }
        },
      ),
      bottomNavigationBar: BottomNav(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //move to new creen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateTaskScreen(),
            ),
          );
        },
        backgroundColor: AppColor.primaryRed,
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  } //ef
}
