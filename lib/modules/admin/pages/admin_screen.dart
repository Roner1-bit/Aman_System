import 'package:aman_system/modules/admin/widget/admin_view_all_widget.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AdminViewAllWidgets(),
    );
  }
}
