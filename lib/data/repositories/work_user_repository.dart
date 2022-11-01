import 'package:app_cham_cong_option_2/data/models/work/work.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/api_response.dart';

abstract class WorkUserrepository {
  Future<ApiResponse> getAllUser();
  Future<ApiResponse> getWorkUser(int idWork);
  Future<ApiResponse> insertWorkUser(int idWork, idUser);
  Future<ApiResponse> deleteWorkUser(int idWorkUser);
}
