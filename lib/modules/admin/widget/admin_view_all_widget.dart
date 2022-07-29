import 'package:aman_system/modules/admin/cubit/cubit_admin.dart';
import 'package:aman_system/modules/admin/cubit/status_admin.dart';
import 'package:aman_system/modules/admin/widget/admin_view_users.dart';
import 'package:aman_system/modules/hr_pages/presentation/widgets/all_projects_widget_hr.dart';
import 'package:aman_system/modules/technical_pages/presentation/widgets/all_projects_widget_tech.dart';
import 'package:aman_system/shared/components/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminViewAllWidgets extends StatefulWidget {
  const AdminViewAllWidgets({Key? key}) : super(key: key);

  @override
  State<AdminViewAllWidgets> createState() => _AdminViewAllWidgetsState();
}

class _AdminViewAllWidgetsState extends State<AdminViewAllWidgets> {
  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('Do you want to exit an App'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => SystemNavigator.pop(),
            child: const Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context){
          return AdminCubit();
        },
        child: BlocConsumer<AdminCubit,AdminStates>(
          listener: (context,state){

          },
          builder: (context,state){
            AdminCubit cubit = AdminCubit.get(context);
            return WillPopScope(
                onWillPop: _onWillPop,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 60),
                        child: SizedBox(
                          height: 100,
                          child: Align(
                            alignment: Alignment.center,
                            child:  Image.asset('assests/images/logo.jpeg'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 90,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: const Text(
                          'Welcome as Admin',
                          style: TextStyle(
                            fontSize: 20,

                            color: Colors.red,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: const Text(
                          'UserName',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      MyButton(text: 'View HR',
                          backGroundColor: Colors.red,
                          height: 40.0,
                          width: 350.0,
                          onPress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const AllProjectHr()),
                            );
                          }
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      MyButton(text: 'View Tech',
                          backGroundColor: Colors.red,
                          height: 40.0,
                          width: 350.0,
                          onPress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const AllProjectTech()),
                            );
                          }
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      MyButton(text: 'View Acc',
                          backGroundColor: Colors.red,
                          height: 40.0,
                          width: 350.0,
                          onPress: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => const AllProjectTech()),
                            // );
                          }
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      MyButton(text: 'View Users',
                          backGroundColor: Colors.red,
                          height: 40.0,
                          width: 350.0,
                          onPress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const AdminViewUsers()),
                            );
                          }
                      ),
                    ],
                  ),
                ));
          }

        ),
      ),
    );
  }
}
