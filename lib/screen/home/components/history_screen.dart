import 'package:app_cham_cong_option_2/constant.dart';
import 'package:app_cham_cong_option_2/screen/home/components/statistical_screen.dart';
import 'package:app_cham_cong_option_2/screen/home/components/timekeeping_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.transparent),
        elevation: 0.5,
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
              "Lịch sử chấm công",
              style: TextStyle(fontSize: 12, color: Colors.black),
            )
            // Your widgets here
          ],
        ),
        titleSpacing: 0,
      ),
      body: Column(
        children: [
          DecoratedBox(
            //This is responsible for the background of the tabbar, does the magic
            decoration: BoxDecoration(
              //This is for background color
              color: Colors.white.withOpacity(0.0),
              //This is for bottom border that is needed
              border: const Border(
                  bottom: BorderSide(color: kBorderTabColor, width: 0.5)),
            ),
            child: TabBar(
                indicatorWeight: 3.0,
                labelColor: kBackgroundColor,
                unselectedLabelColor: Colors.black,
                unselectedLabelStyle:
                    const TextStyle(fontWeight: FontWeight.normal),
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                controller: _tabController,
                tabs: const [
                  Tab(
                    text: "Chấm công",
                  ),
                  Tab(
                    text: "Bảng công",
                  )
                ]),
          ),
          Expanded(
            child: TabBarView(
                controller: _tabController,
                children: [TimekeepingScreen(), StatisticalScreen()]),
          ),
        ],
      ),
    );
  }
}
