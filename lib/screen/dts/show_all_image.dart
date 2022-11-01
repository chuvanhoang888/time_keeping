import 'dart:io';

import 'package:app_cham_cong_option_2/components/appbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ShowAllImages extends StatelessWidget {
  final List<XFile>? imageFileList;
  const ShowAllImages({Key? key, this.imageFileList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        tittle: "Tất cả hình ảnh",
        elevate: 0,
        centerTitle: false,
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return Image.file(
              File(imageFileList![index].path),
              fit: BoxFit.cover,
              width: double.infinity,
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 10,
            );
          },
          itemCount: imageFileList!.length),
    );
  }
}
