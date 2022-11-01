import 'dart:io';

import 'package:app_cham_cong_option_2/data/service/web_api/api_response.dart';

abstract class WorkImageRepository {
  Future<ApiResponse> getAllWorkImage(int idWork);
  Future<ApiResponse> uploadWorkImage(int idWork, File image);
  Future<ApiResponse> deleteWorkImage(int idTodo);
}
