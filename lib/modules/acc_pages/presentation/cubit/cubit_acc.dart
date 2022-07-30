import 'dart:math';

import 'package:aman_system/models/FolderData.dart';
import 'package:aman_system/models/projectData.dart';
import 'package:aman_system/modules/acc_pages/presentation/cubit/states_acc.dart';

import 'package:aman_system/shared/network/remote/api_calls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccCubit extends Cubit<AccStates>{
  AccCubit() : super(AccInitialState());
  static AccCubit get(context) => BlocProvider.of(context);

  int RandomNumber = Random().nextInt(1000);
  late int savedNumberID;

  var projectName= TextEditingController();



  Future<List<ProjectData>> showingProjectsAcc() async {
    late List<ProjectData> accProj ;
    emit(AppDisplayAccProjects());
    await ApiCalls.getAccProj().then((value) => accProj = value);
    emit(AppStopAcc());
    return accProj;
  }

  void createProjectAcc() async{
    ProjectData projectData = ProjectData(projectID: RandomNumber.toString(), projectName: projectName.text);
    savedNumberID = int.parse(projectData.projectID);
    await ApiCalls.createAccProj(projectID: int.parse(projectData.projectID), projectName: projectData.projectName);
    emit(AppCreateProjectAcc());
  }


  void addSubHeaderAcc(String projectName,int projectId,String folderName) async {
    await ApiCalls.addSubHeaderAcc(projectId: projectId, projectName: projectName, folderName: folderName);
    emit(AppAddSubHeaderAcc());
  }

  void addMultiMediaAcc(String projectName,int projectId,String folderName) async {
    await ApiCalls.addMultiMediaAcc(projectId: projectId, projectName: projectName,folderFullRoute : folderName);
    emit(AppAddMultiMediaAcc());
  }

  Future<List<String>> getSubFoldersAcc(String projectName,String projectID) async{
    late List<String> accSubFold ;
    await ApiCalls.getProjectSubHeadersAcc(projectName: projectName, projectId: projectID).then((value) => accSubFold = value);
    emit(AppGetFoldersAcc());
    return accSubFold;
  }

  Future<FolderData> getFilesAcc(int id,String projectName,String folderName,String fullRoute) async{
    late FolderData getAccFiles ;
    await ApiCalls.getSubHeaderAcc(projectID: id, projectName: projectName, folderName: folderName, fullRoute: fullRoute).then((value) => getAccFiles = value);
    emit(AppGetFilesAcc());
    return getAccFiles;
  }

  void deleteProjectAcc(int id, String name) async{
    await ApiCalls.deleteProjectAcc(projectId: id, projectName: name);
    emit(AppDeleteProjectAcc());
  }

  void deleteSubHeaderAcc(int id, String name, String fullRoute) async {
    await ApiCalls.deleteSubHeadersAcc(projectId: id, projectName: name, fullRoute: fullRoute);
    emit(AppDeleteSubHeaderAcc());
  }

  void deleteMultiMediaAcc(int id, String name, String route, String multiMediaLink) async{
    await ApiCalls.deleteMultiMediaAcc(projectId: id, projectName: name, fullRoute: route, multiMediaLink: multiMediaLink);
    emit(AppDeleteMutliMediaAcc());
  }
}