
import 'package:aman_system/models/FolderData.dart';
import 'package:aman_system/models/Users.dart';
import 'package:aman_system/models/projectData.dart';
import 'package:aman_system/modules/hr_pages/presentation/pages/hr_screen.dart';
import 'package:aman_system/modules/technical_pages/presentation/pages/tech_screen.dart';
import 'package:aman_system/shared/cubit/status.dart';
import 'package:aman_system/shared/network/remote/api_calls.dart';
import 'package:aman_system/shared/network/remote/api_constants.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AppCubit extends Cubit<AppStates>{


  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);




  List<FolderData> folderData = [];
  List<FolderData> subFolderData = [];
  List<FolderData> subFilesData = [];

  List<folderName> folders = [
  folderName(id: 1, name: 'Folder 1'),
  folderName(id: 2, name: 'Folder 2'),
  folderName(id: 3, name: 'Folder 3'),
  folderName(id: 4, name: 'Folder 4'),
  folderName(id: 6, name: 'Folder 5'),
  folderName(id: 7, name: 'Folder 6'),
  folderName(id: 8, name: 'Folder 7'),
  folderName(id: 9, name: 'Folder 9'),
  folderName(id: 10, name: 'Folder 10'),
  folderName(id: 11, name: 'Folder 11'),
  ];
  List<folderName> subFolders = [
    folderName(id: 1, name: 'Folder 1'),
    folderName(id: 2, name: 'Folder 2'),
    folderName(id: 3, name: 'Folder 3'),
    folderName(id: 4, name: 'Folder 4'),
  ];
  List<folderName> subFiles = [
    folderName(id: 1, name: 'Folder 1'),
    folderName(id: 2, name: 'Folder 2'),
    folderName(id: 3, name: 'Folder 3'),
    folderName(id: 4, name: 'Folder 4'),
  ];






  Future<List> showingProjectsTech() async{
    emit(AppDisplayTechProjects());
    return await ApiCalls.getTechProj() ;
  }

  Future<List<ProjectData>> showingProjectsHR() async {
    late List<ProjectData> hrProj ;
    emit(AppDisplayHrProjects());
    await ApiCalls.getHrProj().then((value) => hrProj = value);
    return hrProj;
  }

  void createProjectTech(int index) async{
     await ApiCalls.createTechProj(projectID: folderData[index].projectID, projectName: folderData[index].projectName);
     emit(AppCreateProjectTech());
  }

  void createProjectHR(int index) async{
    await ApiCalls.createHrProj(projectID: folderData[index].projectID, projectName: folderData[index].projectName);
    emit(AppCreateProjectHr());
  }

  void addSubHeaderTech(int index) async {
    await ApiCalls.addSubHeader(projectId: subFolderData[index].projectID, projectName: subFolderData[index].projectName, folderName: folderData[index].projectName);
    emit(AppAddSubHeaderTech());
  }

  void addMultiMediaTech(int index) async {
    await ApiCalls.addMultiMedia(projectId: subFilesData[index].projectID, projectName: subFilesData[index].projectName, folderFullRoute: '${folderData[index].projectName}:${subFilesData[index].projectName}');
    emit(AppAddMultiMediaTech());
  }

  // Future<List> getFoldersTech(int index) async{
  //   emit(AppGetFoldersTech());
  //   return await ApiCalls.getProjectSubHeaders(projectId: folderData[index].projectID);
  // }

  Future<FolderData> getFilesTech(int index) async{
    emit(AppGetFilesTech());
    return await ApiCalls.getSubHeader(projectID: subFolderData[index].projectID, projectName: subFolderData[index].projectName, folderName: folderData[index].projectName, fullRoute: '${folderData[index].projectName}:${subFilesData[index].projectName}');
  }

  void addSubHeaderHr(int index) async {
    await ApiCalls.addSubHeaderHr(projectId: subFolderData[index].projectID, projectName: subFolderData[index].projectName, folderName: folderData[index].projectName);
    emit(AppAddSubHeaderHr());
  }

  void addMultiMediaHr(int index) async {
    await ApiCalls.addMultiMediaHr(projectId: subFilesData[index].projectID, projectName: subFilesData[index].projectName, folderFullRoute: '${folderData[index].projectName}:${subFilesData[index].projectName}');
    emit(AppAddMultiMediaHr());
  }

  // Future <List> getFoldersHr(int index) async{
  //   emit(AppGetFoldersHr());
  //   return await ApiCalls.getProjectSubHeadersHr(projectId: folderData[index].projectID);
  // }

  Future<FolderData> getFilesHr(int index) async{
    emit(AppGetFilesHr());
    return await ApiCalls.getSubHeaderHr(projectID: subFolderData[index].projectID, projectName: subFolderData[index].projectName, folderName: folderData[index].projectName, fullRoute: '${folderData[index].projectName}:${subFilesData[index].projectName}');
  }


}

class folderName{
  final int id;
  final String name;
  folderName({
    required this.id,
    required this.name,
  });
}