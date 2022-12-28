import 'package:travel_app/Data/models/task_model.dart';

List<TaskModal> convertToListModal(List<TaskModal>  listModal, listId) {
  List<TaskModal> data = [];
    List<TaskModal> listSearch =listModal;
  listSearch.forEach((e) {
    listId.forEach((a) {
      if (e.id == a.toString()) {
        data.add(e);
      }
    });
  });
  return data;
}
