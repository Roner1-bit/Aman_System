
import 'package:aman_system/models/projectData.dart';
import 'package:aman_system/modules/hr_pages/presentation/widgets/files_projects_widget_hr.dart';
import 'package:aman_system/modules/technical_pages/presentation/cubit/cubit.dart';
import 'package:aman_system/modules/technical_pages/presentation/cubit/status.dart';
import 'package:aman_system/modules/technical_pages/presentation/widgets/files_projects_widget_tech.dart';
import 'package:aman_system/shared/cubit/cubit.dart';
import 'package:aman_system/shared/cubit/status.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


List<ProjectData> project = [];
class AllProjectTech extends StatelessWidget {
  const AllProjectTech({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context){
        return TechCubit()..showingProjectsTech().then((value) => project = value);
      },
      child: BlocConsumer<TechCubit,TechStates>(
        listener: (context,state)  {

        },
        builder: (context,state)   {

          TechCubit cubit = TechCubit.get(context);
          bool pageChecker = true;

          if(project.length == 1 && project[0] == 'error'){
            pageChecker = false;
          }


          return Scaffold(
            appBar: AppBar(
              title: const Text('Technical Projects'),
            ),
            body: ConditionalBuilder(
              condition : pageChecker,
              builder: (context) => ListView.separated(
                  shrinkWrap: true,
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
        const CircleAvatar(
          radius: 25.0,
          child: Icon(Icons.folder),
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
                  MaterialPageRoute(builder: (context) =>  AllProjectsAndFilesTech(folderNames : user.projectName, folderId: user.projectID)),
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
