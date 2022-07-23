import 'package:aman_system/modules/login_page/presentation/cubit/states.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());


  static LoginCubit get(context) => BlocProvider.of<LoginCubit>(context);


  bool emailValidation(TextEditingController controller) {
    if(EmailValidator.validate(controller.text) == true && controller.text.startsWith("HR")
        ||controller.text.startsWith("TECH") || controller.text.startsWith("STO")){
      debugPrint('EMAIL');
      debugPrint('OK');
      emit(LoginLoadingState());
      return true;
    }else{
      debugPrint('EMAIL');
      debugPrint('NO');
      emit(LoginErrorState());
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

}