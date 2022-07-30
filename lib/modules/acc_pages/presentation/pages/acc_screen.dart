

import 'package:aman_system/modules/acc_pages/presentation/widgets/acc_widget.dart';
import 'package:flutter/material.dart';

class AccScreen extends StatefulWidget {
  const AccScreen({Key? key}) : super(key: key);

  @override
  State<AccScreen> createState() => _AccScreenState();
}

class _AccScreenState extends State<AccScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AccWidget(),
    );
  }
}
