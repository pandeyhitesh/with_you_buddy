

import 'package:hive/hive.dart';

import '../../../common/type_defs.dart';

class WeekDays {
  static List<WeekDays> weekDays = [
    WeekDays(id: 01, title: 'S'),
    WeekDays(id: 02, title: 'M'),
    WeekDays(id: 03, title: 'T'),
    WeekDays(id: 04, title: 'W'),
    WeekDays(id: 05, title: 'T'),
    WeekDays(id: 06, title: 'F'),
    WeekDays(id: 07, title: 'S'),
  ];

  final Id id;
  String title;
  bool isActive;


  WeekDays({
    required this.id,
    required this.title,
    this.isActive = false,
  });

  WeekDays copyWith({
    Id? id,
    String? title,
    bool? isActive,
  }) {
    return WeekDays(
      id: id ?? this.id,
      title: title ?? this.title,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'isActive': isActive,
    };
  }

  factory WeekDays.fromMap(Map<String, dynamic> map) {
    return WeekDays(
      id: map['id'] as Id,
      title: map['title'] as String,
      isActive: map['isActive'] as bool,
    );
  }
}


// ----------------- WeekDays Adapter -----------------//


class WeekDaysAdapter extends TypeAdapter<WeekDays> {
  @override
  final int typeId = 4; // Assign a unique typeId

  @override
  WeekDays read(BinaryReader reader) {
    final id = reader.read();
    final title = reader.read();
    final isActive = reader.read();

    return WeekDays(
      id: id,
      title: title,
      isActive: isActive,
    );
  }

  @override
  void write(BinaryWriter writer, WeekDays obj) {
    writer.write(obj.id);
    writer.write(obj.title);
    writer.write(obj.isActive);
  }
}
