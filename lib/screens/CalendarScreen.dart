// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:task_management_application/components/LongButton.dart';

import 'package:task_management_application/models/Employee.dart';
import 'package:task_management_application/models/SubTask.dart';
import 'package:task_management_application/models/Task.dart';
import 'package:task_management_application/screens/TaskScreen.dart';
import 'package:task_management_application/styles/AppStyle.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../components/BottomNav.dart';
import '../components/StatusBox.dart';
import '../main.dart';
import '/styles/AppColor.dart';
import 'CreateTaskScreen.dart';

class CaldendarScreen extends StatelessWidget {
  bool first = true;
  final CalendarController _calendarController = CalendarController();

  @override
  Widget build(BuildContext context) {
    //store reference
    var store = Provider.of<Store>(context);
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      //body
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: screenSize.height * 0.18),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(AppStyle.defaultPadding),
                  child: HDatePicker(
                    store: store,
                    calendarController: _calendarController,
                  ),
                ),
                Expanded(
                  child: store.subtasks.isEmpty
                      ? const NoActivitiesMessage()
                      : SfCalendar(
                          timeSlotViewSettings: const TimeSlotViewSettings(
                            startHour: 7,
                            endHour: 24,
                          ),
                          controller: _calendarController,
                          view: CalendarView.day,
                          viewHeaderHeight: 0,
                          headerHeight: 0,
                          dataSource: EventDataSource(
                            convertSubtaskToEvent(store.subtasks),
                          ),
                          allowViewNavigation: false,
                          selectionDecoration: BoxDecoration(
                            border: Border.all(
                              color: AppColor.primaryColor,
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
          CalendarScreenHeader(screenSize: screenSize),
        ],
      ),
    );
  } //ef
} //ec

class NoActivitiesMessage extends StatelessWidget {
  const NoActivitiesMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: AppStyle.defaultPadding * 0.5),
          child: const Text(
            "No Activities For Today",
            style: AppStyle.mainHeadingBlack,
          ),
        ),
        const Icon(
          Icons.celebration,
          size: 60,
          color: AppColor.primaryColor,
        ),
      ],
    );
  }
}

class CalendarScreenHeader extends StatelessWidget {
  const CalendarScreenHeader({
    Key? key,
    required this.screenSize,
  }) : super(key: key);

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenSize.height * 0.18,
      width: screenSize.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
        color: AppColor.primaryColor,
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(AppStyle.defaultPadding,
            AppStyle.defaultPadding * 1.5, AppStyle.defaultPadding, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "Today's Activities",
              style: AppStyle.mainHeading,
            ),
            Icon(
              Icons.account_circle,
              size: 50,
              color: AppColor.white,
            ),
          ],
        ),
      ),
    );
  }
}

class HDatePicker extends StatelessWidget {
  const HDatePicker({
    Key? key,
    required this.store,
    required this.calendarController,
  }) : super(key: key);

  final Store store;
  final CalendarController calendarController;

  @override
  Widget build(BuildContext context) {
    return DatePicker(
      DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day - 5,
      ),
      monthTextStyle: AppStyle.horizontalDatePickerStyle,
      dateTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 21,
      ),
      dayTextStyle: AppStyle.horizontalDatePickerStyle,
      initialSelectedDate: DateTime.now(),
      daysCount: 31, //display for 1 month
      selectionColor: AppColor.primaryColor,
      onDateChange: (date) {
        calendarController.displayDate = date;
        store.setSelectedDate(date);
      },
    );
  }
}

// List<SubTask> getSubTasksForTimetable() {
//   List<SubTask> subtasks = [];
//   final DateTime today = DateTime.now();
//   final DateTime startTime =
// } //ef

List<Event> convertSubtaskToEvent(List<SubTask> subtasks) {
  List<Event> events = [];
  for (SubTask subtask in subtasks) {
    Event event = Event(
      subtask.name,
      DateTime.parse(subtask.datetime),
      DateTime.parse(subtask.datetime).add(const Duration(hours: 1)),
      AppColor.primaryColor,
    );
    events.add(event);
  } //eloop
  return events;
} //ef

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<Event> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }
} //ec

class Event {
  Event(this.eventName, this.from, this.to, this.background);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
}//ec
