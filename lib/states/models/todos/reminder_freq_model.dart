
import 'package:hive/hive.dart';
import 'package:my_new_project/states/models/todos/weekdays_model.dart';



enum ReminderFrequencyEnum {
  once,
  daily,
  weekDay,
  custom,
}



class ReminderFrequency {
  static List<ReminderFrequency> frequencies = [
    ReminderFrequency(
      frequency: ReminderFrequencyEnum.once,
      title: 'Once',
      activeDays: [],
    ),
    ReminderFrequency(
      frequency: ReminderFrequencyEnum.daily,
      title: 'Daily',
      activeDays: dailyActiveWeek,
    ),
    ReminderFrequency(
      frequency: ReminderFrequencyEnum.weekDay,
      title: 'Week Days',
      activeDays: weekdaysActiveWeek,
    ),
    ReminderFrequency(
      frequency: ReminderFrequencyEnum.custom,
      title: 'Custom',
      activeDays: WeekDays.weekDays,
    ),
  ];

  static List<WeekDays> get dailyActiveWeek {
    List<WeekDays> days = [];
    for (var day in WeekDays.weekDays) {
      days.add(day.copyWith(isActive: true));
    }
    return days;
  }

  static List<WeekDays> get weekdaysActiveWeek {
    List<WeekDays> days = [];
    for (var day in WeekDays.weekDays) {
      if (day.title == 'S') {
        days.add(
          day.copyWith(isActive: false),
        );
      } else {
        days.add(
          day.copyWith(isActive: true),
        );
      }
    }
    return days;
  }

  static ReminderFrequency getFrequencySetting(ReminderFrequencyEnum frq) =>
      frequencies.firstWhere(
            (element) => element.frequency == frq,
      );


  final  ReminderFrequencyEnum frequency;
  final String title;
  List<WeekDays> activeDays;

  // @Backlink(to: 'reminderFrequency')
  // final weekdays = IsarLinks<WeekDays>();

  ReminderFrequency({
    required this.frequency,
    required this.title,
    required this.activeDays,
  });

  ReminderFrequency copyWith({
    ReminderFrequencyEnum? frequency,
    String? title,
    List<WeekDays>? activeDays,
  }) {
    return ReminderFrequency(
      frequency: frequency ?? this.frequency,
      title: title ?? this.title,
      activeDays: activeDays ?? this.activeDays,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'frequency': frequency,
      'title': title,
      'activeDays': List<dynamic>.from(activeDays.map((x) => x.toJson())),
    };
  }

  factory ReminderFrequency.fromMap(Map<String, dynamic> map) {
    return ReminderFrequency(
      frequency: map['frequency'] as ReminderFrequencyEnum,
      title: map['title'] as String,
      activeDays: map['activeDays'] as List<WeekDays>,
    );
  }
}

// ---------------------------- ReminderFrequency Adapter ------------------ //

class ReminderFrequencyAdapter extends TypeAdapter<ReminderFrequency> {
  @override
  final int typeId = 3; // Assign a unique typeId

  @override
  ReminderFrequency read(BinaryReader reader) {
    final frequency = reader.read();
    final title = reader.read();
    final activeDays = reader.readList(); // Use the WeekDaysAdapter to read the list

    return ReminderFrequency(
      frequency: frequency,
      title: title,
      activeDays: activeDays.cast<WeekDays>(),
    );
  }

  @override
  void write(BinaryWriter writer, ReminderFrequency obj) {
    writer.write(obj.frequency);
    writer.write(obj.title);
    writer.writeList(obj.activeDays); // Use the WeekDaysAdapter to write the list
  }
}







// ------------------------- ReminderFrequencyEnum Adapter -------------------//
class ReminderFrequencyEnumAdapter extends TypeAdapter<ReminderFrequencyEnum> {
  @override
  final typeId = 6; // Unique identifier for the adapter

  @override
  ReminderFrequencyEnum read(BinaryReader reader) {
    // Deserialize the enum from Hive binary format
    return ReminderFrequencyEnum.values[reader.readByte()];
  }

  @override
  void write(BinaryWriter writer, ReminderFrequencyEnum obj) {
    // Serialize the enum to Hive binary format
    writer.writeByte(obj.index);
  }
}

