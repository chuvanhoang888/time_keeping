import 'package:app_cham_cong_option_2/data/service/web_api/api_response.dart';

abstract class HistoryRepository {
  Future<ApiResponse> getHistory(String param);
}
