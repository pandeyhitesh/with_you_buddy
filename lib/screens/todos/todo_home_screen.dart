import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:my_new_project/common/methods.dart';
import 'package:my_new_project/constants/hive_keys/hive_keys.dart';
import 'package:my_new_project/screens/todos/todo_create_new.dart';
import 'package:my_new_project/screens/todos/widgets/appbar_button.dart';
import 'package:my_new_project/screens/todos/widgets/todo_card.dart';
import 'package:my_new_project/services/storage_service/hive_service.dart';
import 'package:my_new_project/states/controller/todo_controller.dart';
import 'package:my_new_project/states/models/todos/priority_model.dart';
import 'package:my_new_project/states/models/todos/todo_model.dart';
import 'package:my_new_project/theme/theme_constants.dart';
import 'dart:developer' as developer;

import '../../states/controller/utilities/priority_view_controller.dart';

class TodoHomeScreen extends StatefulWidget {
  const TodoHomeScreen({super.key});

  @override
  State<TodoHomeScreen> createState() => _TodoHomeScreenState();
}

class _TodoHomeScreenState extends State<TodoHomeScreen> {
  TodoController todoController = Get.find();

  @override
  void initState() {
    initializeTodos();
    super.initState();
  }

  void initializeTodos() async {
    final todos = await HiveService.getTodosFromLocal();
    developer.log('Todos from local = $todos');
    for (var todo in todos) {
      developer.log('Todos from local = ${todo.id}');
    }

    TodoController controller = Get.find();
    controller.setTodos(todos);
    developer.log('TodoController was set.');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('TODOs'),
          centerTitle: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: IconButton(
                visualDensity: VisualDensity.compact,
                splashRadius: 22,
                onPressed: () async {
                  todoController.clearTodos();
                  await HiveService.clearAllTodos();
                },
                icon: const Icon(
                  FontAwesomeIcons.gear,
                  size: 18,
                ),
              ),
            ),
          ],
          bottom: displayPrioritySelectionPanel(),
        ),
        body: SizedBox(
          height: CommonMethods.screenHeight,
          width: CommonMethods.screenWidth,
          child: Padding(
            padding: EdgeInsets.all(ThemeConstants.defaultContentPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 3,
                  // height: ThemeConstants.defaultHorPadding -
                  //     ThemeConstants.defaultVerticalSpacing,
                ),
                Expanded(
                  child: Obx(
                    () {
                      TodoController todoController = Get.find();
                      PriorityViewController priorityController = Get.find();
                      // String displayPriority = priorityController.item.value;
                      PriorityEnum? displayPriority =
                          priorityController.item.value;
                      List<TodoModel> allTodos = todoController.todos;
                      List<TodoModel> todoListToDisplay = [];
                      if (displayPriority == null) {
                        todoListToDisplay = allTodos;
                      } else {
                        todoListToDisplay = allTodos
                            .where((element) =>
                                element.priority == displayPriority)
                            .toList();
                      }

                      return SingleChildScrollView(
                        child: StaggeredGrid.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 15,
                          crossAxisSpacing:
                              ThemeConstants.defaultContentPadding,

                          children: todoListToDisplay
                              .map((todo) => todoCard(context, todo))
                              .toList(),
                          // children: [
                          //   StaggeredGridTile.fit(
                          //     crossAxisCellCount: 1,
                          //     child: Container(
                          //       height: 100,
                          //       color: Colors.red,
                          //       child: Text('hello'),
                          //     ),
                          //   ),
                          //   StaggeredGridTile.fit(
                          //     crossAxisCellCount: 1,
                          //     child: Container(
                          //       height: 200,
                          //       color: Colors.red,
                          //       child: Text('hello'),
                          //     ),
                          //   ),
                          //   StaggeredGridTile.fit(
                          //     crossAxisCellCount: 1,
                          //     child: Container(
                          //       height: 150,
                          //       color: Colors.red,
                          //       child: Text('hello'),
                          //     ),
                          //   ),
                          //   StaggeredGridTile.fit(
                          //     crossAxisCellCount: 1,
                          //     child: Container(
                          //       height: 250,
                          //       color: Colors.red,
                          //       child: Text('hello'),
                          //     ),
                          //   ),
                          // ],
                        ),
                      );

                      // return ListView.builder(
                      //   itemCount: todoListToDisplay.length,
                      //   itemBuilder: (context, index) {
                      //     return todoCard(
                      //       context,
                      //       todoListToDisplay[index],
                      //     );
                      //   },
                      // );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        // floatingActionButton: FloatingActionButton.extended(
        //   label: Text('+ New TODO'),
        //   onPressed: () {},
        // ),
        floatingActionButton: FloatingActionButton(
          // label: Text('+ New TODO'),
          child: const Icon(FontAwesomeIcons.pencil),
          onPressed: () {
            createNewTodo(
              context: context,
            );
          },
        ),
      ),
    );
  }

  PreferredSizeWidget displayPrioritySelectionPanel() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(50),
      child: Container(
        color: Colors.transparent,
        height: 50,
        width: CommonMethods.screenWidth,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            appbarPrioritySelectionButton(title: 'All'),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 5, 12, 5),
              color: Colors.white70,
              width: 1.3,
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: defaultPriorities.length,
                itemBuilder: (context, index) {
                  return appbarPrioritySelectionButton(
                    title: defaultPriorities[index].title,
                    priority: defaultPriorities[index].priority,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
