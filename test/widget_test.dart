// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:izam_task/pages/data/login_api_provider.dart';
import 'package:izam_task/pages/data/login_repository.dart';
import 'package:izam_task/pages/model/Individual.dart';
import 'package:izam_task/pages/presentation/controllers/login_controller.dart';
import 'package:mockito/mockito.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group('LoginController', () {
    late ILoginProvider loginProvider;
    late ILoginRepository loginRepository;
    late LoginController loginController;

    setUp(() async {
      loginProvider = LoginProvider();
      loginRepository = LoginRepository(provider: loginProvider);
      loginController = LoginController(loginRepository: loginRepository);
      Get.testMode = true;
    });

    test('validate email correct', () async {
      expect(true, loginController.validateEmail('ASD.1234@izam.co'));
    });

    test('validate email incorret', () async {
      expect(false, loginController.validateEmail('ASD41.1234@izam.co'));
    });

    test('validate password correct', () async {
      expect(true, loginController.validatePassword('123456#A'));
    });
    test('validate password incorret', () async {
      expect(false, loginController.validatePassword('sadsad122541@'));
    });

    tearDown(() {
      loginController.dispose();
    });
  });
}
