import 'dart:io';

import 'package:aman_system/modules/login_screen/cubit/login_cubit.dart';
import 'package:aman_system/modules/login_screen/cubit/login_states.dart';
import 'package:aman_system/shared/components/components.dart';
import 'package:aman_system/shared/components/constants.dart';
import 'package:aman_system/shared/network/remote/api_calls.dart';
import 'package:aman_system/shared/network/remote/dio_helper.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aman_system/shared/network/remote/api_constants.dart';


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
        body: defaultButton(submitFunction:
        () async {

          //ApiCalls.addSubHeader();
          ApiCalls.deleteSubHeadersHr();


      }

            , text: "click")
      );

    }


    ),





  );
}}


