import 'package:app_cham_cong_option_2/data/models/components/user_model.dart';
import 'package:app_cham_cong_option_2/data/models/components/work_request.dart';
import 'package:flutter/material.dart';

class WorkDateProvider extends ChangeNotifier {
  String _deadLine = "";

  String get deadLine => _deadLine;

  set deadLine(String? date) {
    _deadLine = date!;
    notifyListeners();
  }
}

class WorkListTodoProvider extends ChangeNotifier {
  List<WorkRequest> listTodo = [];

  void addListCurrent(List<WorkRequest> list) {
    listTodo.addAll(list);
  }

  void addTask(String task) {
    listTodo.add(WorkRequest(content: task));
    notifyListeners();
  }
}

class WorkLinkProvider extends ChangeNotifier {
  String _linkProject = "";

  String get linkProject => _linkProject;

  set linkProject(String? link) {
    _linkProject = link!;
    notifyListeners();
  }
}

class WorkListMemberTaskProvider extends ChangeNotifier {
  List<UserModel> listMember = [];

  void addMembder(UserModel user) {
    listMember.add(user);
    notifyListeners();
  }

  void removeMember(UserModel user) {
    listMember.remove(user);
    notifyListeners();
  }
}
