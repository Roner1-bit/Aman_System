import 'package:aman_system/modules/acc_pages/presentation/cubit/cubit_acc.dart';
import 'package:aman_system/modules/acc_pages/presentation/cubit/states_acc.dart';
import 'package:aman_system/modules/acc_pages/presentation/widgets/all_projects_widget_arr.dart';
import 'package:aman_system/modules/add_folder_page/presentation/widgets/add_folder_widget_acc.dart';
import 'package:aman_system/shared/components/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AccWidget extends StatefulWidget  {

  const AccWidget({Key? key}) : super(key: key);

  @override
  State<AccWidget> createState() => _AccWidgetState();
}

class _AccWidgetState extends State<AccWidget> {


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
    return BlocProvider(
      create: (context){
        return AccCubit();
      },
      child: BlocConsumer<AccCubit,AccStates>(
        listener: (context,state){

        },
        builder: (BuildContext context,AccStates state) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddFolderWidgetAcc()),
                  );

                }, icon: const CircleAvatar(
                  radius: 15.0,
                  backgroundColor: Colors.red,
                  child: Icon(
                    Icons.add_circle_outlined,
                    size: 30.0,
                    color: Colors.white,
                  ),
                )),
              ],
            ),
            body: WillPopScope(
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
                          'Welcome as Acc',
                          style: TextStyle(
                            fontSize: 20,

                            color: Colors.red,
                          ),
                        ),
                      ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // Container(
                      //   alignment: Alignment.center,
                      //   child:  const Text(
                      //     'UserName',
                      //     style: TextStyle(
                      //       fontSize: 20,
                      //       fontWeight: FontWeight.bold,
                      //       color: Colors.red,
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(
                        height: 30,
                      ),
                      MyButton(text: 'View Folders',
                          backGroundColor: Colors.red,
                          height: 40.0,
                          width: 350.0,
                          onPress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const AllProjectAcc(typeDep: 'ACC',)),
                            );
                          }
                      ),
                    ],
                  ),
                )
            ),
          );
        },
      ),
    );
  }
}
