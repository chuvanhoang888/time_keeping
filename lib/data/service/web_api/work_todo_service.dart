import 'package:app_cham_cong_option_2/data/models/work/todo.dart';
import 'package:app_cham_cong_option_2/data/repositories/work_todo_repository.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/api_response.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/auth_service.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/global.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class WorkTodoService implements WorkTodoRepository {
  ApiResponse apiResponse = ApiResponse();
  @override
  Future<ApiResponse> getAllTodo(int idWork) async {
    final dio = Dio();
    try {
      String token = await AuthService().getToken();
      final response = await dio.get(Config.workTodoURL + "/$idWork",
          options: Options(headers: {
            'content-type': 'application/json',
            'Authorization': 'Bearer $token'
          }));
      if (response.statusCode == 200) {
        var data = response.data;

        apiResponse.data = await data["work-todos"].map<Todo>((json) {
          return Todo.fromJson(json);
        }).toList();
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 401) {
        apiResponse.error = Config.unauthorized;
      } else {
        apiResponse.error = e.toString();
      }
    }
    return apiResponse;
  }

  //create post
  @override
  Future<ApiResponse> createTodo(int idWork, String content) async {
    ApiResponse apiResponse = ApiResponse();
    final dio = Dio();
    try {
      String token = await AuthService().getToken();

      FormData formData = FormData.fromMap({
        "content": content,
      });

      final response = await dio.post(Config.workTodoURL + "/$idWork",
          options: Options(headers: {
            'content-type': 'application/json',
            'Authorization': 'Bearer $token'
          }),
          data: formData);

      if (response.statusCode == 200) {
        var data = response.data;
        apiResponse.data = Todo.fromJson(data['work-todo']);
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 422) {
        var data = e.response!.data;
        final errors = data['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
      } else if (e.response!.statusCode == 401) {
        apiResponse.error = Config.unauthorized;
      } else {
        apiResponse.error = e.toString();
      }
    }
    return apiResponse;
  }
  // edit Post

  @override
  Future<ApiResponse> editTodo(Todo todo) async {
    ApiResponse apiResponse = ApiResponse();
    final dio = Dio();
    try {
      String token = await AuthService().getToken();

      final response = await dio.put(
          Config.workTodoURL + "/" + todo.id.toString(),
          options: Options(headers: {
            'content-type': 'application/json',
            'Authorization': 'Bearer $token'
          }),
          data: todo.toJson());
      debugPrint(todo.toJson().toString());

      if (response.statusCode == 200) {
        var data = response.data;
        apiResponse.data = data['message'];
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 403) {
        var data = e.response!.data;
        final errors = data['message'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
      } else if (e.response!.statusCode == 401) {
        apiResponse.error = Config.unauthorized;
      } else {
        apiResponse.error = e.toString();
      }
    }
    return apiResponse;
  }

  // Delete post
  @override
  Future<ApiResponse> deleteTodo(int idTodo) async {
    ApiResponse apiResponse = ApiResponse();
    final dio = Dio();
    try {
      String token = await AuthService().getToken();
      final response = await dio.delete(
          Config.workTodoURL + "/" + idTodo.toString(),
          options: Options(headers: {
            'content-type': 'application/json',
            'Authorization': 'Bearer $token'
          }));

      if (response.statusCode == 200) {
        var data = response.data;
        apiResponse.data = data['message'];
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 403) {
        var data = e.response!.data;
        final errors = data['message'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
      } else if (e.response!.statusCode == 401) {
        apiResponse.error = Config.unauthorized;
      } else {
        apiResponse.error = e.toString();
      }
    }
    return apiResponse;
  }
}
