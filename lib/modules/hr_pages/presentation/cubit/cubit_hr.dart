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

  void addMultiMediaHr(String projectName,int projectId,String folderName) async {
    await ApiCalls.addMultiMediaHr(projectId: projectId, projectName: projectName,folderFullRoute : folderName);
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

  void deleteProjectHr(int id, String name) async{
    await ApiCalls.deleteProjectHr(projectId: id, projectName: name);
    emit(AppDeleteProjectHr());
  }

  void deleteSubHeaderHr(int id, String name, String fullRoute) async {
    await ApiCalls.deleteSubHeadersHr(projectId: id, projectName: name, fullRoute: fullRoute);
    emit(AppDeleteSubHeaderHr());
  }

  void deleteMultiMediaHr(int id, String name, String route, String multiMediaLink) async{
    await ApiCalls.deleteMultiMediaHr(projectId: id, projectName: name, fullRoute: route, multiMediaLink: multiMediaLink);
    emit(AppDeleteMutliMediaHr());
  }
}