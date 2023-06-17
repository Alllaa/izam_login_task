import 'package:izam_task/base/base_auth_provider.dart';
import 'package:izam_task/pages/data/database_helper.dart';
import 'package:izam_task/pages/model/Individual.dart';


abstract class ILoginProvider {
  Future<int> insertLoginRecord(String email, String password);
  Future<List<LoginRecords>> getLoginRecords();
  Future updateLoginCount(String email, String password);
  Future<Object?> getLoginCounts(String email, String password);

}

class LoginProvider extends BaseAuthProvider implements ILoginProvider {
  @override
  Future<int> insertLoginRecord(String email, String password) async{
   return await DatabaseHelper.instance.insertLoginRecord(email, password);

  }

  @override
  Future updateLoginCount(String email, String password) async{
    await DatabaseHelper.instance.updateLoginCount(email, password);
    return null;
  }

  @override
  Future<List<LoginRecords>> getLoginRecords() async{
    final loginRecords = await DatabaseHelper.instance.getLoginRecords();
    return loginRecords.map((json) => LoginRecords.fromJson(json)).toList();

  }

  @override
  Future<Object?> getLoginCounts(String email, String password)async {

   final count =   await DatabaseHelper.instance.getLoginCount(email, password);
   return count;
  }



}
