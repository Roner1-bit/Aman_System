import 'package:aman_system/models/ListOfUsers.dart';
import 'package:aman_system/models/Users.dart';
import 'package:aman_system/modules/admin/cubit/status_admin.dart';
import 'package:aman_system/shared/network/remote/api_calls.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminCubit extends Cubit<AdminStates>{
  AdminCubit() : super(AppInitialState());
  static AdminCubit get(context) => BlocProvider.of(context);


  var userName= TextEditingController();
  var userNamePass = TextEditingController();

  String? values;

  String? buildMenu(String value){
    values = value;
    emit(AdminBuildMenu());
    return values;
  }

  Future<ListOfUser> getUsers() async{
    late ListOfUser users ;
    emit(AdminShowUsers());
    await ApiCalls.getUsers().then((value) => users = value);
    emit(AppStop());
    return users;
  }

  void createUser(User user) async{
    await ApiCalls.createUser(user: user);
    emit(AdminCreateUser());
  }

  void deleteUser(String user) async{
    await ApiCalls.deleteUserWithoutPassword(userName: user);
    emit(AdminDeleteUser());
  }




}