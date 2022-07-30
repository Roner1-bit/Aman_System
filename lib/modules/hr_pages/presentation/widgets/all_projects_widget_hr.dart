import 'package:aman_system/models/projectData.dart';
import 'package:aman_system/modules/hr_pages/presentation/cubit/cubit_hr.dart';
import 'package:aman_system/modules/hr_pages/presentation/cubit/states_hr.dart';
import 'package:aman_system/modules/hr_pages/presentation/widgets/files_projects_widget_hr.dart';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


List<ProjectData> project = [];
class AllProjectHr extends StatelessWidget {
  final String typeDep;
  const AllProjectHr({Key? key, required this.typeDep}) : super(key: key);

  Future<bool> _onWillPop(BuildContext context,HrCubit cubit,String user,int id) async {
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
                if(typeDep == "ADMIN"){
                cubit.deleteProjectHr(id, user);
                Navigator.of(context).pop(false);
              }else{
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("You Don't have this Permission")));
              }



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
        return HrCubit()..showingProjectsHR().then((value) => project = value);
      },
      child: BlocConsumer<HrCubit,HrStates>(
        listener: (context,state)  {

        },
        builder: (context,state)   {

          HrCubit cubit = HrCubit.get(context);

          bool pageChecker = true;
          if(project.length == 1 && project[0] == 'error'){
            pageChecker = false;
          }


          return Scaffold(
            appBar: AppBar(
              title: const Text('Hr Projects'),
            ),
            body: ConditionalBuilder(
              condition : pageChecker,
              builder: (context) => ListView.separated(
                  shrinkWrap: false,
                  itemBuilder: (context,index) => buildUserItem(project[index],context,cubit),
                  separatorBuilder: (context,index) => Container(
                    width: double.infinity,
                    height: 1.0,
                    color: Colors.grey[300],
                  ),
                  itemCount: project.length
              ),
              fallback: null,
            ),
          );
        },
      ),
    );
  }

  Widget buildUserItem(ProjectData user,BuildContext context,HrCubit cubit) => Padding(
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
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  AllProjectsAndFilesHr(folderNames : user.projectName, folderId: user.projectID)),
                  );
                },
                child: Text(
                    user.projectName
                ),
              ),
            ],
          ),
        ),
        IconButton(
            onPressed: (){
              _onWillPop(context,cubit,user.projectName,int.parse(user.projectID));
            }, icon: const Icon(Icons.delete,color: Colors.red,)
        ),
      ],
    ),
  );

}
