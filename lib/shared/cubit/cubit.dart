
import 'package:aman_system/modules/hr_pages/presentation/pages/hr_screen.dart';
import 'package:aman_system/modules/technical_pages/presentation/pages/tech_screen.dart';
import 'package:aman_system/shared/cubit/status.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AppCubit extends Cubit<AppStates>{


  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);


  var email= TextEditingController();
  var pass= TextEditingController();


  List<folderName> folders = [
  folderName(id: 1, name: 'Folder 1'),
  folderName(id: 2, name: 'Folder 2'),
  folderName(id: 3, name: 'Folder 3'),
  folderName(id: 4, name: 'Folder 4'),
  folderName(id: 6, name: 'Folder 5'),
  folderName(id: 7, name: 'Folder 6'),
  folderName(id: 8, name: 'Folder 7'),
  folderName(id: 9, name: 'Folder 9'),
  folderName(id: 10, name: 'Folder 10'),
  folderName(id: 11, name: 'Folder 11'),
  ];


  bool emailValidation(TextEditingController controller) {
    if(EmailValidator.validate(controller.text) == true && controller.text.startsWith("HR")
        ||controller.text.startsWith("TECH") || controller.text.startsWith("STO")){
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
  void navFromEmail(BuildContext context){
    if(AppCubit.get(context).emailValidation(email) && AppCubit.get(context).passValidation(pass)){
      if(email.text.startsWith("HR")){
        emit(LoginLoadingState());
        emit(FromLoginToHr());
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HRScreen()),
        );

      }else if (email.text.startsWith("TECH")){
        emit(LoginLoadingState());
        emit(FromLoginToSto());
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  const TechScreen()),
        );
      }else{

      }

    }else{
      emit(LoginErrorState());
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Try with correct email and password")));
    }
  }

  void displayNewFolder(){

    emit(AppDisplayNewFolder());
  }

}

class folderName{
  final int id;
  final String name;
  folderName({
    required this.id,
    required this.name,
  });
}