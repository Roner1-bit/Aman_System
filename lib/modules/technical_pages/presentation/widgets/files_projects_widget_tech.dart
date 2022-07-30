
import 'package:aman_system/modules/add_folder_file_page/presentation/widgets/folder_file_widget_tech.dart';
import 'package:aman_system/modules/add_folder_page/presentation/widgets/folder_file_widget_tech_no_file_added.dart';
import 'package:aman_system/modules/technical_pages/presentation/cubit/cubit.dart';
import 'package:aman_system/modules/technical_pages/presentation/cubit/status.dart';
import 'package:aman_system/modules/technical_pages/presentation/widgets/all_projects_widget_tech.dart';
import 'package:aman_system/modules/technical_pages/presentation/widgets/files_projects_subheaders_widget_tech.dart';
import 'package:aman_system/shared/cubit/cubit.dart';
import 'package:aman_system/shared/cubit/status.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
List<String> project = [];
class AllProjectsAndFilesTech extends StatelessWidget {
  final String folderNames;
  final String folderId;
  const AllProjectsAndFilesTech({Key? key, required this.folderNames, required this.folderId}) : super(key: key);

  Future<bool> _onWillPop(BuildContext context,TechCubit cubit,String user,int id,String file) async {
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

              cubit.deleteSubHeader(id, user, file);
              Navigator.of(context).pop(false);

              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Deleted Successfully")));




            },
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
        return TechCubit()..getSubFoldersTech(folderNames,folderId).then((value) => project = value);
      },
      child: BlocConsumer<TechCubit,TechStates>(
        listener: (context,state){

        },
        builder: (context,state) {
          TechCubit cubit = TechCubit.get(context);
          bool pageChecker = true;
          if(project.length == 1 && project[0] == 'error'){
            pageChecker = false;
          }

          return Scaffold(
            appBar: AppBar(
              title:  Text(folderNames),
              actions: [
                IconButton(onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FolderNoFileWidgetTech(folderId: folderId, folderNames: folderNames, subFolder: '',)),
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
                        itemBuilder: (context,index) => buildUserItem(project[index],context,cubit),
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

  Widget buildUserItem(String user,BuildContext context,TechCubit cubit) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children:  [
        const CircleAvatar(
          radius: 25.0,
          child: Icon(Icons.folder),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  AllProjectsAndFilesSubHeaderTech(folderNames: folderNames, folderId: folderId, subFolder: user, folderName2: user,)),
                  );
                },
                child: Text(
                    user
                ),
              ),
            ],
          ),
        ),
        IconButton(
            onPressed: (){
              _onWillPop(context,cubit,folderNames,int.parse(folderId),user);
            }, icon: const Icon(Icons.delete,color: Colors.red,)
        ),
      ],
    ),
  );
}