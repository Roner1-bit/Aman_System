


import 'package:aman_system/modules/hr_pages/presentation/cubit/cubit_hr.dart';
import 'package:aman_system/modules/hr_pages/presentation/cubit/states_hr.dart';
import 'package:aman_system/modules/technical_pages/presentation/cubit/cubit.dart';
import 'package:aman_system/modules/technical_pages/presentation/cubit/status.dart';
import 'package:aman_system/shared/components/my_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddSubFolderWidgetTech extends StatelessWidget {
  final String folderNames;
  final String folderId;
  final String subFolder;
  const AddSubFolderWidgetTech({Key? key, required this.folderNames, required this.folderId, required this.subFolder}) : super(key: key);


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
          TechCubit cubit = TechCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
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
                                      controller: cubit.projectName,
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
                                      cubit.addSubHeaderTech(folderNames,int.parse(folderId),subFolder+cubit.projectName.text);
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                          content: Text("Project Added Successfully")));
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
