import 'package:app_cham_cong_option_2/data/models/work/todo.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/auth_service.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/global.dart';
import 'package:app_cham_cong_option_2/data/service/web_api/work_todo_service.dart';
import 'package:app_cham_cong_option_2/screen/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class WorkTodoViewModel extends ChangeNotifier {
  bool _loading = false;

  List<Todo> _todoListModel = [];

  bool get loading => _loading;

  List<Todo> get todoListModel => _todoListModel;

  // WorkTodoViewModel(context) {
  //   getTodos(context, selectedWork.id!);
  // }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setTodoListModel(List<Todo> todoListModel) {
    _todoListModel = todoListModel;
  }

  deleteTodoInList(Todo todo) {
    todoListModel.remove(todo);
    notifyListeners();
  }

  updateStateTodoList(int index, Todo todo) {
    var itemTodo = todoListModel.elementAt(index);
    itemTodo.content = todo.content;
    itemTodo.status = todo.status;
    notifyListeners();
  }

  addTodoToList(Todo todo) {
    todoListModel.insert(0, todo);
    notifyListeners();
  }

  getTodos(BuildContext context, int idWork) async {
    setLoading(true);
    var response = await WorkTodoService().getAllTodo(idWork);

    if (response.error == null) {
      setTodoListModel(response.data as List<Todo>);
    } else if (response.error == Config.unauthorized) {
      AuthService().logout().then((value) => {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false)
          });
    } else {
      Fluttertoast.showToast(
          msg: response.error!,
          textColor: Colors.black,
          backgroundColor: Colors.white,
          toastLength: Toast.LENGTH_LONG);
      debugPrint(response.error!);
    }
    setLoading(false);
  }

  Future<void> createTodo(context, int idWork, String content) async {
    var response = await WorkTodoService().createTodo(idWork, content);

    if (response.error == null) {
      Todo todo = response.data as Todo;
      addTodoToList(todo);
      //getTodos(context, idWork);

    } else if (response.error == Config.unauthorized) {
      AuthService().logout().then((value) => {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false)
          });
    } else {
      Fluttertoast.showToast(
          msg: response.error!,
          textColor: Colors.black,
          backgroundColor: Colors.white,
          toastLength: Toast.LENGTH_LONG);
      debugPrint(response.error!);
    }
  }

  Future<void> editTodo(context, Todo todo) async {
    var response = await WorkTodoService().editTodo(todo);

    if (response.error == null) {
      //getTodos(context, todo.workId!);
    } else if (response.error == Config.unauthorized) {
      AuthService().logout().then((value) => {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false)
          });
    } else {
      Fluttertoast.showToast(
          msg: response.error!,
          textColor: Colors.black,
          backgroundColor: Colors.white,
          toastLength: Toast.LENGTH_LONG);
      debugPrint(response.error!);
    }
  }

  Future<void> deleteTodo(context, Todo todo) async {
    var response = await WorkTodoService().deleteTodo(todo.id!);

    if (response.error == null) {
      //getTodos(context, todo.workId!);
    } else if (response.error == Config.unauthorized) {
      AuthService().logout().then((value) => {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false)
          });
    } else {
      Fluttertoast.showToast(
          msg: response.error!,
          textColor: Colors.black,
          backgroundColor: Colors.white,
          toastLength: Toast.LENGTH_LONG);
      debugPrint(response.error!);
    }
  }
}
