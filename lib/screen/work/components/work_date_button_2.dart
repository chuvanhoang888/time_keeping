import 'package:app_cham_cong_option_2/constant.dart';
import 'package:app_cham_cong_option_2/data/models/components/work_request.dart';
import 'package:app_cham_cong_option_2/screen/work/work_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class WorkDateButton2 extends StatefulWidget {
  const WorkDateButton2({
    Key? key,
  }) : super(key: key);

  @override
  State<WorkDateButton2> createState() => _WorkDateButton2State();
}

class _WorkDateButton2State extends State<WorkDateButton2> {
  bool isMenuOpen = false;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  @override
  void initState() {
    super.initState();

    //WidgetsBinding.instance!.addPostFrameCallback((timeStamp) => showOverlay());
  }

  @override
  void dispose() {
    super.dispose();

    //scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final workDateProvider = Provider.of<WorkDateProvider>(context);
    return Row(
      children: [
        SvgPicture.asset("assets/icons/Group 3651.svg"),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: PortalTarget(
            visible: isMenuOpen,
            anchor: const Aligned(
              follower: Alignment.topCenter,
              target: Alignment.bottomCenter,
            ),
            portalFollower: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                setState(() {
                  isMenuOpen = false;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Material(
                      borderRadius: BorderRadius.circular(15),
                      elevation: 8,
                      child: Container(
                        width: MediaQuery.of(context).size.width - 90,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white),
                        child: TableCalendar(
                          locale: 'vi',
                          calendarFormat: CalendarFormat.month,
                          startingDayOfWeek: StartingDayOfWeek.monday,
                          daysOfWeekHeight: 40,
                          rowHeight: 40,
                          headerStyle: const HeaderStyle(
                              leftChevronIcon: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.black,
                                size: 15,
                              ),
                              rightChevronIcon: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black,
                                size: 15,
                              ),
                              headerPadding: EdgeInsets.symmetric(vertical: 0),
                              formatButtonVisible: false,
                              titleCentered: true,
                              titleTextStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                              decoration: BoxDecoration(color: Colors.white)),
                          daysOfWeekStyle: const DaysOfWeekStyle(
                              weekendStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              weekdayStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          firstDay: DateTime.utc(2010, 10, 16),
                          lastDay: DateTime.utc(2030, 3, 14),
                          focusedDay: focusedDay,

                          calendarBuilders: CalendarBuilders(
                            headerTitleBuilder: (context, day) {
                              return Center(
                                child: Text(
                                  "Tháng" +
                                      DateFormat(' MM - yyyy').format(day),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.black),
                                ),
                              );
                            },
                            todayBuilder: (context, day, focusedDay) {
                              return Container(
                                margin: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(
                                    color: Color(0xFFBBDDFF),
                                    shape: BoxShape.circle),
                                child: Center(
                                  child: Text(
                                    day.day.toString(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              );
                            },
                            selectedBuilder: (context, day, focusedDay) {
                              return Container(
                                margin: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(
                                    color: kBackgroundColor,
                                    shape: BoxShape.circle),
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                );
                              } else if (day.weekday == DateTime.tuesday) {
                                return const Center(
                                  child: Text("T3",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                );
                              } else if (day.weekday == DateTime.wednesday) {
                                return const Center(
                                  child: Text("T4",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                );
                              } else if (day.weekday == DateTime.thursday) {
                                return const Center(
                                  child: Text("T5",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                );
                              } else if (day.weekday == DateTime.friday) {
                                return const Center(
                                  child: Text("T6",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                );
                              } else if (day.weekday == DateTime.saturday) {
                                return const Center(
                                  child: Text("T7",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                );
                              } else {
                                return const Center(
                                  child: Text("CN",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
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
                              workDateProvider.deadLine =
                                  DateFormat('dd/MM/yyyy').format(selectDay);
                              isMenuOpen = false;
                            });

                            //print(focusedDay);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            child: InkWell(
              onTap: () {
                isMenuOpen = !isMenuOpen;
                setState(() {});
              },
              child: workDateProvider.deadLine.isNotEmpty
                  ? Text(workDateProvider.deadLine)
                  : const Text("Ngày hết hạn...",
                      style: TextStyle(color: kBorderColor, fontSize: 12)),
            ),
          ),
        ),
      ],
    );
  }
}
