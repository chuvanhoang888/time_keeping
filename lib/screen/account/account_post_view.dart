import 'package:app_cham_cong_option_2/constant.dart';
import 'package:app_cham_cong_option_2/data/models/components/user_model.dart';
import 'package:app_cham_cong_option_2/data/view_models/account_view_model.dart';
import 'package:app_cham_cong_option_2/screen/dts/components/dts_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountPostView extends StatefulWidget {
  final UserModel userModel;
  const AccountPostView({Key? key, required this.userModel}) : super(key: key);

  @override
  State<AccountPostView> createState() => _AccountPostViewState();
}

class _AccountPostViewState extends State<AccountPostView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<AccountViewModel>(context, listen: false)
          .getPostForUser(context, widget.userModel.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var accountViewmodel =
        Provider.of<AccountViewModel>(context, listen: false);
    return Scaffold(
        backgroundColor: kSwitchColor.withOpacity(0.3),
        appBar: AppBar(
          backgroundColor: kBackgroundColor,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 80),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          decoration:
                              const BoxDecoration(color: kBackgroundColor),
                          width: double.infinity,
                          height: size.height * 0.15,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(80),
                          child: widget.userModel.image == null
                              ? Image.asset(
                                  "assets/images/doraemon.png",
                                  width: 160,
                                  height: 160,
                                  fit: BoxFit.fill,
                                  gaplessPlayback: true,
                                )
                              : Image.network(
                                  widget.userModel.image.toString(),
                                  width: 160,
                                  height: 160,
                                  fit: BoxFit.fill,
                                  gaplessPlayback: true,
                                ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      widget.userModel.name.toString(),
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.userModel.position.toString(),
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ])),
              const SizedBox(
                height: 15,
              ),
              _ui(accountViewmodel)
            ],
          ),
        ));
  }

  _ui(AccountViewModel accountViewModel) {
    if (accountViewModel.loading) {
      return const Center(
        child: CircularProgressIndicator(
          color: kBackgroundColor,
        ),
      );
    } else {
      return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return DtsContainer(
                post: accountViewModel.postListModel[index], index: index);
          },
          separatorBuilder: (context, index) => const SizedBox(
                height: 15,
              ),
          itemCount: accountViewModel.postListModel.length);
    }
  }
}
