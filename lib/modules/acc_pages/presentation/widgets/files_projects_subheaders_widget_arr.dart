
import 'package:aman_system/modules/acc_pages/presentation/cubit/cubit_acc.dart';
import 'package:aman_system/modules/acc_pages/presentation/cubit/states_acc.dart';
import 'package:aman_system/modules/add_folder_file_page/presentation/widgets/folder_file_widget_acc.dart';
import 'package:aman_system/shared/network/remote/api_calls.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
List<String> project = [];
List<String> multiMedia = [];
List<String> allFilesAndProject = [];
class AllProjectsAndFilesSubHeaderAcc extends StatelessWidget {
  final String folderNames;
  final String folderId;
  final String subFolder;
  final String folderName2;

  const AllProjectsAndFilesSubHeaderAcc({Key? key, required this.folderNames, required this.folderId, required this.subFolder, required this.folderName2}) : super(key: key);

  Future<bool> _onWillPop(BuildContext context,AccCubit cubit,String user,int id,String file) async {
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

              cubit.deleteSubHeaderAcc(id, user, file);
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


  Future<bool> _onWillPopFiles(BuildContext context,AccCubit cubit,String user,int id,String file,String multiMediaLink) async {
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

              cubit.deleteMultiMediaAcc(id, user, file, multiMediaLink);
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

        return AccCubit()..getFilesAcc(int.parse(folderId), folderNames, folderName2, subFolder).then((value) {

          project = ApiCalls.cleanList(value.subHeaders, true, true);

          multiMedia = ApiCalls.cleanList(value.multiMediaPaths, true, false);
          allFilesAndProject = project + multiMedia ;
        });
      },
      child: BlocConsumer<AccCubit,AccStates>(
        listener: (context,state){

        },
        builder: (context,state) {
          AccCubit cubit = AccCubit.get(context);



          bool pageChecker = true;
          if(project.length == 1 && project[0] == 'error'){
            pageChecker = false;
          }

          return Scaffold(
            appBar: AppBar(
              title:  Text(folderName2),
              actions: [
                IconButton(onPressed: (){
                  Navigator.push(
                    context,

                    MaterialPageRoute(builder: (context) =>  FolderFileWidgetAcc(folderId: folderId, folderNames: folderNames, subFolder: subFolder+":",)),
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
                        itemBuilder: (context,index) => allWidgets(allFilesAndProject[index],context,cubit),
                        separatorBuilder: (context,index) => Container(
                          width: double.infinity,
                          height: 1.0,
                          color: Colors.grey[300],
                        ),
                        itemCount: allFilesAndProject.length
                    ),
                  ), fallback: null,
                ),
                // ConditionalBuilder(
                //   condition : pageChecker,
                //   builder: (context) => Expanded(
                //     child: ListView.separated(
                //         itemBuilder: (context,index) => buildUserFile(allFilesAndProject[index],context),
                //         separatorBuilder: (context,index) => Container(
                //           width: double.infinity,
                //           height: 1.0,
                //           color: Colors.grey[300],
                //         ),
                //         itemCount: allFilesAndProject.length
                //     ),
                //   ), fallback: null,
                // ),

              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildUserItem(String user,BuildContext context,AccCubit cubit) => Padding(
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
                onPressed: () async{
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AllProjectsAndFilesSubHeaderAcc(folderNames: folderNames, folderId: folderId, subFolder: subFolder+":"+user, folderName2: user,)),
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
              _onWillPop(context, cubit, folderNames, int.parse(folderId),  subFolder+":"+user);
            }, icon: const Icon(Icons.delete,color: Colors.red,)
        ),
      ],
    ),
  );

  Widget allWidgets (String text, BuildContext context,AccCubit cubit){
    if(text.contains('http')){
      return buildUserFile(text, context,cubit);
    }else{
      return buildUserItem(text, context,cubit);
    }
  }

  Widget buildUserFile(String user,BuildContext context,AccCubit cubit) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children:  [
        const CircleAvatar(
          radius: 25.0,
          child: Icon(Icons.file_present_rounded),
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
                onPressed: () async{

                  String url =  user;
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else
                  // can't launch url, there is some error
                  throw "Could not launch $url";
                },
                child: Text(
                    user.split('/')[user.split('/').length-1]
                ),
              ),
            ],
          ),
        ),
        IconButton(
            onPressed: (){
              _onWillPopFiles(context,cubit,folderNames,int.parse(folderId),subFolder,user);
            }, icon: const Icon(Icons.delete,color: Colors.red,)
        ),
      ],
    ),
  );
}
