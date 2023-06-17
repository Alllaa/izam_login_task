import 'package:get/get.dart';
import 'package:izam_task/pages/bindings/login_binding.dart';
import 'package:izam_task/pages/presentation/views/login_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
        name: Routes.LOGIN,
        page: () => LoginView(),
        binding: LoginBinding()),

  ];
}
