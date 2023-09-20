import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../services/navigation_service.dart';

List<Priority> defaultPriorities = [
  const Priority(
    priority: PriorityEnum.urgent,
    title: "Urgent",
    color: Colors.deepOrange,
  ),
  const Priority(
    priority: PriorityEnum.important,
    title: "Important",
    color: Colors.yellow,
  ),
  const Priority(
    priority: PriorityEnum.general,
    title: "General",
    // color: Theme.of(NavigationService.navigatorKey.currentContext!)
    //     .colorScheme
    //     .primaryContainer,
    color: Colors.white70,

  ),
];

enum PriorityEnum {
  urgent,
  important,
  general,
}



class PriorityEnumAdapter extends TypeAdapter<PriorityEnum> {
  @override
  final typeId = 5; // Unique identifier for the adapter

  @override
  PriorityEnum read(BinaryReader reader) {
    // Deserialize the enum from Hive binary format
    return PriorityEnum.values[reader.readByte()];
  }

  @override
  void write(BinaryWriter writer, PriorityEnum obj) {
    // Serialize the enum to Hive binary format
    writer.writeByte(obj.index);
  }
}

class Priority {
  final PriorityEnum priority;
  final String title;
  final Color color;

  const Priority({
    required this.priority,
    required this.title,
    required this.color,
  });
}
