import 'package:aman_system/modules/view_folders/presentation/widgets/view_folder_widget.dart';
import 'package:flutter/material.dart';

class ViewFolderScreen extends StatefulWidget {
  const ViewFolderScreen({Key? key}) : super(key: key);

  @override
  State<ViewFolderScreen> createState() => _ViewFolderScreenState();
}

class _ViewFolderScreenState extends State<ViewFolderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Folders'),
      ),
      body: const ViewFolderWidget(),
    );
  }
}
