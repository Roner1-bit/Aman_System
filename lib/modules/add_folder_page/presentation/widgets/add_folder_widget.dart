

import 'package:aman_system/modules/view_folders/presentation/pages/view_folder_screen.dart';
import 'package:aman_system/shared/components/my_button.dart';
import 'package:aman_system/shared/cubit/cubit.dart';
import 'package:aman_system/shared/cubit/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddFolderWidget extends StatefulWidget {
  const AddFolderWidget({Key? key}) : super(key: key);

  @override
  State<AddFolderWidget> createState() => _AddFolderWidgetState();
}

class _AddFolderWidgetState extends State<AddFolderWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context){
        return AppCubit();
      },
      child: BlocConsumer<AppCubit,AppStates>(
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
                   Padding(
                    padding: const EdgeInsets.only(left: 30,right: 30),
                    child: Center(
                      child: Card(
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          height: 150,
                          child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 20,top: 10,bottom: 15),
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    child: const Text(
                                      'New Folder',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: 45,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20, right: 20),
                                    child: TextFormField(
                                      obscureText: false,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: const InputDecoration(
                                        labelText: 'Untitled Folder',
                                        border: OutlineInputBorder(
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.only( left: 10.0,right: 10.0),
                                    child: MyButton(text: 'Create',
                                      backGroundColor: Colors.red,
                                      height: 35.0,
                                      width: 80.0,
                                      borderRadius: 10,
                                      onPress: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => const ViewFolderScreen()),
                                        );

                                      },
                                    ),
                                  ),
                                )

                              ],
                          ),
                        ),

                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
