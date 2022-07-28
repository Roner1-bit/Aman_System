import 'package:aman_system/modules/folder_page/presentation/pages/folder_screen.dart';
import 'package:aman_system/shared/cubit/cubit.dart';
import 'package:aman_system/shared/cubit/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ViewFolderWidget extends StatefulWidget {
  const ViewFolderWidget({Key? key}) : super(key: key);

  @override
  State<ViewFolderWidget> createState() => _ViewFolderWidgetState();
}

class _ViewFolderWidgetState extends State<ViewFolderWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context){
        return AppCubit();
      },
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state) {
          AppCubit cubit = AppCubit.get(context);
          return ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context,index) => buildUserItem(cubit.folders[index]),
              separatorBuilder: (context,index) => Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
              itemCount: cubit.folders.length
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
