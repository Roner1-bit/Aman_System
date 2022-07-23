import 'package:aman_system/modules/technical_pages/presentation/widgets/tech_widget.dart';
import 'package:flutter/material.dart';

class TechScreen extends StatefulWidget {
  const TechScreen({Key? key}) : super(key: key);

  @override
  State<TechScreen> createState() => _TechScreenState();
}

class _TechScreenState extends State<TechScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const TechWidget(),
    );
  }
}
