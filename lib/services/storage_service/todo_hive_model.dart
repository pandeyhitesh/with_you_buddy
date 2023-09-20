import 'package:hive/hive.dart';


// @HiveType(typeId: 33)
// class TodoHiveModel{
//   @HiveField(0)
//   final Map<String, dynamic> todosMap;
//
//   TodoHiveModel(this.todosMap);
//
// }
//
//
// class TodoHiveModelAdapter extends TypeAdapter<TodoHiveModel>{
//   @override
//   final int typeId = 33;
//
//   @override
//   TodoHiveModel read(BinaryReader reader){
//     return TodoHiveModel(reader.read());
//   }
//
//   @override
//   void write(BinaryWriter writer, TodoHiveModel obj){
//     writer.write(obj.todosMap);
//   }
// }


// class Todo