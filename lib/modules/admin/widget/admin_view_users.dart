import 'package:aman_system/models/ListOfUsers.dart';
import 'package:aman_system/models/Users.dart';
import 'package:aman_system/modules/admin/cubit/cubit_admin.dart';
import 'package:aman_system/modules/admin/cubit/status_admin.dart';
import 'package:aman_system/modules/admin/widget/admin_add_users_widget.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


List<User> project= [];
class AdminViewUsers extends StatelessWidget {
  const AdminViewUsers({Key? key}) : super(key: key);

  Future<bool> _onWillPop(BuildContext context,AdminCubit cubit,String user) async {
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
            onPressed: () {
              cubit.deleteUser(user);
              Navigator.of(context).pop(false);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Users'),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>   AdminAddUsersWidget()),
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
      body: BlocProvider(
        create: (context){
          return AdminCubit()..getUsers().then((value) => project = value.users);
        },
        child: BlocConsumer<AdminCubit,AdminStates>(
            listener: (context,state){

            },
            builder: (context,state){

              AdminCubit cubit = AdminCubit.get(context);


              bool pageChecker = true;
              if(project.length == 1 && project[0] == 'error'){
                pageChecker = false;
              }

              return ConditionalBuilder(
                condition : pageChecker,
                builder: (context) => ListView.separated(
                    shrinkWrap: false,
                    itemBuilder: (context,index) => buildUserItem(project[index].userName,context,cubit),
                    separatorBuilder: (context,index) => Container(
                      width: double.infinity,
                      height: 1.0,
                      color: Colors.grey[300],
                    ),
                    itemCount: project.length
                ),
                fallback: null,
              );
            }

        ),
      ),
    );
  }

  Widget buildUserItem(String user,BuildContext context,AdminCubit cubit) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children:  [
        const CircleAvatar(
          radius: 25.0,
          child: Icon(Icons.account_circle),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Text(
              user
          ),
        ),
        IconButton(
            onPressed: (){
              _onWillPop(context, cubit, user);
            }, icon: const Icon(Icons.delete,color: Colors.red,)
        ),
      ],
    ),
  );
}
