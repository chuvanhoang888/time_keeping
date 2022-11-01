import 'package:json_annotation/json_annotation.dart';
part 'user_work.g.dart';

@JsonSerializable(explicitToJson: true)
class UserWork {
  late String name;
  late String email;
  late String photo;
  bool selected;

  UserWork(
      {required this.name,
      required this.email,
      required this.photo,
      this.selected = false});

  factory UserWork.fromJson(Map<String, dynamic> json) =>
      _$UserWorkFromJson(json);

  Map<String, dynamic> toJson() => _$UserWorkToJson(this);
}

List<UserWork> listUser = [
  UserWork(
      name: "Chu Văn Hoàng",
      email: "chuvanhoang888@gmail.com",
      photo:
          "https://thuthuatnhanh.com/wp-content/uploads/2021/07/hinh-ve-doraemon-cute-don-gian.png"),
  UserWork(
      name: "Nguyễn Xuân Tân",
      email: "nxtam@gmail.com",
      photo:
          "https://images2.content-hci.com/commimg/myhotcourses/blog-inline/myhc_19382.jpg"),
  UserWork(
      name: "Trần Nhật Tâm",
      email: "tntam@gmail.com",
      photo:
          "https://img.nhandan.com.vn/Files/Images/2020/07/26/nhat_cay-1595747664059.jpg"),
  UserWork(
      name: "Lê Thanh Tuyền",
      email: "lttuyen@gmail.com",
      photo:
          "https://static.chotot.com/storage/chotot-kinhnghiem/c2c/2021/10/c3b50238-chim-vang-anh-1.jpg"),
  UserWork(
      name: "Trần Thị Thanh Thu",
      email: "tttthu@gmail.com",
      photo: "https://i.ytimg.com/vi/RaoBKCKIDAI/maxresdefault.jpg"),
  UserWork(
      name: "Nguyễn Thị Thảo Vy",
      email: "nttvy@gmail.com",
      photo:
          "https://petmaster.vn/petroom/wp-content/uploads/2020/04/meo-anh-1.jpg"),
  UserWork(
      name: "Nguyễn Đức Mạnh",
      email: "ndmanh@gmail.com",
      photo:
          "https://img.websosanh.vn/v2/users/review/images/vwey9j9x0vwfb.jpg?compress=85"),
  UserWork(
      name: "Nguyễn Hữu Khương",
      email: "nhkhuong@gmail.com",
      photo:
          "https://i.pinimg.com/564x/d8/d6/db/d8d6db06adb51a273a0c4f6cdff1fbb8.jpg")
];
