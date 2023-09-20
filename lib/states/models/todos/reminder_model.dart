
import 'package:hive/hive.dart';
import 'package:my_new_project/states/models/todos/reminder_freq_model.dart';
import 'package:my_new_project/states/models/todos/weekdays_model.dart';



@HiveType(typeId: 3)
class ReminderModel extends HiveObject{

  final String? title;
  final String? content;
  final DateTime? setOn;
  ReminderFrequency frequency;

  ReminderModel({
    this.title,
    this.content,
    this.setOn,
    required this.frequency,
  });

  ReminderModel copyWith({
    String? title,
    String? content,
    DateTime? setOn,
    ReminderFrequency? frequency,
  }) {
    return ReminderModel(
      title: title ?? this.title,
      content: content ?? this.content,
      setOn: setOn ?? this.setOn,
      frequency: frequency ?? this.frequency,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'setOn': setOn,
      'frequency': frequency.toJson(),
    };
  }

  factory ReminderModel.fromMap(Map<String, dynamic> map) {
    return ReminderModel(
      title: map['title'] as String,
      content: map['content'] as String,
      setOn: map['setOn'] as DateTime,
      frequency: map['frequency'] as ReminderFrequency,
    );
  }
}

// -------------------- ReminderModel Adapter ---------------//

class ReminderModelAdapter extends TypeAdapter<ReminderModel>{
  @override
  final int typeId = 2;

  @override
  ReminderModel read(BinaryReader reader){
    return ReminderModel(
      title: reader.read(),
      frequency: reader.read(),
      content: reader.read(),
      setOn: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, ReminderModel obj){
    writer.write(obj.title);
    writer.write(obj.frequency);
    writer.write(obj.content);
    writer.write(obj.setOn);
  }
}

