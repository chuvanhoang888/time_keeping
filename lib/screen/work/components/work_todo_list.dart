import 'package:app_cham_cong_option_2/data/models/work/todo.dart';
import 'package:app_cham_cong_option_2/data/view_models/work_todo_view_model.dart';
import 'package:app_cham_cong_option_2/screen/work/components/work_request_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WorkTodoList extends StatefulWidget {
  final int idWork;
  const WorkTodoList({Key? key, required this.idWork}) : super(key: key);

  @override
  State<WorkTodoList> createState() => _WorkTodoListState();
}

class _WorkTodoListState extends State<WorkTodoList> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WorkTodoViewModel>(context, listen: false)
          .getTodos(context, widget.idWork);
    });
  }

  @override
  Widget build(BuildContext context) {
    final workTodo = Provider.of<WorkTodoViewModel>(context, listen: true);
    return _uiTodo(workTodo);
  }

  _uiTodo(WorkTodoViewModel workTodoViewModel) {
    if (workTodoViewModel.loading) {
      return Container();
    } else {
      return Column(
        children: [
          workTodoViewModel.todoListModel.isNotEmpty
              ? const SizedBox(
                  height: 10,
                )
              : Container(),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              Todo todo = workTodoViewModel.todoListModel[index];
              return WorkRequestCard(
                index: index,
                todo: todo,
              );
            },
            itemCount: workTodoViewModel.todoListModel.length,
            separatorBuilder: (context, index) => const SizedBox(
              height: 15,
            ),
          ),
        ],
      );
    }
  }
}
