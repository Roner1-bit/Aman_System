import 'package:aman_system/modules/add_folder_file_page/presentation/pages/folder_file_screen.dart';
import 'package:aman_system/modules/add_folder_page/presentation/pages/add_folder_screen.dart';
import 'package:aman_system/modules/technical_pages/presentation/widgets/tech_widget.dart';
import 'package:flutter/material.dart';


class TechScreen extends StatelessWidget  {

  const TechScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddFolderScreen()),
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
      body:  TechWidget(),

    );
  }
}
