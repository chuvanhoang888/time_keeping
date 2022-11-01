import 'package:app_cham_cong_option_2/data/models/work/work.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/api_response.dart';

abstract class WorkRepository {
  Future<ApiResponse> getAllWork();
  Future<ApiResponse> createWork(String name, startDay, endDay, dayTime);
  Future<ApiResponse> editWork(Work work);
  Future<ApiResponse> deleteWork(int idWork);
}
