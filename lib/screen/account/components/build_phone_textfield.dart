import 'package:app_cham_cong_option_2/constant.dart';
import 'package:flutter/material.dart';

class PhoneTextFieldWidget extends StatefulWidget {
  final String label;
  final String text;
  final int maxLines;
  final ValueChanged<String> onChanged;
  const PhoneTextFieldWidget({
    Key? key,
    required this.label,
    required this.text,
    required this.onChanged,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  State<PhoneTextFieldWidget> createState() => _PhoneTextFieldWidgetState();
}

class _PhoneTextFieldWidgetState extends State<PhoneTextFieldWidget> {
  late final TextEditingController myController;
  late FocusNode _focusNode;
  @override
  void initState() {
    super.initState();
    myController = TextEditingController(text: widget.text);
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        TextField(
          focusNode: _focusNode,
          controller: myController,
          maxLines: widget.maxLines,
          onChanged: widget.onChanged,
          keyboardType: TextInputType.number,
          style: const TextStyle(fontSize: 15, height: 1.5),
          decoration: InputDecoration(
            suffixIcon: _focusNode.hasFocus && myController.text.isNotEmpty
                ? IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    onPressed: () {
                      myController.clear();
                      setState(() {});
                    },
                    icon: const Icon(Icons.cancel, color: kSwitchColor))
                : null,
          ),
        )
      ],
    );
  }
}
