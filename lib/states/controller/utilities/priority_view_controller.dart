import 'package:get/get.dart';
import 'package:my_new_project/states/models/todos/priority_model.dart';

class PriorityViewController extends GetxController {
  Rx<PriorityEnum?> item = Rx<PriorityEnum?>(null);

  get priority => item.value;

  updatePriority(PriorityEnum? newPriority) => item.value = newPriority;

  clear() => item.value = null;
}
