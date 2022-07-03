import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormController extends GetxController {
  Map<TextEditingController, Rx<String>> fields = {};
  RxString errorMessage = "".obs;
  RxBool processing = false.obs;
  FormController(List<TextEditingController> controllers) {
    for (TextEditingController controller in controllers) {
      fields[controller] = controller.text.obs;
    }
  }
  @override
  void onInit() {
    fields.forEach((controller, text) {
      controller.addListener(() {
        text.value = controller.text;
      });
    });
    super.onInit();
  }

  @override
  void dispose() {
    for (var field in fields.keys) {
      field.dispose();
    }
    super.dispose();
  }

  bool get missingField {
    for (var text in fields.values) {
      if (text.value.isEmpty) {
        return true;
      }
    }
    return false;
  }

  void setErrorMessage(String value) => errorMessage.value = value;
  void setProcessing(bool value) => processing.value = value;
}
