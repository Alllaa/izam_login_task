import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:izam_task/consts/colors.dart';
import 'package:izam_task/consts/strings.dart';
import 'package:izam_task/pages/data/database_helper.dart';
import 'package:izam_task/pages/model/Individual.dart';
import 'package:izam_task/widgets/snackbar_widget.dart';

import '../../data/login_repository.dart';

class LoginController extends SuperController<bool> {
  ILoginRepository loginRepository;

  LoginController({required this.loginRepository});

  String email = "";
  String password = "";



  RxBool isHiddenPassword = true.obs;
  List<LoginRecords> users = [];

  changeIsHiddenPassword() => isHiddenPassword.toggle();

  @override
  void onInit() async {
    super.onInit();
    change(false, status: RxStatus.loading());
    getLoginRecords();
    change(true, status: RxStatus.success());
  }

  onLoginClicked() async {
    LoginRecords? temp =
    users.firstWhereOrNull((element) => element.email == email);
    if (temp != null && temp.password == password) {
      updateLoginCounts(email,password);

    } else if (temp != null && temp.password != password) {
      Get.snackbar(ConstantsStrings.error, ConstantsStrings.wrongPassword,
          colorText: const Color(ColorCode.white), backgroundColor: Colors.red);
    } else if (temp == null) {
      insertLoginRecord(email, password);
    }
  }

  getLoginRecords() {
    change(false, status: RxStatus.loading());
    loginRepository.getLoginRecords().then((value) {
      users.clear();
      users = value;
      change(true, status: RxStatus.success());
    }).onError((error, stackTrace) {
      snackbar(ConstantsStrings.failedLogin,ConstantsStrings.somethingWentWrong,const Color(ColorCode.red));

      change(true, status: RxStatus.success());
    });
  }

  insertLoginRecord(String email, String password) {
    change(false, status: RxStatus.loading());
    loginRepository.insertLoginRecord(email, password).then((value) {
      if (value) {
        getLoginRecords();
        snackbar(ConstantsStrings.successfullyLogin,"${ConstantsStrings.noLoginCounts} 1",const Color(ColorCode.green));

      } else {
        snackbar(ConstantsStrings.failedLogin,ConstantsStrings.somethingWentWrong,const Color(ColorCode.red));
      }
      change(true, status: RxStatus.success());
    }).onError((error, stackTrace) {
      change(true, status: RxStatus.success());
      snackbar(ConstantsStrings.failedLogin,ConstantsStrings.somethingWentWrong,const Color(ColorCode.red));

    });
  }

  updateLoginCounts(String email, String password) async{
    change(false, status: RxStatus.loading());
   await loginRepository.updateLoginCount(email, password).then((value) async{
      if (value) {
        int loginCounts = await getLoginCounts(email, password);
        snackbar(ConstantsStrings.successfullyLogin,"${ConstantsStrings.noLoginCounts} ${loginCounts}",const Color(ColorCode.green));
        getLoginRecords();
      }

      change(true, status: RxStatus.success());
    }).onError((error, stackTrace) {
     change(true, status: RxStatus.success());
     snackbar(ConstantsStrings.failedLogin,ConstantsStrings.somethingWentWrong,const Color(ColorCode.red));
    });
  }

  getLoginCounts(String email, String password) async {
    int? x =  await loginRepository.getLoginCounts(email, password);
    return x!;
  }




  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}

  bool validateEmail(String email) {
    const pattern = r'^[a-zA-Z]{3}\.[0-9]{4}@izam\.co$';
    final regex = RegExp(pattern);
    return regex.hasMatch(email);
  }


  bool validatePassword(String password) {
    const pattern = r'^(?=.*[0-9])(?=.*[!$#^*]).{8,}$';

    final regex = RegExp(pattern);
    return regex.hasMatch(password);
  }
}
