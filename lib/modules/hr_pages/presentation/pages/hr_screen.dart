import 'package:aman_system/modules/hr_pages/presentation/widgets/hr_widget.dart';
import 'package:flutter/material.dart';

class HRScreen extends StatefulWidget {
  const HRScreen({Key? key}) : super(key: key);

  @override
  State<HRScreen> createState() => _HRScreenState();
}

class _HRScreenState extends State<HRScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const HRWidget(),
    );
  }
}
