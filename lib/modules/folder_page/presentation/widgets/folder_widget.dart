import 'package:aman_system/modules/add_folder_file_page/presentation/pages/folder_file_screen.dart';
import 'package:aman_system/modules/folder_page/presentation/pages/folder_screen.dart';
import 'package:aman_system/shared/cubit/cubit.dart';
import 'package:aman_system/shared/cubit/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FolderWidget extends StatefulWidget {
  const FolderWidget({Key? key}) : super(key: key);

  @override
  State<FolderWidget> createState() => _FolderWidgetState();
}

class _FolderWidgetState extends State<FolderWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context){
        return AppCubit();
      },
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){

        },
        builder: (context,state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('Folder Name'),
              actions: [
                IconButton(onPressed: (){
                  Navigator.push(
                    context,

                    MaterialPageRoute(builder: (context) => const FolderFileScreen()),
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
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    height: 100,
                    child: Align(
                      alignment: Alignment.center,
                      child:  Image.asset('assests/images/logo.jpeg'),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (context,index) => buildUserItem(cubit.subFolders[index]),
                     separatorBuilder: (context,index) => Container(
                        width: double.infinity,
                      height: 1.0,
                      color: Colors.grey[300],
                   ),
                     itemCount: cubit.subFolders.length
                  ),
                ),

              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildUserItem(folderName user) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children:  [
        CircleAvatar(
          radius: 25.0,
          child: Text(
            '${user.id}',
            style: const TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FolderScreen()),
                );
              },
              child: Text(
                  user.name
              ),
            ),
          ],
        )
      ],
    ),
  );
}
