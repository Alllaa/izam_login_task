import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:izam_task/consts/colors.dart';

snackbar(String title, String content, Color background){
  return  Get.snackbar(title, content,
      colorText: const Color(ColorCode.white), backgroundColor:background);
}