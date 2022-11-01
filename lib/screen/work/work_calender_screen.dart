import 'package:app_cham_cong_option_2/constant.dart';
import 'package:app_cham_cong_option_2/screen/work/detail_work_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class WorkCalenderScreen extends StatefulWidget {
  const WorkCalenderScreen({Key? key}) : super(key: key);

  @override
  State<WorkCalenderScreen> createState() => _WorkCalenderScreenState();
}

class _WorkCalenderScreenState extends State<WorkCalenderScreen> {
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            ),
            const Text(
              "Công việc",
              style: TextStyle(fontSize: 12, color: Colors.black),
            )
            // Your widgets here
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 20),
            decoration: const BoxDecoration(color: kCalendorColor),
            child: TableCalendar(
              calendarFormat: CalendarFormat.week,
              startingDayOfWeek: StartingDayOfWeek.monday,
              daysOfWeekHeight: 60,
              headerStyle: const HeaderStyle(
                  leftChevronIcon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  rightChevronIcon: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  decoration: BoxDecoration(color: kBackgroundColor)),
              daysOfWeekStyle: const DaysOfWeekStyle(
                  weekendStyle: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                  weekdayStyle: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white)),
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: focusedDay,

              calendarBuilders: CalendarBuilders(
                headerTitleBuilder: (context, day) {
                  return Center(
                    child: Text(
                      "Tháng" + DateFormat(' MM - yyyy').format(day),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white),
                    ),
                  );
                },
                todayBuilder: (context, day, focusedDay) {
                  return Container(
                    margin: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        color: selectedDay != focusedDay
                            ? kBackgroundColor
                            : kCalendorColor,
                        shape: BoxShape.circle),
                    child: Center(
                      child: Text(
                        day.day.toString(),
                        style: TextStyle(
                            color: selectedDay != focusedDay
                                ? Colors.white
                                : Colors.black),
                      ),
                    ),
                  );
                },
                selectedBuilder: (context, day, focusedDay) {
                  return Container(
                    margin: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                        color: kBackgroundColor, shape: BoxShape.circle),
                    child: Center(
                      child: Text(
                        day.day.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
                dowBuilder: (context, day) {
                  if (day.weekday == DateTime.monday) {
                    return const Center(
                      child: Text(
                        "T2",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    );
                  } else if (day.weekday == DateTime.tuesday) {
                    return const Center(
                      child: Text("T3",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    );
                  } else if (day.weekday == DateTime.wednesday) {
                    return const Center(
                      child: Text("T4",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    );
                  } else if (day.weekday == DateTime.thursday) {
                    return const Center(
                      child: Text("T5",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    );
                  } else if (day.weekday == DateTime.friday) {
                    return const Center(
                      child: Text("T6",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    );
                  } else if (day.weekday == DateTime.saturday) {
                    return const Center(
                      child: Text("T7",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    );
                  } else {
                    return const Center(
                      child: Text("CN",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    );
                  }
                },
              ),

              //Sự kiện nhấn vào ngày đã chọn
              selectedDayPredicate: (day) {
                return isSameDay(selectedDay, day);
              },
              // calendarStyle: CalendarStyle(
              //     canMarkersOverflow: true,
              //     markerDecoration: BoxDecoration(color: Colors.red)),
              onDaySelected: (selectDay, focusDay) {
                setState(() {
                  selectedDay = selectDay;
                  focusedDay = focusDay;
                });
                print(focusedDay);
                //print(focusedDay);
              },
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return InkWell(
                    // onTap: () => Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const DetailWorkScreen())),
                    child: const CardWorkCalendor(
                      dateTime: "11:00 am - 07/09/2020",
                      title: "App chấm công",
                      date: "Thời gian: 07/09/2020 - 18/09/2020",
                    ),
                  );
                }),
          ))
        ],
      ),
    );
  }
}

class CardWorkCalendor extends StatelessWidget {
  final String dateTime;
  final String title;
  final String date;
  const CardWorkCalendor({
    Key? key,
    required this.dateTime,
    required this.title,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              height: 13,
              width: 13,
              decoration: const BoxDecoration(
                  color: kBackgroundColor, shape: BoxShape.circle),
            ),
          ),
          const SizedBox(
            width: 25,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dateTime,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  date,
                  style: const TextStyle(
                      fontSize: 10, fontStyle: FontStyle.italic),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
