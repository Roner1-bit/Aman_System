import 'package:aman_system/models/projectData.dart';
import 'package:aman_system/modules/hr_pages/presentation/cubit/cubit_hr.dart';
import 'package:aman_system/modules/hr_pages/presentation/cubit/states_hr.dart';
import 'package:aman_system/modules/hr_pages/presentation/widgets/files_projects_widget_hr.dart';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


List<ProjectData> project = [];
class AllProjectHr extends StatelessWidget {

  const AllProjectHr({Key? key}) : super(key: key);

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
              title: const Text('All Folders'),
            ),
            body: ConditionalBuilder(
              condition : pageChecker,
              builder: (context) => ListView.separated(
                  shrinkWrap: false,
                  itemBuilder: (context,index) => buildUserItem(project[index],context),
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

  Widget buildUserItem(ProjectData user,BuildContext context) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children:  [
        CircleAvatar(
          radius: 25.0,
          child: Text(
            user.projectID,
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
                  MaterialPageRoute(builder: (context) =>  AllProjectsAndFilesHr(folderNames : user.projectName, folderId: user.projectID)),
                );
              },
              child: Text(
                  user.projectName
              ),
            ),
          ],
        )
      ],
    ),
  );

}
