import 'package:aman_system/modules/add_folder_page/presentation/pages/add_folder_screen.dart';
import 'package:aman_system/modules/technical_pages/presentation/cubit/cubit.dart';
import 'package:aman_system/modules/technical_pages/presentation/cubit/states.dart';
import 'package:aman_system/shared/components/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TechWidget extends StatefulWidget {
  const TechWidget({Key? key}) : super(key: key);

  @override
  State<TechWidget> createState() => _TechWidgetState();
}



class _TechWidgetState extends State<TechWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context){
        return TechCubit();
      },
      child: BlocConsumer<TechCubit,TechStates>(
        listener: (context,state){

        },
        builder: (context,state) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: SizedBox(
                      height: 100,
                      child: Align(
                        alignment: Alignment.center,
                        child:  Image.asset('assests/images/logo.jpeg'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 90,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'Welcome as technical',
                      style: TextStyle(
                        fontSize: 20,

                        color: Colors.red,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'UserName',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  MyButton(text: 'Add Folder',
                      backGroundColor: Colors.red,
                      height: 40.0,
                      width: 350.0,
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AddFolderScreen()),
                        );
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
