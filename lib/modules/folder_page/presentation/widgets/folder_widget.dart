import 'package:aman_system/modules/add_folder_file_page/presentation/pages/folder_file_screen.dart';
import 'package:aman_system/modules/folder_page/presentation/cubit/cubit.dart';
import 'package:aman_system/modules/folder_page/presentation/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FolderWidget extends StatefulWidget {
  const FolderWidget({Key? key}) : super(key: key);

  @override
  State<FolderWidget> createState() => _FolderWidgetState();
}

class _FolderWidgetState extends State<FolderWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context){
        return FolderCubit();
      },
      child: BlocConsumer<FolderCubit,FolderStates>(
        listener: (context,state){

        },
        builder: (context,state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Folder Name'),
              actions: [
                IconButton(onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FolderFileScreen()),
                  );

                }, icon: const CircleAvatar(
                  radius: 15.0,
                  backgroundColor: Colors.red,
                  child: Icon(
                    Icons.add_circle_outlined,
                    size: 30.0,
                    color: Colors.white,
                  ),
                )),
              ],
            ),
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


                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
