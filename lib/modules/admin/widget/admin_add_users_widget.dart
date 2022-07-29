import 'package:aman_system/models/Users.dart';
import 'package:aman_system/modules/admin/cubit/cubit_admin.dart';
import 'package:aman_system/modules/admin/cubit/status_admin.dart';
import 'package:aman_system/shared/components/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




class AdminAddUsersWidget extends StatelessWidget {

  const AdminAddUsersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context){
        return AdminCubit();
      },
      child: BlocConsumer<AdminCubit,AdminStates>(
        listener: (context,state){},
        builder: (context,state) {
          final items = ["ADMIN","TECH","HR","ACC"];
          String? values;
          AdminCubit cubit = AdminCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
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
                  Padding(
                    padding: const EdgeInsets.only(left: 100,right: 100),
                    child: Center(
                      child: Card(
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          height: 350,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20, right: 20,top: 10,bottom: 15),
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  child: const Text(
                                    'User Name',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: 45,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 20),
                                  child: TextFormField(
                                    controller: cubit.userName,
                                    obscureText: false,
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                      labelText: 'user name',
                                      border: OutlineInputBorder(
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20, right: 20,bottom: 15),
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  child: const Text(
                                    'Password',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: 45,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 20),
                                  child: TextFormField(
                                    controller: cubit.userNamePass,
                                    obscureText: false,
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                      labelText: '*******',
                                      border: OutlineInputBorder(
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 150,right: 150),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius:BorderRadius.circular(15.0,),
                                      color: Colors.white
                                  ),
                                  child: Center(
                                    child: DropdownButton<String>
                                      (value: cubit.values,
                                        items: items.map(buildMenuItem).toList()
                                        , onChanged: (value) => cubit.buildMenu(value!)),
                                  ),
                                ),
                              ),
                              // PopupMenuButton(
                              //   itemBuilder: (BuildContext context) => [
                              //     const PopupMenuItem(
                              //       child: ListTile(
                              //         title:  Text('ADMIN'),
                              //       ),
                              //     ),
                              //     const PopupMenuItem(
                              //       child: ListTile(
                              //         title:  Text('HR'),
                              //       ),
                              //     ),
                              //     const PopupMenuItem(
                              //       child: ListTile(
                              //         title:  Text('TECH'),
                              //       ),
                              //     ),
                              //     const PopupMenuItem(
                              //       child: ListTile(
                              //         title:  Text('ACC'),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              const SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.only( left: 10.0,right: 10.0),
                                  child: MyButton(text: 'Create',
                                    backGroundColor: Colors.red,
                                    height: 35.0,
                                    width: 80.0,
                                    borderRadius: 10,
                                    onPress: () {
                                    if(cubit.userName.text.isEmpty || cubit.userName.text.isEmpty || cubit.values!.isEmpty ){
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                          content: Text("Please add all data needed")));
                                    }else{

                                      User user = User(password: cubit.userNamePass.text, dep: cubit.values!, userName: cubit.userName.text);
                                      cubit.createUser(user);
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                          content: Text("Project Added Successfully")));


                                    }


                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),

                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );

  }
  DropdownMenuItem<String> buildMenuItem(String item) =>
      DropdownMenuItem(
        value: item,
          child: Text(
        item,
        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
      ));
}
