import 'package:app_cham_cong_option_2/data/models/components/user_model.dart';
import 'package:app_cham_cong_option_2/data/models/work_ex/user_work.dart';

abstract class UserRepository {
  Future<List<UserWork>> getUserForWork();
  Future<UserModel> getUsers();
}
