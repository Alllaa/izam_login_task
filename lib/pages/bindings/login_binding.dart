import 'package:get/get.dart';
import 'package:izam_task/pages/data/login_api_provider.dart';
import 'package:izam_task/pages/data/login_repository.dart';
import 'package:izam_task/pages/presentation/controllers/login_controller.dart';


class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ILoginProvider>(LoginProvider());
    Get.put<ILoginRepository>(LoginRepository(provider: Get.find()));
    Get.put(LoginController(loginRepository: Get.find()));
  }
}
