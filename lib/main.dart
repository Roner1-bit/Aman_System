import 'dart:io';

import 'package:aman_system/layout/cubit/cubit.dart';
import 'package:aman_system/layout/cubit/states.dart';
import 'package:aman_system/modules/login_screen/login_screen.dart';
import 'package:aman_system/shared/Bloc_Observer.dart';
import 'package:aman_system/shared/components/components.dart';
import 'package:aman_system/shared/network/local/cache_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main()async{

  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();

  BlocOverrides.runZoned(
        () {
      runApp(const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );




}


class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  //final Widget startWidget;
  // const MyApp(this.startWidget,{Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    sleep(const Duration(milliseconds: 500));
    return BlocProvider(
        create: (BuildContext context) => AppCubit(),


        child:BlocConsumer<AppCubit,AppStates>(
          listener: (context,state){},
          builder: (context,state){
            return MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: primarySwatch,
                scaffoldBackgroundColor:Colors.white,

                //buildMaterialColor(const Color(0x00292c35)),
              ),
              home: LoginScreen(),
            );
          },
        )
    );
  }
}