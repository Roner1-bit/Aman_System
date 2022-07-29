
import 'package:aman_system/modules/add_folder_file_page/presentation/widgets/folder_file_widget_hr.dart';
import 'package:aman_system/modules/hr_pages/presentation/cubit/cubit_hr.dart';
import 'package:aman_system/modules/hr_pages/presentation/cubit/states_hr.dart';
import 'package:aman_system/shared/network/remote/api_calls.dart';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
List<String> project = [];
List<String> multiMedia = [];
class AllProjectsAndFilesSubHeaderHr extends StatelessWidget {
  final String folderNames;
  final String folderId;
  final String subFolder;
  final String folderName2;

  const AllProjectsAndFilesSubHeaderHr({Key? key, required this.folderNames, required this.folderId, required this.subFolder, required this.folderName2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context){
        return HrCubit()..getFilesHr(int.parse(folderId), folderNames, folderName2, subFolder).then((value) {
          project = ApiCalls.cleanList(value.subHeaders, true, true);
          project = ApiCalls.cleanList(value.multiMediaPaths, true, false);
        });
      },
      child: BlocConsumer<HrCubit,HrStates>(
        listener: (context,state){

        },
        builder: (context,state) {
          HrCubit cubit = HrCubit.get(context);



          bool pageChecker = true;
          if(project.length == 1 && project[0] == 'error'){
            pageChecker = false;
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text('All Folders'),
              actions: [
                IconButton(onPressed: (){
                  Navigator.push(
                    context,

                    MaterialPageRoute(builder: (context) =>  FolderFileWidgetHr(folderId: folderId, folderNames: folderNames, subFolder: subFolder+":",)),
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
                ConditionalBuilder(
                  condition : pageChecker,
                  builder: (context) => Expanded(
                    child: ListView.separated(
                        itemBuilder: (context,index) => buildUserItem(project[index],context),
                        separatorBuilder: (context,index) => Container(
                          width: double.infinity,
                          height: 1.0,
                          color: Colors.grey[300],
                        ),
                        itemCount: project.length
                    ),
                  ), fallback: null,
                ),

              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildUserItem(String user,BuildContext context) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children:  [
        CircleAvatar(
          radius: 25.0,
          child: Text(
            folderId,
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
                  MaterialPageRoute(builder: (context) => AllProjectsAndFilesSubHeaderHr(folderNames: folderNames, folderId: folderId, subFolder: subFolder+":"+user, folderName2: user,)),
                );
              },
              child: Text(
                  user
              ),
            ),
          ],
        )
      ],
    ),
  );
}
