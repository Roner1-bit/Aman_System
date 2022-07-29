import 'dart:math';

import 'package:aman_system/models/FolderData.dart';
import 'package:aman_system/models/projectData.dart';
import 'package:aman_system/modules/hr_pages/presentation/cubit/states_hr.dart';
import 'package:aman_system/shared/components/constants.dart';
import 'package:aman_system/shared/network/remote/api_calls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HrCubit extends Cubit<HrStates>{
  HrCubit() : super(AppInitialState());
  static HrCubit get(context) => BlocProvider.of(context);

  int RandomNumber = Random().nextInt(1000);
  late int savedNumberID;

  var projectName= TextEditingController();
  int randomNumber = Random().nextInt(100);
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

  Future<List<ProjectData>> showingProjectsHR() async {
    late List<ProjectData> hrProj ;
    emit(AppDisplayHrProjects());
    await ApiCalls.getHrProj().then((value) => hrProj = value);
    emit(AppStop());
    return hrProj;
  }

  void createProjectHR() async{
    ProjectData projectData = ProjectData(projectID: RandomNumber.toString(), projectName: projectName.text);
    savedNumberID = int.parse(projectData.projectID);
    await ApiCalls.createHrProj(projectID: int.parse(projectData.projectID), projectName: projectData.projectName);
    emit(AppCreateProjectHr());
  }


  void addSubHeaderHr(String projectName,int projectId,String folderName) async {
    await ApiCalls.addSubHeaderHr(projectId: projectId, projectName: projectName, folderName: folderName);
    emit(AppAddSubHeaderHr());
  }

  void addMultiMediaHr(int index) async {
    await ApiCalls.addMultiMediaHr(projectId: subFilesData[index].projectID, projectName: subFilesData[index].projectName, folderFullRoute: '${folderData[index].projectName}:${subFilesData[index].projectName}');
    emit(AppAddMultiMediaHr());
  }

  Future<List<String>> getSubFoldersHr(String projectName,String projectID) async{
    late List<String> hrSubFold ;
    await ApiCalls.getProjectSubHeadersHr(projectName: projectName, projectId: projectID).then((value) => hrSubFold = value);
    emit(AppGetFoldersHr());
    return hrSubFold;
  }

  Future<FolderData> getFilesHr(int id,String projectName,String folderName,String fullRoute) async{
    late FolderData getHrFiles ;
    await ApiCalls.getSubHeaderHr(projectID: id, projectName: projectName, folderName: folderName, fullRoute: fullRoute).then((value) => getHrFiles = value);
    emit(AppGetFilesHr());
    return getHrFiles;
  }
}