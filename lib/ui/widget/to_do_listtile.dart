import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/controller/cubit/todo_task/todo_cubit.dart';
import 'package:todolist/helper/color_helper.dart';
import 'package:todolist/helper/text_style_helper.dart';
import 'package:todolist/model/todo_model.dart';
import 'package:todolist/ui/widget/shared_widget/dailog_toaster.dart';

// ignore: must_be_immutable
class AddTaskListTile extends StatelessWidget {
  AddTaskListTile(
      {super.key, required this.task, required this.deleteController});

  final ToDoModel task;
  AnimationController deleteController;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        task.toDoText ?? '',
        style: TextStyleHelper.textStylefontSize14.copyWith(
          decoration: task.isDone == true
              ? TextDecoration.lineThrough
              : TextDecoration.none,
        ),
      ),
      subtitle: Column(
        children: [
          // Text(task.toDoDescription ?? ""),
          Text(task.category ?? ''),
        ],
      ),
      leading: Checkbox(
        value: task.isDone,
        onChanged: (value) {
          context.read<TaskCubit>().changeTaskDone(task);
        },
      ),
      trailing: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(0),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            color: Colors.red, borderRadius: BorderRadius.circular(5)),
        height: 35,
        width: 35,
        child: IconButton(
          onPressed: () {
            context.read<TaskCubit>().deleteTask(task.id!);
            CreateDialogToaster.showDeleteDialog(context, deleteController);
          },
          icon: Icon(
            Icons.delete,
            color: ColorHelper.white,
          ),
          iconSize: 18,
        ),
      ),
    );
  }
}
