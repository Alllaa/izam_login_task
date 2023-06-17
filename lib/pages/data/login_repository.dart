import 'package:izam_task/consts/strings.dart';
import 'package:izam_task/pages/model/Individual.dart';
import 'login_api_provider.dart';

abstract class ILoginRepository {
  Future<bool> insertLoginRecord(String email, String password);
  Future<List<LoginRecords>> getLoginRecords();
  Future<bool> updateLoginCount(String email, String password);
  Future<int?> getLoginCounts(String email, String password);

}

class LoginRepository   implements ILoginRepository {
  LoginRepository({required this.provider});
  final ILoginProvider provider;

  @override
  Future<bool> insertLoginRecord(String email, String password) async{
    try{
      int isInsert = await provider.insertLoginRecord(email, password);
      if(isInsert != 0){
        return true;
      }else{
        return false;
      }
    }catch(e){
      throw(ConstantsStrings.somethingWentWrong);
    }

  }

  @override
  Future<List<LoginRecords>> getLoginRecords() async{
    try{
      return await provider.getLoginRecords();
    }catch(e){
      throw(ConstantsStrings.somethingWentWrong);
    }


  }

  @override
  Future<bool> updateLoginCount(String email, String password)async{
    try{
       await provider.updateLoginCount(email, password);
       return true;
    }catch(e){
      throw(ConstantsStrings.somethingWentWrong);
    }
  }

  @override
  Future<int?> getLoginCounts(String email, String password)async {
    try{
      return await provider.getLoginCounts(email, password) as int;
    }catch(e){
      throw(ConstantsStrings.somethingWentWrong);
    }
  }


}
