import 'package:app_cham_cong_option_2/data/view_models/permission_view_model.dart';
import 'package:app_cham_cong_option_2/screen/home/components/permission_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MailContent extends StatefulWidget {
  const MailContent({
    Key? key,
    required this.date,
    required this.widget,
  }) : super(key: key);

  final String date;
  final PermissionFormScreen widget;

  @override
  State<MailContent> createState() => _MailContentState();
}

class _MailContentState extends State<MailContent> {
  DateTime now = DateTime.now();
  final TextEditingController _editTextContentController =
      TextEditingController();

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _editTextContentController.text =
        "Dear Toàn Nguyễn ,\n\nTôi tên Thanh Lê bộ phận thiết kế. Tôi làm đơn này xin phép anh (chị)  được nghỉ ngày " +
            DateFormat(' dd/MM/yyyy').format(widget.widget.startDay) +
            " đến ngày " +
            DateFormat(' dd/MM/yyyy').format(widget.widget.endDay) +
            ". Vì lý do …….. nên tôi làm đơn này. Mong anh (chị) duyệt qua." +
            "\n\nSau khi đi làm lại. Tôi sẽ đảm bảo yêu cầu và tiến độ công việc." +
            "\n\n\n Họ và Tên " +
            "\n\n Chức vụ";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PermissionViewModel notificationViewModel =
        context.watch<PermissionViewModel>();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormat('hh:mm a').format(now),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            widget.date,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(
            height: 15,
          ),
          const Text("ĐƠN XIN PHÉP",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
          const SizedBox(
            height: 15,
          ),
          Scrollbar(
              controller: _scrollController,
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: _editTextContentController,
                decoration: const InputDecoration(border: InputBorder.none),
              )),
          // RichText(
          //   text: TextSpan(
          //     text:
          //         'Tôi tên Thanh Lê bộ phận thiết kế. Tôi làm đơn này xin phép anh (chị)  được nghỉ ngày ',
          //     style:
          //         const TextStyle(color: Colors.black, fontSize: 14, height: 2),
          //     children: <TextSpan>[
          //       TextSpan(
          //           text: DateFormat(' dd/MM/yyyy')
          //               .format(widget.widget.startDay),
          //           style:
          //               TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          //       TextSpan(text: " đến ngày ", style: TextStyle(height: 2)),
          //       TextSpan(
          //           text:
          //               DateFormat(' dd/MM/yyyy').format(widget.widget.endDay),
          //           style: TextStyle(
          //               fontSize: 14, fontWeight: FontWeight.bold, height: 2)),
          //       TextSpan(
          //           text:
          //               ". Vì lý do …….. nên tôi làm đơn này. Mong anh (chị) duyệt qua.",
          //           style: TextStyle(height: 2))
          //     ],
          //   ),
          // ),
          // Text(
          //   "Dear Toàn Nguyễn ,Tôi tên Thanh Lê bộ phận thiết kế. Tôi làm đơn này xin phép anh (chị)  được nghỉ ngày " +
          //       DateFormat(' dd/MM/yyyy').format(widget.startDay) +
          //       " đến ngày " +
          //       DateFormat(' dd/MM/yyyy').format(widget.endDay) +
          //       ". Vì lý do …….. nên tôi làm đơn này. Mong anh (chị) duyệt qua.",
          //   style: TextStyle(height: 2),
          // ),
          // const SizedBox(
          //   height: 10,
          // ),
          // Text(
          //   "Sau khi đi làm lại. Tôi sẽ đảm bảo yêu cầu và tiến độ công việc.",
          //   style: TextStyle(height: 2),
          // ),
          // const SizedBox(
          //   height: 20,
          // ),
          // const Divider(
          //   height: 1,
          // ),
          // const SizedBox(
          //   height: 10,
          // ),
          // Text(
          //   "Thanh Lê",
          //   style: TextStyle(height: 2),
          // ),
          // const SizedBox(
          //   height: 5,
          // ),
          // Text(
          //   "Bộ phận thiết kế",
          //   style: TextStyle(height: 2),
          // ),
        ],
      ),
    );
  }
}
