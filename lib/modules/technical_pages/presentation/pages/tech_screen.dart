

import 'package:aman_system/modules/add_folder_page/presentation/widgets/add_folder_widget_tech.dart';
import 'package:aman_system/modules/technical_pages/presentation/widgets/tech_widget.dart';
import 'package:flutter/material.dart';


class TechScreen extends StatelessWidget  {

  const TechScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:  TechWidget(),

    );
  }
}
