import 'dart:async';

import 'package:app_cham_cong_option_2/constant.dart';
import 'package:app_cham_cong_option_2/data/models/work/work.dart';
import 'package:app_cham_cong_option_2/data/view_models/auth_view_model.dart';
import 'package:app_cham_cong_option_2/data/view_models/work_todo_view_model.dart';
import 'package:app_cham_cong_option_2/data/view_models/work_view_model.dart';
import 'package:app_cham_cong_option_2/screen/work/components/card_work.dart';
import 'package:app_cham_cong_option_2/screen/work/detail_work_screen.dart';
import 'package:app_cham_cong_option_2/screen/work/work_calender_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class WorkScreen extends StatefulWidget {
  const WorkScreen({Key? key}) : super(key: key);

  @override
  State<WorkScreen> createState() => _WorkScreenState();
}

class _WorkScreenState extends State<WorkScreen> {
  var now = DateTime.now();

  Future<String> getdayWeek(DateTime startDay, DateTime endDay) async {
    String stringRangeDayWeek;

    var now_1w = startDay.add(const Duration(days: 6));

    if (now.year == now_1w.year) {
      stringRangeDayWeek = DateFormat('dd/MM').format(startDay) +
          "-" +
          DateFormat('dd/MM/yyyy').format(now_1w);
    } else {
      stringRangeDayWeek = DateFormat('dd/MM/yyyy').format(startDay) +
          "-" +
          DateFormat('dd/MM/yyyy').format(now_1w);
    }
    return stringRangeDayWeek;
  }

  void getdayMonth(DateTime startDay, DateTime endDay) {
    List<String> listDay = [];

    String stringRangeDayMonth;

    var now_1m = DateTime(startDay.year, startDay.month + 1, startDay.day);

    if (now.year == now_1m.year) {
      stringRangeDayMonth = DateFormat('dd/MM').format(now) +
          "-" +
          DateFormat('dd/MM/yyyy').format(now_1m);
    } else {
      stringRangeDayMonth = DateFormat('dd/MM/yyyy').format(now) +
          "-" +
          DateFormat('dd/MM/yyyy').format(now_1m);
    }
  }

  void getdayYear(DateTime startDay, DateTime endDay) {
    List<String> listDay = [];

    String stringRangeDayMonth;

    var now_1y = DateTime(startDay.year + 1, startDay.month, startDay.day);

    var stringRangeDayYear = DateFormat('dd/MM/yyyy').format(now) +
        "-" +
        DateFormat('dd/MM/yyyy').format(now_1y);
  }
  // void getdayWeek(DateTime startDay, DateTime endDay) {

  //   List<String> listDay = [];

  //   String stringRangeDayWeek;
  //   String stringRangeDayMonth;
  //   var now_1w = startDay.add(const Duration(days: 6));
  //   var now_1m = DateTime(startDay.year, startDay.month + 1, startDay.day);
  //   var now_1y = DateTime(startDay.year + 1, startDay.month, startDay.day);

  //   var stringRangeDayYear = DateFormat('dd/MM/yyyy').format(now) +
  //       "-" +
  //       DateFormat('dd/MM/yyyy').format(now_1y);

  //   if (now.year == now_1w.year) {
  //     stringRangeDayWeek = DateFormat('dd/MM').format(now) +
  //         "-" +
  //         DateFormat('dd/MM/yyyy').format(now_1w);
  //   } else {
  //     stringRangeDayWeek = DateFormat('dd/MM/yyyy').format(now) +
  //         "-" +
  //         DateFormat('dd/MM/yyyy').format(now_1w);
  //   }

  //   if (now.year == now_1m.year) {
  //     stringRangeDayMonth = DateFormat('dd/MM').format(now) +
  //         "-" +
  //         DateFormat('dd/MM/yyyy').format(now_1m);
  //   } else {
  //     stringRangeDayMonth = DateFormat('dd/MM/yyyy').format(now) +
  //         "-" +
  //         DateFormat('dd/MM/yyyy').format(now_1m);
  //   }
  // }
  void share2() {
    // var groupByDate = groupBy(dataSet, (obj) => obj['time'].substring(0, 10));
    // print(groupByDate);
    // groupByDate.forEach((date, list) {
    //   // Header
    //   print('${date}:');

    //   // Group
    //   list.forEach((listItem) {
    //     // List item
    //     print('${listItem["time"]}, ${listItem["message"]}');
    //   });
    //   // day section divider
    //   print('\n');
    // });
  }

  @override
  Widget build(BuildContext context) {
    AuthViewModel authViewModel = context.watch<AuthViewModel>();
    WorkViewModel workViewModel = context.watch<WorkViewModel>();
    //WorkTodoViewModel workTodoViewModel = context.watch<WorkTodoViewModel>();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                  barrierDismissible: false,
                  barrierColor: Colors.blueGrey.withOpacity(0.1),
                  context: context,
                  builder: (conttext) => Center(
                          child: AlertDialog(
                        insetPadding: EdgeInsets.zero,
                        contentPadding: EdgeInsets.zero,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        backgroundColor: Colors.transparent,
                        content: Material(
                          borderRadius: BorderRadius.circular(15),
                          elevation: 8,
                          child: Container(
                            width: MediaQuery.of(context).size.width - 30,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: const [ShowAlertTwo()],
                            ),
                          ),
                        ),
                      )));
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: ((context) => const DetailWorkScreen())));
            },
            child: const Icon(Icons.add)),
        body: _uiList(workViewModel, authViewModel, size));
  }

  _uiList(WorkViewModel workViewModel, AuthViewModel authViewModel, Size size) {
    if (workViewModel.loading) {
      return const Center(
        child: CircularProgressIndicator(
          color: kBackgroundColor,
        ),
      );
    } else {
      return NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  pinned: true,
                  automaticallyImplyLeading:
                      false, // Don't show the leading button
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: InkWell(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.arrow_back_ios,
                              color: Colors.white),
                        ),
                      ),
                      const Text(
                        "Công việc",
                        style: TextStyle(fontSize: 12),
                      )
                      // Your widgets here
                    ],
                  ),
                  systemOverlayStyle: const SystemUiOverlayStyle(
                      statusBarIconBrightness: Brightness.light,
                      statusBarColor: Colors.transparent),
                  flexibleSpace: FlexibleSpaceBar(
                    // Tạo 1 khoảng trống linh hoạt
                    background: Padding(
                        padding: const EdgeInsets.all(35),
                        child: _ui(authViewModel)),
                  ),
                  expandedHeight: 195,
                  titleSpacing: 0,
                )
              ],
          body: RefreshIndicator(
            onRefresh: () {
              return Future.delayed(
                const Duration(seconds: 1),
                () {
                  workViewModel.getWorks(context);
                },
              );
            },
            child: workViewModel.workListModel.isNotEmpty
                ? ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: workViewModel.workListModel.length,
                    itemBuilder: (context, index) {
                      Work work = workViewModel.workListModel[index];
                      return InkWell(
                        onTap: () {
                          workViewModel.setSelectedWork(work);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailWorkScreen(
                                        index: index,
                                      )));
                        },
                        child: CardWork(
                          dateTime: work.dateTime!,
                          title: work.name!,
                          date: "Thời gian: " +
                              work.startDay!.toString() +
                              " - " +
                              work.endDay!.toString(),
                          status: work.status!,
                        ),
                      );
                    })
                : const Center(
                    child: Text("Chưa có công việc nào được tạo"),
                  ),
          ));
    }
  }

  _ui(AuthViewModel authViewModel) {
    if (authViewModel.loading) {
      return const Center(
        child: CircularProgressIndicator(
          color: kBackgroundColor,
        ),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 50,
          ),
          Text(
            authViewModel.userModel.name.toString(),
            style: const TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            authViewModel.userModel.position!.toString(),
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    highlightColor: Colors.white,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WorkCalenderScreen())),
                    icon: SvgPicture.asset("assets/icons/Path 42.svg")),
              ],
            ),
          )
        ],
      );
    }
  }
}

class ShowAlertTwo extends StatefulWidget {
  const ShowAlertTwo({Key? key}) : super(key: key);

  @override
  State<ShowAlertTwo> createState() => _ShowAlertTwoState();
}

class _ShowAlertTwoState extends State<ShowAlertTwo> {
  Timer? _timer;
  String? chooseStartDay;
  String? chooseEndDay;

  DateTime now = DateTime.now();
  DateTime selectedDayStart = DateTime.now();
  DateTime focusedDayStart = DateTime.now();

  DateTime selectedDayEnd = DateTime.now();
  DateTime focusedDayEnd = DateTime.now();

  final TextEditingController _editnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var workViewModel = Provider.of<WorkViewModel>(context, listen: false);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text(
        "Tên dự án",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
      const SizedBox(
        height: 10,
      ),
      TextField(
        controller: _editnameController,
        decoration: const InputDecoration(
            border: OutlineInputBorder(
          borderSide: BorderSide(color: kBackgroundColor, width: 5.0),
        )),
      ),
      const SizedBox(
        height: 20,
      ),
      Row(
        children: [
          const Text("Ngày bắt đầu :", style: TextStyle(fontSize: 15)),
          const SizedBox(
            width: 10,
          ),
          Material(
            child: InkWell(
              onTap: () {
                showDialog(
                    barrierColor: Colors.blueGrey.withOpacity(0.1),
                    context: context,
                    builder: (conttext) => Center(
                          child: AlertDialog(
                            insetPadding: EdgeInsets.zero,
                            contentPadding: EdgeInsets.zero,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            backgroundColor: Colors.transparent,
                            content: Material(
                              borderRadius: BorderRadius.circular(15),
                              elevation: 8,
                              child: Container(
                                width: MediaQuery.of(context).size.width - 30,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TableCalendar(
                                      locale: 'vi',
                                      //Sự kiện nhấn vào ngày đã chọn
                                      selectedDayPredicate: (day) {
                                        return isSameDay(selectedDayStart, day);
                                      },
                                      calendarFormat: CalendarFormat.month,
                                      startingDayOfWeek:
                                          StartingDayOfWeek.monday,
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
                                          headerPadding:
                                              EdgeInsets.symmetric(vertical: 0),
                                          formatButtonVisible: false,
                                          titleCentered: true,
                                          titleTextStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                          decoration: BoxDecoration(
                                              color: Colors.white)),
                                      daysOfWeekStyle: const DaysOfWeekStyle(
                                          weekendStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                          weekdayStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                      firstDay: DateTime.utc(2010, 10, 16),
                                      lastDay: DateTime.utc(2030, 3, 14),
                                      focusedDay: focusedDayStart,

                                      calendarBuilders: CalendarBuilders(
                                        headerTitleBuilder: (context, day) {
                                          return Center(
                                            child: Text(
                                              "Tháng" +
                                                  DateFormat(' MM - yyyy')
                                                      .format(day),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: Colors.black),
                                            ),
                                          );
                                        },
                                        todayBuilder:
                                            (context, day, focusedDay) {
                                          return Container(
                                            margin: const EdgeInsets.all(6),
                                            decoration: const BoxDecoration(
                                                color: Color(0xFFBBDDFF),
                                                shape: BoxShape.circle),
                                            child: Center(
                                              child: Text(
                                                day.day.toString(),
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          );
                                        },
                                        selectedBuilder:
                                            (context, day, focusedDay) {
                                          return Container(
                                            margin: const EdgeInsets.all(6),
                                            decoration: const BoxDecoration(
                                                color: kBackgroundColor,
                                                shape: BoxShape.circle),
                                            child: Center(
                                              child: Text(
                                                day.day.toString(),
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          );
                                        },
                                        dowBuilder: (context, day) {
                                          if (day.weekday == DateTime.monday) {
                                            return const Center(
                                              child: Text(
                                                "T2",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            );
                                          } else if (day.weekday ==
                                              DateTime.tuesday) {
                                            return const Center(
                                              child: Text("T3",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            );
                                          } else if (day.weekday ==
                                              DateTime.wednesday) {
                                            return const Center(
                                              child: Text("T4",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            );
                                          } else if (day.weekday ==
                                              DateTime.thursday) {
                                            return const Center(
                                              child: Text("T5",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            );
                                          } else if (day.weekday ==
                                              DateTime.friday) {
                                            return const Center(
                                              child: Text("T6",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            );
                                          } else if (day.weekday ==
                                              DateTime.saturday) {
                                            return const Center(
                                              child: Text("T7",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            );
                                          } else {
                                            return const Center(
                                              child: Text("CN",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            );
                                          }
                                        },
                                      ),

                                      // calendarStyle: CalendarStyle(
                                      //     canMarkersOverflow: true,
                                      //     markerDecoration: BoxDecoration(color: Colors.red)),
                                      onDaySelected: (selectDay, focusDay) {
                                        setState(() {
                                          selectedDayStart = selectDay;
                                          focusedDayStart = focusDay;

                                          chooseStartDay =
                                              DateFormat('dd/MM/yyyy')
                                                  .format(selectedDayStart)
                                                  .toString();

                                          Navigator.pop(context);
                                        });

                                        //print(focusedDay);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ));
              },
              child: Row(
                children: [
                  chooseStartDay != null
                      ? Text(
                          chooseStartDay!,
                          style: const TextStyle(color: Colors.black),
                        )
                      : Container(),
                  const Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Icon(Icons.keyboard_arrow_down_rounded),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      const SizedBox(
        height: 20,
      ),
      Row(
        children: [
          const Text("Ngày kết thúc :", style: TextStyle(fontSize: 15)),
          const SizedBox(
            width: 10,
          ),
          Material(
            child: InkWell(
              onTap: () {
                showDialog(
                    barrierColor: Colors.blueGrey.withOpacity(0.1),
                    context: context,
                    builder: (conttext) => Center(
                          child: AlertDialog(
                            insetPadding: EdgeInsets.zero,
                            contentPadding: EdgeInsets.zero,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            backgroundColor: Colors.transparent,
                            content: Material(
                              borderRadius: BorderRadius.circular(15),
                              elevation: 8,
                              child: Container(
                                width: MediaQuery.of(context).size.width - 30,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TableCalendar(
                                      locale: 'vi',
                                      //Sự kiện nhấn vào ngày đã chọn
                                      selectedDayPredicate: (day) {
                                        return isSameDay(selectedDayEnd, day);
                                      },
                                      calendarFormat: CalendarFormat.month,
                                      startingDayOfWeek:
                                          StartingDayOfWeek.monday,
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
                                          headerPadding:
                                              EdgeInsets.symmetric(vertical: 0),
                                          formatButtonVisible: false,
                                          titleCentered: true,
                                          titleTextStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                          decoration: BoxDecoration(
                                              color: Colors.white)),
                                      daysOfWeekStyle: const DaysOfWeekStyle(
                                          weekendStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                          weekdayStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                      firstDay: DateTime.utc(2010, 10, 16),
                                      lastDay: DateTime.utc(2030, 3, 14),
                                      focusedDay: focusedDayEnd,

                                      calendarBuilders: CalendarBuilders(
                                        headerTitleBuilder: (context, day) {
                                          return Center(
                                            child: Text(
                                              "Tháng" +
                                                  DateFormat(' MM - yyyy')
                                                      .format(day),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: Colors.black),
                                            ),
                                          );
                                        },
                                        todayBuilder:
                                            (context, day, focusedDay) {
                                          return Container(
                                            margin: const EdgeInsets.all(6),
                                            decoration: const BoxDecoration(
                                                color: Color(0xFFBBDDFF),
                                                shape: BoxShape.circle),
                                            child: Center(
                                              child: Text(
                                                day.day.toString(),
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          );
                                        },
                                        selectedBuilder:
                                            (context, day, focusedDay) {
                                          return Container(
                                            margin: const EdgeInsets.all(6),
                                            decoration: const BoxDecoration(
                                                color: kBackgroundColor,
                                                shape: BoxShape.circle),
                                            child: Center(
                                              child: Text(
                                                day.day.toString(),
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          );
                                        },
                                        dowBuilder: (context, day) {
                                          if (day.weekday == DateTime.monday) {
                                            return const Center(
                                              child: Text(
                                                "T2",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            );
                                          } else if (day.weekday ==
                                              DateTime.tuesday) {
                                            return const Center(
                                              child: Text("T3",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            );
                                          } else if (day.weekday ==
                                              DateTime.wednesday) {
                                            return const Center(
                                              child: Text("T4",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            );
                                          } else if (day.weekday ==
                                              DateTime.thursday) {
                                            return const Center(
                                              child: Text("T5",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            );
                                          } else if (day.weekday ==
                                              DateTime.friday) {
                                            return const Center(
                                              child: Text("T6",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            );
                                          } else if (day.weekday ==
                                              DateTime.saturday) {
                                            return const Center(
                                              child: Text("T7",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            );
                                          } else {
                                            return const Center(
                                              child: Text("CN",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            );
                                          }
                                        },
                                      ),

                                      // calendarStyle: CalendarStyle(
                                      //     canMarkersOverflow: true,
                                      //     markerDecoration: BoxDecoration(color: Colors.red)),
                                      onDaySelected: (selectDay, focusDay) {
                                        setState(() {
                                          selectedDayEnd = selectDay;
                                          focusedDayEnd = focusDay;

                                          chooseEndDay =
                                              DateFormat('dd/MM/yyyy')
                                                  .format(selectedDayEnd)
                                                  .toString();

                                          Navigator.pop(context);
                                        });

                                        //print(focusedDay);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ));
              },
              child: Row(
                children: [
                  chooseEndDay != null
                      ? Text(
                          chooseEndDay!,
                          style: const TextStyle(color: Colors.black),
                        )
                      : Container(),
                  const Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Icon(Icons.keyboard_arrow_down_rounded),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  minimumSize: const Size(50, 30)),
              child: const Text(
                "Hủy",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          const SizedBox(
            width: 5,
          ),
          TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: kBackgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  minimumSize: const Size(50, 30)),
              child: const Text(
                "Thêm",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                if (_editnameController.text.isEmpty ||
                    chooseStartDay == null ||
                    chooseEndDay == null) {
                  Fluttertoast.showToast(
                      msg: "Vui lòng nhập đầy đủ thông tin !",
                      backgroundColor: Colors.white,
                      textColor: Colors.black,
                      toastLength: Toast.LENGTH_SHORT, // length
                      gravity: ToastGravity.BOTTOM, // location
                      timeInSecForIosWeb: 1);
                } else {
                  var dateTime = DateFormat('hh:mm a - dd/MM/yyyy')
                      .format(now)
                      .toLowerCase();
                  FocusManager.instance.primaryFocus?.unfocus();
                  _timer?.cancel();
                  await EasyLoading.show(
                    status: 'Loading...',
                    maskType: EasyLoadingMaskType.black,
                  );
                  workViewModel
                      .createWork(context, _editnameController.text,
                          chooseStartDay, chooseEndDay, dateTime)
                      .whenComplete(() {
                    EasyLoading.dismiss();
                  });
                }
              })
        ],
      )
    ]);
  }
}
