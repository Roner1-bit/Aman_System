import 'package:aman_system/modules/login_screen/cubit/login_cubit.dart';
import 'package:aman_system/modules/login_screen/cubit/login_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class LoginScreen extends StatelessWidget {

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context)
    =>
        LoginCubit()
    ,
    child: BlocConsumer<LoginCubit,LoginStates>( //BlocConsumer<SocialLoginCubit, SocialLoginStates>
    listener: (context,state){},
    builder: (context,state){
      return Scaffold(
        body: Text("Login screen")
      );

    }


    ),





  );
}}


