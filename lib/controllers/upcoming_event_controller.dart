import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/upcoming_event_model.dart';

/// This controller is used on the extended upcoming event to edit its values
class UpcomingEventController extends GetxController {
  //* Sets given model instance as private original and creates a public editable copy
  final UpcomingEventModel _originalModel;
  final UpcomingEventModel editableModel;

  // Editable fields
  final nameController = TextEditingController();
  // Observable if edited
  RxBool edited = false.obs;

  UpcomingEventController({required UpcomingEventModel model})
      : _originalModel = model,
        editableModel = model.copy() {
    nameController.text = model.name;
    nameController.addListener(() {
      editableModel.name = nameController.text;
      _checkIfEdited();
    });
  }

  /// Checks if editable model differs from original
  void _checkIfEdited() {
    edited.value = editableModel.differsFrom(_originalModel);
  }

  /// Sets given date to [editableModel]
  void setDate(DateTime newDate) {
    editableModel.date = newDate;
    _checkIfEdited();
  }

  /// Sets given days to [editableModel]
  void setDays(int days) {
    final now = DateTime.now();
    editableModel.date = DateTime(now.year, now.month, now.day + days);
    _checkIfEdited();
  }

  /// Sets given type to [editableModel]
  void setType(UpcomingEventType type) {
    editableModel.type = type;
    _checkIfEdited();
  }

  /// Saves All edits by setting original model to them
  void saveChanges() {
    _originalModel.setValuesFromModel(editableModel);
    _checkIfEdited();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
}
