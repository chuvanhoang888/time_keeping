import 'package:app_cham_cong_option_2/data/service/web_api/api_response.dart';

abstract class PermissionMailRepository {
  Future<ApiResponse> getPermission();
  Future<ApiResponse> createPermission(String time, day, content, type, toMail);
  Future<ApiResponse> deletePermission(int id);
}
