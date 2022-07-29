import 'package:aman_system/modules/add_folder_page/presentation/widgets/add_folder_widget_tech.dart';
import 'package:aman_system/shared/components/my_button.dart';
import 'package:aman_system/shared/cubit/cubit.dart';
import 'package:aman_system/shared/cubit/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FolderFileWidgetTech extends StatelessWidget {
  const FolderFileWidgetTech({Key? key}) : super(key: key);


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
                                padding: const EdgeInsets.only(top: 10),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'Create New',
                                    style: TextStyle(
                                      color: Colors.red,
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
                                  padding: const EdgeInsets.only(left: 75, right: 55),
                                  child: Row(
                                    children:  [
                                      MyButton(text: 'Folder',
                                        backGroundColor: Colors.red,
                                        height: 60.0,
                                        width: 80.0,
                                        borderRadius: 10,
                                        onPress: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => const AddFolderWidgetTech()),
                                          );
                                        },
                                      ),
                                      const SizedBox(
                                        width: 30,
                                      ),
                                      MyButton(text: 'File',
                                        backGroundColor: Colors.red,
                                        height: 60.0,
                                        width: 80.0,
                                        borderRadius: 10,
                                        onPress: () {
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(builder: (context) => const FolderScreen()),
                                          // );

                                        },
                                      ),
                                    ],
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
