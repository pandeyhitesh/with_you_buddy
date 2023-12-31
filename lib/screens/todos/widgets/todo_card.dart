import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:my_new_project/common/methods.dart';
import 'package:my_new_project/screens/todos/todo_details_screen.dart';
import 'package:my_new_project/services/navigation_service.dart';
import 'package:my_new_project/theme/text_styles.dart';

import '../../../states/models/todos/todo_model.dart';
import '../../../theme/theme_constants.dart';
import 'dart:developer' as developer;

Widget todoCard(BuildContext context, TodoModel todo) => StaggeredGridTile.fit(
      crossAxisCellCount: 1,
      child: GestureDetector(
        onTap: () => showTodoDetails(
          context: context,
          todo: todo,
        ),
        child: Container(
          // height: 130,
          // margin: EdgeInsets.symmetric(
          //   horizontal: ThemeConstants.defaultHorPadding,
          //   vertical: ThemeConstants.defaultVerticalSpacing,
          // ),

          constraints: const BoxConstraints(
            minHeight: 100,
            // maxHeight: 200,
          ),
          padding: EdgeInsets.all(
            ThemeConstants.defaultContentPadding,
          ),
          decoration: BoxDecoration(
            // color: CommonMethods.colorFromPriority(todo.priority),
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(ThemeConstants.cardRadius),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        todo.title ?? 'Todo ${todo.id}',
                        style: TextStyles.todoTitleTextStyle,
                        maxLines: 2,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    // ------------ <hidden> show Priority of the todoObject
                    // Flexible(
                    //   flex: 2,
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       borderRadius:
                    //           BorderRadius.circular(ThemeConstants.cardRadius),
                    //       color: CommonMethods.colorFromPriority(todo.priority!),
                    //     ),
                    //     padding: const EdgeInsets.symmetric(
                    //       horizontal: 14,
                    //       vertical: 3,
                    //     ),
                    //     child: FittedBox(
                    //       child: Text(
                    //         CommonMethods.getPriorityTitle(
                    //           todo.priority!,
                    //         ),
                    //         style: TextStyles.todoVerySmallTextStyle(todo.priority),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 0),
                      child: Container(
                        height: 14,
                        width: 14,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color:
                              CommonMethods.colorFromPriority(todo.priority!),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  todo.content ?? '',
                  style: TextStyles.todoContentTextStyle,
                  maxLines: 15,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                ),
              ),
              Container(
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );

// Widget todoCard(BuildContext context, TodoModel todo) => StaggeredGridTile.fit(
//       crossAxisCellCount: 1,
//       child: GestureDetector(
//         onTap: () => showTodoDetails(
//           context: context,
//           todo: todo,
//         ),
//         onLongPress: () {
//           developer.log('hello long press');
//         },
//         child: Container(
//           // height: 130,
//           // margin: EdgeInsets.symmetric(
//           //   horizontal: ThemeConstants.defaultHorPadding,
//           //   vertical: ThemeConstants.defaultVerticalSpacing,
//           // ),
//
//           constraints: const BoxConstraints(
//             minHeight: 100,
//             maxHeight: 200,
//           ),
//           padding: EdgeInsets.all(
//             ThemeConstants.defaultContentPadding,
//           ),
//           decoration: BoxDecoration(
//             // color: CommonMethods.colorFromPriority(todo.priority),
//
//             color: Theme.of(context).colorScheme.primaryContainer,
//
//             borderRadius: BorderRadius.circular(ThemeConstants.cardRadius),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Flexible(
//                 flex: 1,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Flexible(
//                       flex: 5,
//                       child: Text(
//                         todo.title ?? 'Todo ${todo.id}',
//                         style: TextStyles.todoTitleTextStyle,
//                         maxLines: 1,
//                         softWrap: false,
//                         overflow: TextOverflow.fade,
//                       ),
//                     ),
//
//                     // ------------ <hidden> show Priority of the todoObject
//
//                     // Flexible(
//
//                     //   flex: 2,
//
//                     //   child: Container(
//
//                     //     decoration: BoxDecoration(
//
//                     //       borderRadius:
//
//                     //           BorderRadius.circular(ThemeConstants.cardRadius),
//
//                     //       color: CommonMethods.colorFromPriority(todo.priority!),
//
//                     //     ),
//
//                     //     padding: const EdgeInsets.symmetric(
//
//                     //       horizontal: 14,
//
//                     //       vertical: 3,
//
//                     //     ),
//
//                     //     child: FittedBox(
//
//                     //       child: Text(
//
//                     //         CommonMethods.getPriorityTitle(
//
//                     //           todo.priority!,
//
//                     //         ),
//
//                     //         style: TextStyles.todoVerySmallTextStyle(todo.priority),
//
//                     //       ),
//
//                     //     ),
//
//                     //   ),
//
//                     // ),
//
//                     Padding(
//                       padding: const EdgeInsets.only(left: 20.0, right: 5),
//                       child: Container(
//                         height: 14,
//                         width: 14,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(50),
//                           color:
//                               CommonMethods.colorFromPriority(todo.priority!),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Flexible(
//                 flex: 3,
//                 child: Text(
//                   todo.content ?? '',
//
//                   style: TextStyles.todoContentTextStyle,
//
//                   // maxLines: 2,
//
//                   // overflow: TextOverflow.ellipsis,
//
//                   softWrap: true,
//                 ),
//               ),
//               Flexible(
//                 flex: 1,
//                 child: Container(
//                   color: Colors.grey,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//
