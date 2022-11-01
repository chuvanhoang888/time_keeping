import 'package:app_cham_cong_option_2/data/service/web_api/api_response.dart';

abstract class AccountRepository {
  Future<ApiResponse> getPostForUser(int idUser);
}
