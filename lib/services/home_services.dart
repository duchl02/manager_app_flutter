import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/Data/models/task_model.dart';


List<TaskModal> convertToListModal(List<TaskModal> listModal, listId) {
  List<TaskModal> data = [];
  List<TaskModal> listSearch = listModal;
  listSearch.forEach((e) {
    listId.forEach((a) {
      if (e.id == a.toString()) {
        data.add(e);
      }
    });
  });
  return data;
}

void notAlowAction(context) async {
  (await confirm(
    context,
    title: const Text('Lỗi phân quyền'),
    content: Text(
        'Bạn không thể thực hiện chức năng này'),
    textOK: const Text('Xác nhận'),
    textCancel: const Text('Thoát'),
  ));
}


