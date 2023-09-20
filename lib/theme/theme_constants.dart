
import 'package:intl/intl.dart';

class ThemeConstants{
  const ThemeConstants._();

  static DateFormat dateFormat = DateFormat("EEE, MMM d, ''yy  h:mm a");
  static DateFormat dateOnlyFormat = DateFormat("EEE, MMM d, ''yy");
  static DateFormat timeOnlyFormat = DateFormat("h:mm a");

  static double defaultHorPadding = 20;
  static double defaultVerticalSpacing = 8;
  static double defaultContentPadding = 15;



  static double cardRadius = 15;
}
