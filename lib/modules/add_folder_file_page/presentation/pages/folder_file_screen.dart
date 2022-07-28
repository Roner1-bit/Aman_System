import 'package:aman_system/modules/add_folder_file_page/presentation/widgets/folder_file_widget.dart';
import 'package:flutter/material.dart';

class FolderFileScreen extends StatefulWidget {
  const FolderFileScreen({Key? key}) : super(key: key);

  @override
  State<FolderFileScreen> createState() => _FolderFileScreenState();
}

class _FolderFileScreenState extends State<FolderFileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const FolderFileWidget(),
    );
  }
}
