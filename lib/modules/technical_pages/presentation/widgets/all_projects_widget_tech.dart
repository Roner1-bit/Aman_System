
import 'package:aman_system/modules/hr_pages/presentation/widgets/files_projects_widget_hr.dart';
import 'package:aman_system/modules/technical_pages/presentation/widgets/files_projects_widget_tech.dart';
import 'package:aman_system/shared/cubit/cubit.dart';
import 'package:aman_system/shared/cubit/status.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


List project = [];
class AllProjectTech extends StatelessWidget {
  const AllProjectTech({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context){
        return AppCubit();
      },
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state)  {

        },
        builder: (context,state)   {

          AppCubit cubit = AppCubit.get(context);
          print('check');
          cubit.showingProjectsHR().then((value) => project = value);
          print(project.length);
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

  Widget buildUserItem(String user,BuildContext context) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children:  [
        CircleAvatar(
          radius: 25.0,
          child: Text(
            '${user}',
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
                  MaterialPageRoute(builder: (context) => const AllProjectsAndFilesTech()),
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
