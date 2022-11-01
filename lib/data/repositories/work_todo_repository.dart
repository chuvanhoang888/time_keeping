import 'package:app_cham_cong_option_2/data/models/work/todo.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/api_response.dart';

abstract class WorkTodoRepository {
  Future<ApiResponse> getAllTodo(int idWork);
  Future<ApiResponse> createTodo(int idWork, String content);
  Future<ApiResponse> editTodo(Todo todo);
  Future<ApiResponse> deleteTodo(int idTodo);
}
