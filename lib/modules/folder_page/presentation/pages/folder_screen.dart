import 'package:aman_system/modules/folder_page/presentation/widgets/folder_widget.dart';
import 'package:flutter/material.dart';

class FolderScreen extends StatefulWidget {
  const FolderScreen({Key? key}) : super(key: key);

  @override
  State<FolderScreen> createState() => _FolderScreenState();
}

class _FolderScreenState extends State<FolderScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: FolderWidget(),
    );
  }
}
