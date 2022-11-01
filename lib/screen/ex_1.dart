import 'package:app_cham_cong_option_2/constant.dart';
import 'package:flutter/material.dart';

class DropDownWidget2 extends StatefulWidget {
  const DropDownWidget2({Key? key}) : super(key: key);

  @override
  State<DropDownWidget2> createState() => _DropDownWidget2State();
}

class _DropDownWidget2State extends State<DropDownWidget2>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool isOpen = false;

  final List<Map<String, dynamic>> _allData = [
    {"id": 1, "name": "Andy", "age": 29},
    {"id": 2, "name": "Aragon", "age": 40},
    {"id": 3, "name": "Bob", "age": 5},
    {"id": 4, "name": "Barbara", "age": 35},
    {"id": 5, "name": "Candy", "age": 21},
    {"id": 6, "name": "Colin", "age": 55},
    {"id": 7, "name": "Audra", "age": 30},
    {"id": 8, "name": "Banana", "age": 14},
    {"id": 9, "name": "Caversky", "age": 100},
    {"id": 10, "name": "Becky", "age": 32},
  ];

  // This list holds the data for the list view
  List<Map<String, dynamic>> _foundData = [];

  final layerLink = LayerLink();
  OverlayEntry? entry;

  void showOverLay() {
    final overlay = Overlay.of(context)!;
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    entry = OverlayEntry(
        builder: (context) => Positioned(
            width: size.width,
            child: CompositedTransformFollower(
                link: layerLink,
                showWhenUnlinked: false,
                offset: Offset(0, size.height),
                child: buildOverlay())));

    overlay.insert(entry!);
  }

  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) => showOverLay());
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
    _animation = Tween(begin: 0.0, end: -.5).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
    // _foundData = _allData;

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleOnPressed() {
    setState(() {
      isOpen = !isOpen;
      isOpen == true
          ? _animationController.forward()
          : _animationController.reverse();
      isOpen == true ? showOverLay() : hideOverlay();
      print(isOpen);
    });
  }

  void hideOverlay() {
    entry?.remove();
    entry = null;
  }

  Widget buildOverlay() {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Colors.black, width: 1),
      ),
      child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.only(left: 12, top: 4, bottom: 4),
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  onChanged: (value) => {},
                  decoration: const InputDecoration(
                      labelText: 'Search', suffixIcon: Icon(Icons.search)),
                ),
                _allData.isNotEmpty
                    ? ListView.separated(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _allData.length,
                        itemBuilder: (context, index) {
                          return Text(
                            _allData[index]['name'],
                            style: TextStyle(color: Colors.black),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                      )
                    : const Text(
                        'No results found',
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
              ],
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          child: CompositedTransformTarget(
            link: layerLink,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                //mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Select one from below'),
                  IconButton(
                    padding: EdgeInsets.zero,
                    iconSize: 18,
                    splashRadius: 10,
                    splashColor: Colors.greenAccent,
                    icon: RotationTransition(
                      turns: _animation,
                      child: const Icon(Icons.expand_more),
                    ),
                    onPressed: () => _handleOnPressed(),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget itemsWidget() {
    return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.only(left: 12, top: 4, bottom: 4),
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                onChanged: (value) => {},
                decoration: const InputDecoration(
                    labelText: 'Search', suffixIcon: Icon(Icons.search)),
              ),
              _allData.isNotEmpty
                  ? ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: _allData.length,
                      itemBuilder: (context, index) {
                        return Text(
                          _allData[index]['name'],
                          style: TextStyle(color: Colors.black),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                    )
                  : const Text(
                      'No results found',
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
            ],
          ),
        ));
  }
}
