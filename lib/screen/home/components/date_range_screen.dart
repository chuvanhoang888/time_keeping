import 'package:app_cham_cong_option_2/components/default_button.dart';
import 'package:app_cham_cong_option_2/constant.dart';
import 'package:app_cham_cong_option_2/screen/home/components/permission_form_screen.dart';
import 'package:app_cham_cong_option_2/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class TableDateRange extends StatefulWidget {
  final String type;
  const TableDateRange({Key? key, required this.type}) : super(key: key);

  @override
  _TableDateRangeState createState() => _TableDateRangeState();
}

class _TableDateRangeState extends State<TableDateRange> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOn; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
            statusBarColor: Colors.transparent),
        elevation: 0,
        backgroundColor: kBackgroundColor,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            ),

            const Text(
              "Tạo phép",
              style: TextStyle(fontSize: 12, color: Colors.white),
            )
            // Your widgets here
          ],
        ),
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderCalendar(rangeStart: _rangeStart, rangeEnd: _rangeEnd),
            TableCalendar(
              locale: 'vi',
              calendarFormat: CalendarFormat.month,
              calendarStyle: const CalendarStyle(

                  // set style color text cell for range from start to end
                  withinRangeTextStyle: TextStyle(color: Colors.white),
                  // withinRangeDecoration: BoxDecoration(
                  //     color: kBackgroundColor,
                  //     backgroundBlendMode: BlendMode.color,
                  //     border: BorderDirectional(
                  //       start: BorderSide.none,
                  //       end: BorderSide.none,
                  //     )),

                  rangeHighlightColor: kBackgroundColor,
                  rangeEndDecoration: BoxDecoration(
                      color: kBackgroundColor, shape: BoxShape.circle),
                  rangeStartDecoration: BoxDecoration(
                      color: kBackgroundColor, shape: BoxShape.circle)),
              firstDay: kFirstDay,
              lastDay: kLastDay,
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              rangeStartDay: _rangeStart,
              rangeEndDay: _rangeEnd,
              rangeSelectionMode: _rangeSelectionMode,
              startingDayOfWeek: StartingDayOfWeek.monday,
              headerStyle: const HeaderStyle(
                leftChevronIcon: Icon(
                  Icons.arrow_back_ios,
                  color: kBorderColor,
                  size: 20,
                ),
                rightChevronIcon: Icon(
                  Icons.arrow_forward_ios,
                  color: kBorderColor,
                  size: 20,
                ),
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              daysOfWeekHeight: 60,
              calendarBuilders: CalendarBuilders(
                // withinRangeBuilder: (context, day, isWithinRange) {
                //   return Container(
                //     child: Text(
                //       day.day.toString(),
                //       style: TextStyle(color: Colors.white),
                //     ),
                //     decoration: BoxDecoration(
                //         shape: BoxShape.circle, color: kBackgroundColor),
                //   );
                // },
                headerTitleBuilder: (context, day) {
                  return Center(
                    child: Text(
                      "Tháng" + DateFormat(' MM - yyyy').format(day),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  );
                },

                todayBuilder: (context, day, focusedDay) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: Center(
                      child: Text(
                        day.day.toString(),
                        style: const TextStyle(),
                      ),
                    ),
                  );
                },

                // rangeEndBuilder: (context, day, focusedDay) {
                //   return Container(
                //     margin: const EdgeInsets.all(6),
                //     decoration: const BoxDecoration(
                //         color: kBackgroundColor, shape: BoxShape.circle),
                //     child: Center(
                //       child: Text(
                //         day.day.toString(),
                //         style: const TextStyle(color: Colors.white),
                //       ),
                //     ),
                //   );
                // },
                // rangeStartBuilder: (context, day, focusedDay) {
                //   return Container(
                //     margin: const EdgeInsets.all(6),
                //     decoration: const BoxDecoration(
                //         color: kBackgroundColor, shape: BoxShape.circle),
                //     child: Center(
                //       child: Text(
                //         day.day.toString(),
                //         style: const TextStyle(color: Colors.white),
                //       ),
                //     ),
                //   );
                // },
                // withinRangeBuilder: (context, day, focusedDay) {
                //   return Container(
                //     decoration: const BoxDecoration(
                //       color: kBackgroundColor,
                //       border:
                //     ),
                //     child: Center(
                //       child: Text(
                //         day.day.toString(),
                //         style: const TextStyle(color: Colors.white),
                //       ),
                //     ),
                //   );
                // },
                // rangeHighlightBuilder: (context, day, isWithinRange) {
                //   return Container(
                //     decoration: const BoxDecoration(
                //       color: kBackgroundColor,
                //     ),
                //     child: Center(
                //       child: Text(
                //         day.day.toString(),
                //         style: const TextStyle(color: Colors.white),
                //       ),
                //     ),
                //   );
                // },
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
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                    _rangeStart = null; // Important to clean those
                    _rangeEnd = null;
                    _rangeSelectionMode = RangeSelectionMode.toggledOff;
                  });
                }
              },
              onRangeSelected: (start, end, focusedDay) {
                setState(() {
                  _selectedDay = null;
                  _focusedDay = focusedDay;
                  _rangeStart = start;
                  _rangeEnd = end;
                  _rangeSelectionMode = RangeSelectionMode.toggledOn;
                });
              },
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
            const SizedBox(
              height: 80,
            ),
            _rangeStart != null && _rangeEnd != null
                ? SizedBox(
                    width: size.width - 100,
                    child: DefaultButton(
                        title: "Tiếp theo",
                        press: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PermissionFormScreen(
                                        type: widget.type,
                                        startDay: _rangeStart!,
                                        endDay: _rangeEnd!,
                                      )));
                        }))
                : Container(),
          ],
        ),
      ),
    );
  }
}

class HeaderCalendar extends StatelessWidget {
  const HeaderCalendar({
    Key? key,
    required DateTime? rangeStart,
    required DateTime? rangeEnd,
  })  : _rangeStart = rangeStart,
        _rangeEnd = rangeEnd,
        super(key: key);

  final DateTime? _rangeStart;
  final DateTime? _rangeEnd;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      width: double.infinity,
      //height: size.height * 0.2,
      decoration: const BoxDecoration(color: kBackgroundColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ("Tháng " + DateFormat('MM - yyyy').format(DateTime.now())),
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
              (_rangeStart != null
                      ? "T" +
                          (_rangeStart!.weekday + 1).toString() +
                          "/" +
                          _rangeStart!.day.toString()
                      : "Bắt đầu") +
                  " - " +
                  (_rangeEnd != null
                      ? "T" +
                          (_rangeEnd!.weekday + 1).toString() +
                          "/" +
                          _rangeEnd!.day.toString()
                      : "Kết thúc"),
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 36))
        ],
      ),
    );
  }
}
