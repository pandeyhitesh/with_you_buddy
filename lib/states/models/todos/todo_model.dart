import 'package:hive/hive.dart';
import 'package:my_new_project/common/type_defs.dart';
import 'package:my_new_project/states/models/todos/priority_model.dart';
import 'package:my_new_project/states/models/todos/reminder_model.dart';

@HiveType(typeId: 0)
class TodoModel extends HiveObject {
  final Id? id;
  final String? title;
  final String? content;
  final PriorityEnum? priority;
  final DateTime? createdDate;
  final ReminderModel? reminder;

  TodoModel({
    this.id,
    this.title,
    this.content,
    this.priority,
    this.createdDate,
    this.reminder,
  });

  TodoModel copyWith({
    Id? id,
    String? title,
    String? content,
    PriorityEnum? priority,
    DateTime? createdDate,
    ReminderModel? reminder,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      priority: priority ?? this.priority,
      createdDate: createdDate ?? this.createdDate,
      reminder: reminder ?? this.reminder,
    );
  }

  TodoModel setReminder({
    ReminderModel? reminder,
  }) {
    return TodoModel(
      id: id,
      title: title,
      content: content,
      priority: priority,
      createdDate: createdDate,
      reminder: reminder,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'priority': priority,
      'createdDate': createdDate,
      'reminder': reminder?.toJson(),
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'] as Id,
      title: map['title'] as String,
      content: map['content'] as String,
      priority: map['priority'] as PriorityEnum,
      createdDate: map['createdDate'] as DateTime,
      reminder: map['reminder'] as ReminderModel,
    );
  }
// final DateTime
}

// ---------------------- TodoModel Adapter ----------------------- //

class TodoModelAdapter extends TypeAdapter<TodoModel> {
  @override
  final int typeId =
      0; // The typeId for TodoModel, make sure it matches the one in @HiveType

  @override
  TodoModel read(BinaryReader reader) {
    return TodoModel(
      id: reader.read(),
      title: reader.read(),
      content: reader.read(),
      priority: reader.read(),
      createdDate: reader.read(),
      reminder: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, TodoModel obj) {
    writer.write(obj.id);
    writer.write(obj.title);
    writer.write(obj.content);
    writer.write(obj.priority);
    writer.write(obj.createdDate);
    writer.write(obj.reminder);
  }
}
