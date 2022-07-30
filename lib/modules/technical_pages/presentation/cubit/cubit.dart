import 'dart:math';

import 'package:aman_system/models/FolderData.dart';
import 'package:aman_system/models/projectData.dart';
import 'package:aman_system/modules/technical_pages/presentation/cubit/status.dart';
import 'package:aman_system/shared/network/remote/api_calls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TechCubit extends Cubit<TechStates>{
  TechCubit() : super(AppInitialState());
  static TechCubit get(context) => BlocProvider.of(context);

  int RandomNumber = Random().nextInt(1000);
  late int savedNumberID;

  List<FolderData> folderData = [];
  List<FolderData> subFolderData = [];
  List<FolderData> subFilesData = [];

  var projectName= TextEditingController();


  Future<List<ProjectData>>  showingProjectsTech() async{
    late List<ProjectData> techProj ;
    emit(AppDisplayTechProjects());
    await ApiCalls.getTechProj().then((value) => techProj = value);
    emit(AppStop());
    return techProj ;
  }
  void createProjectTech() async{
    ProjectData projectData = ProjectData(projectID: RandomNumber.toString(), projectName: projectName.text);
    savedNumberID = int.parse(projectData.projectID);
    await ApiCalls.createTechProj(projectID: int.parse(projectData.projectID), projectName: projectData.projectName);
    emit(AppCreateProjectTech());
  }
  void addSubHeaderTech(String projectName,int projectId,String folderName) async {
    await ApiCalls.addSubHeader(projectId: projectId, projectName: projectName, folderName: folderName);
    emit(AppAddSubHeaderTech());
  }
  void addMultiMediaTech(String projectName,int projectId,String folderName) async {
    await ApiCalls.addMultiMedia(projectId: projectId, projectName: projectName,folderFullRoute : folderName);
    emit(AppAddMultiMediaTech());
  }
  Future<List<String>> getSubFoldersTech(String projectName,String projectID) async{
    late List<String> techSubFold;
    await ApiCalls.getProjectSubHeaders(projectName: projectName, projectId: projectID).then((value) => techSubFold = value);
    emit(AppGetFoldersTech());
    return techSubFold;
  }

  Future<FolderData> getFilesTech(int id,String projectName,String folderName,String fullRoute) async{
    late FolderData getTechFiles ;
    await ApiCalls.getSubHeader(projectID: id, projectName: projectName, folderName: folderName, fullRoute: fullRoute).then((value) => getTechFiles = value);
    emit(AppGetFilesTech());
    return getTechFiles;
  }

  void deleteProject(int id, String name) async{
    await ApiCalls.deleteProject(projectId: id, projectName: name);
    emit(AppDeleteProjectTech());
  }

  void deleteSubHeader(int id, String name, String fullRoute) async {
    await ApiCalls.deleteSubHeaders(projectId: id, projectName: name, fullRoute: fullRoute);
    emit(AppDeleteSubHeader());
  }


  void deleteMultiMedia(int id, String name, String route, String multiMediaLink) async{
    await ApiCalls.deleteMultiMedia(projectId: id, projectName: name, fullRoute: route, multiMediaLink: multiMediaLink);
    emit(AppDeleteMutliMediaTech());
  }

}