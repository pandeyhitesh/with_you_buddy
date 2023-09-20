import 'package:get/get.dart';

class ReminderToggleController extends GetxController {
  var isSelected = false.obs;

  bool get haveReminder=> isSelected.value;
  setToggleValue(bool newValue)=> isSelected.value = newValue;
  toggle() => isSelected.value = !isSelected.value;
  void clearController()=> isSelected.value = false;



}
