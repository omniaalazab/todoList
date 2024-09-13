import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/controller/cubit/todo_task/todo_cubit.dart';
import 'package:todolist/controller/functions/check_empty_validation.dart';
import 'package:todolist/helper/color_helper.dart';
import 'package:todolist/helper/text_style_helper.dart';
import 'package:todolist/model/todo_model.dart';
import 'package:todolist/ui/widget/shared_widget/custom_elevated_button.dart';
import 'package:todolist/ui/widget/shared_widget/dailog_toaster.dart';
import 'package:todolist/ui/widget/shared_widget/text_field.dart';
import 'package:todolist/ui/widget/to_do_listtile.dart';

class ToDoTask extends StatefulWidget {
  const ToDoTask({super.key});

  @override
  State<ToDoTask> createState() => _ToDoTaskState();
}

class _ToDoTaskState extends State<ToDoTask> with TickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();

  TextEditingController addTaskController = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  bool? isDoneFilter;
  final List<String> categories = ['Work', 'Personal', 'Shopping', 'Other'];
  String? selectedCategory;
  late AnimationController deleteController;
  late AnimationController doneController;
  @override
  void initState() {
    context.read<TaskCubit>().loadTasks();
    super.initState();
    deleteController = AnimationController(
      vsync: this,
    );
    doneController = AnimationController(
      vsync: this,
    );
    doneController.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        Navigator.pop(context);
        doneController.reset();
      }
    });
    deleteController.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        Navigator.pop(context);
        deleteController.reset();
      }
    });
  }

  @override
  void dispose() {
    deleteController.dispose();
    doneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: CustomTextField(
                textHint: "Add task",
                textController: addTaskController,
                textFieldSuffix: const SizedBox(
                  width: 1,
                ),
                validatorFunction: (value) {
                  CheckEmptyValidationTextField.checkIsEmpty(value);
                  return null;
                }),
          ),
          CustomElevatedButton(
              widthButton: 20,
              buttonText: "+",
              onPressedFunction: () {
                if (addTaskController.text.isNotEmpty) {
                  final task = ToDoModel(
                    id: null,
                    toDoText: addTaskController.text,
                    toDoDescription: '',
                    category: selectedCategory,
                    isDone: false,
                  );

                  context.read<TaskCubit>().addTask(task);
                  setState(() {});
                  CreateDialogToaster.showDoneDialog(context, doneController);
                  addTaskController.clear();
                }
              },
              backColor: ColorHelper.mintGreen,
              fontColor: ColorHelper.white)
        ],
      ),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded,
                color: ColorHelper.white)),
        backgroundColor: ColorHelper.mintGreen,
        title: Text("To do Tasks",
            style: TextStyleHelper.textStylefontSize16
                .copyWith(color: ColorHelper.white)),
      ),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
          child: ListView(
            children: [
              Form(
                key: formState,
                child: Column(
                  children: [
                    CustomTextField(
                      textController: searchController,
                      textFieldSuffix: const SizedBox(
                        height: 1,
                      ),
                      textHint: "Search ",
                      textFieldPrefix: const Icon(Icons.search_rounded),
                      validatorFunction: (value) {
                        return null;
                      },
                      onChangedFunction: (value) {
                        context
                            .read<TaskCubit>()
                            .searchTasks(value, isDoneFilter);
                      },
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: DropdownButton<bool?>(
                        value: isDoneFilter,
                        hint: const Text("Filter by status"),
                        items: const [
                          DropdownMenuItem(value: null, child: Text("All")),
                          DropdownMenuItem(value: true, child: Text("Done")),
                          DropdownMenuItem(
                              value: false, child: Text("Not Done")),
                        ],
                        onChanged: (value) {
                          setState(() {
                            isDoneFilter = value;
                            context.read<TaskCubit>().searchTasks(
                                  searchController.text,
                                  isDoneFilter,
                                );
                          });
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: DropdownButton<String>(
                        value: selectedCategory,
                        hint: const Text("Select Category"),
                        items: categories.map((String category) {
                          return DropdownMenuItem<String>(
                            value: category,
                            child: Text(category),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedCategory = value;
                          });
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "All to Do",
                          style: TextStyleHelper.textStylefontSize18
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    BlocBuilder<TaskCubit, List<ToDoModel>>(
                        builder: (context, tasks) {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: tasks.length,
                          itemBuilder: (context, index) {
                            // final task = tasks[index];
                            return AddTaskListTile(
                              task: tasks[index],
                              deleteController: deleteController,
                            );
                          });
                    })
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
