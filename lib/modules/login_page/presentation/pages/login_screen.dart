import 'package:aman_system/models/Users.dart';
import 'package:aman_system/shared/components/my_button.dart';
import 'package:aman_system/shared/cubit/cubit.dart';
import 'package:aman_system/shared/cubit/status.dart';
import 'package:aman_system/shared/network/remote/api_calls.dart';
import 'package:aman_system/shared/network/remote/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context){
        return AppCubit();
      },
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (BuildContext context,AppStates state){},
        builder: (BuildContext context,AppStates state) {

          AppCubit cubit = AppCubit.get(context);
          
          return Scaffold(
            body: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset('assests/images/background.jpg'),
                    const SizedBox(
                      height: 90,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: const Text(
                          'Welcome to Aman System !',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: const Text(
                          'Sign in',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.red
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: const Text(
                          '*Email',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: TextFormField(
                          controller: cubit.email,
                          obscureText: false,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Eg. HR.hamed.com',
                            border: OutlineInputBorder(
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: const Text(
                          '*Password',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: TextFormField(
                          controller: cubit.pass,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: const InputDecoration(
                            labelText: '*******',
                            border: OutlineInputBorder(
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyButton(text: 'Sign In',
                        backGroundColor: Colors.red,
                        height: 40.0,
                        width: 350.0,
                        onPress: () {







                          cubit.navFromEmail(context,);
                      }
                    ),
                  ],
                ),
            ),
          );
        },
      ),
    );
  }
}
