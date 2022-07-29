import 'package:aman_system/models/Users.dart';
import 'package:aman_system/modules/admin/pages/admin_screen.dart';
import 'package:aman_system/modules/hr_pages/presentation/pages/hr_screen.dart';
import 'package:aman_system/modules/login_page/presentation/cubit/status_login.dart';
import 'package:aman_system/modules/technical_pages/presentation/pages/tech_screen.dart';
import 'package:aman_system/shared/network/remote/api_calls.dart';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStatus>{
  LoginCubit() : super(AppInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);

  var email= TextEditingController();
  var pass= TextEditingController();

  bool emailValidation(TextEditingController controller) {
    if(EmailValidator.validate(controller.text) == true && controller.text.startsWith("HR")
        ||controller.text.startsWith("TECH") || controller.text.startsWith("STO") || controller.text.startsWith("ADMIN")){
      debugPrint('EMAIL');
      debugPrint('OK');
      return true;
    }else{
      debugPrint('EMAIL');
      debugPrint('NO');
      return false;
    }

  }
  bool passValidation(TextEditingController controller) {
    if(controller.text.isNotEmpty && controller.text.length > 10){
      debugPrint('PASS');
      debugPrint('OK');
      emit(LoginLoadingState());
      return true;
    }else{
      debugPrint('PASS');
      debugPrint('NO');
      emit(LoginErrorState());
      return false;
    }
  }
  void navFromEmail(BuildContext context) async{
    User user ;


    if(LoginCubit.get(context).emailValidation(email) && LoginCubit.get(context).passValidation(pass)){
      emit(LoginLoadingState());
      if(email.text.startsWith("HR")){
        user = User(userName: email.text, password: pass.text, dep: "HR");
        String verify = await ApiCalls.verifyUser(user: user);
        // String verify = 'success'; // will be changed
        if(verify == 'success'){
          emit(FromLoginToHr());
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HRScreen()),
          );
        }
        else {
          (
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("User Not Found")))
          );
        }

      }
      else if (email.text.startsWith("TECH")){

        user = User(userName: email.text, password: pass.text, dep: "TECH");
        // String verify = await ApiCalls.verifyUser(user: user);
        String verify = 'success'; // will be changed
        if(verify == 'success'){
          emit(FromLoginToTec());
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TechScreen()),
          );
        }
        else {
          (
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("User Not Found")))
          );
        }


      }else if (email.text.startsWith("ADMIN")){

        user = User(userName: email.text, password: pass.text, dep: "ADMIN");
        // String verify = await ApiCalls.verifyUser(user: user);
        String verify = 'success'; // will be changed
        if(verify == 'success'){
          emit(FromLoginToTec());
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AdminScreen()),
          );
        }
        else {
          (
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("User Not Found")))
          );
        }


      }
      else{
        emit(FromLoginToSto());
      }

    }
    else{
      emit(LoginErrorState());
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Try with correct email and password")));
    }
  }

}