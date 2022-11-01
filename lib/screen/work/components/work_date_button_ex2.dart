import 'package:app_cham_cong_option_2/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class WorkDateButton extends StatefulWidget {
  const WorkDateButton({
    Key? key,
  }) : super(key: key);

  @override
  State<WorkDateButton> createState() => _WorkDateButtonState();
}

class _WorkDateButtonState extends State<WorkDateButton>
    with SingleTickerProviderStateMixin {
  OverlayEntry? entry;
  final layerLink = LayerLink();
  bool click = false;

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

  void showOverlay() {
    final overlay = Overlay.of(context)!;
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    //final offset = renderBox.localToGlobal(Offset.zero);
    entry = OverlayEntry(
      builder: (context) => Positioned(
          width: size.width - 20,
          // left: offset.dx,
          // top: offset.dy + size.height,
          child: CompositedTransformFollower(
              link: layerLink,
              offset: Offset(0, size.height + 8),
              showWhenUnlinked: false,
              child: const DateOverlayClass())),
    );
    overlay.insert(entry!);
  }

  void hideOverlay() {
    entry?.remove();
    entry = null;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child:
          //SizedBox(height: _animation.value),
          Row(
        children: [
          SvgPicture.asset("assets/icons/Group 3651.svg"),
          const SizedBox(
            width: 15,
          ),
          CompositedTransformTarget(
            link: layerLink,
            child: InkWell(
              onTap: () {
                //click = !click;
                if (click == false) {
                  click = true;
                  showOverlay();
                } else {
                  click = false;
                  hideOverlay();
                }
                setState(() {});
              },
              child: const Text(
                "Ngày hết hạn...",
                style: TextStyle(color: kBorderColor, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DateOverlayClass extends StatefulWidget {
  const DateOverlayClass({Key? key}) : super(key: key);

  @override
  State<DateOverlayClass> createState() => _DateOverlayClassState();
}

class _DateOverlayClassState extends State<DateOverlayClass> {
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(15),
      elevation: 8,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.white),
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
              weekendStyle:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              weekdayStyle:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
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
                      fontSize: 16,
                      color: Colors.black),
                ),
              );
            },
            todayBuilder: (context, day, focusedDay) {
              return Container(
                margin: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                    color: Color(0xFFBBDDFF), shape: BoxShape.circle),
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
                  child:
                      Text("T3", style: TextStyle(fontWeight: FontWeight.bold)),
                );
              } else if (day.weekday == DateTime.wednesday) {
                return const Center(
                  child:
                      Text("T4", style: TextStyle(fontWeight: FontWeight.bold)),
                );
              } else if (day.weekday == DateTime.thursday) {
                return const Center(
                  child:
                      Text("T5", style: TextStyle(fontWeight: FontWeight.bold)),
                );
              } else if (day.weekday == DateTime.friday) {
                return const Center(
                  child:
                      Text("T6", style: TextStyle(fontWeight: FontWeight.bold)),
                );
              } else if (day.weekday == DateTime.saturday) {
                return const Center(
                  child:
                      Text("T7", style: TextStyle(fontWeight: FontWeight.bold)),
                );
              } else {
                return const Center(
                  child:
                      Text("CN", style: TextStyle(fontWeight: FontWeight.bold)),
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

            //print(focusedDay);
          },
        ),
      ),
    );
  }
}
