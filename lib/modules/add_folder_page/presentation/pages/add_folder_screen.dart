import 'package:aman_system/modules/add_folder_page/presentation/widgets/add_folder_widget.dart';
import 'package:flutter/material.dart';

class AddFolderScreen extends StatefulWidget {
  const AddFolderScreen({Key? key}) : super(key: key);

  @override
  State<AddFolderScreen> createState() => _AddFolderScreenState();
}

class _AddFolderScreenState extends State<AddFolderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const AddFolderWidget(),
    );
  }
}
