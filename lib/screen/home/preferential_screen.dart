import 'package:app_cham_cong_option_2/components/appbar.dart';
import 'package:app_cham_cong_option_2/data/models/components/json.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PreferentialScreen extends StatelessWidget {
  const PreferentialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        tittle: "Ưu đãi cá nhân",
        elevate: 0,
        centerTitle: false,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: ListView.separated(
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  print(listGift[index].code);
                },
                child: Image.asset(listGift[index].images),
              );
            },
            itemCount: listGift.length,
            separatorBuilder: (context, index) => const SizedBox(
                  height: 20,
                )),
      ),
    );
  }
}
