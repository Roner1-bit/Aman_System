import 'package:aman_system/modules/hr_pages/presentation/pages/hr_screen.dart';
import 'package:aman_system/modules/login_page/presentation/cubit/cubit.dart';
import 'package:aman_system/modules/login_page/presentation/cubit/states.dart';
import 'package:aman_system/modules/technical_pages/presentation/pages/tech_screen.dart';
import 'package:aman_system/shared/components/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {

  late TextEditingController email;
  late TextEditingController pass;
  @override
  Widget build(BuildContext context) {
    email = TextEditingController();
    pass = TextEditingController();
    return BlocProvider(
      create: (context){
        return LoginCubit();
      },
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context,state){

        },
        builder: (context,state) {
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
                          controller: email,
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
                          controller: pass,
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
                      if(LoginCubit.get(context).emailValidation(email) && LoginCubit.get(context).passValidation(pass)){
                        if(email.text.startsWith("HR")){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const HRScreen()),
                          );
                        }else if (email.text.startsWith("TECH")){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const TechScreen()),
                          );
                        }else{

                        }

                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text("Try with correct email and password")));
                      }
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
