import 'dart:convert';

import 'package:aman_system/models/FolderData.dart';
import 'package:aman_system/models/ListOfUsers.dart';
import 'package:aman_system/models/Users.dart';
import 'package:aman_system/shared/network/remote/dio_helper.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import 'package:flutter/widgets.dart';

class ApiCalls {


  static List<String> cleanList(List<String> list,bool cleanUnique,bool cleanTheDots) {
    for (int k = 0; k < list.length; k++) {
      if(cleanTheDots) {
        if (list[k].contains(":")) {
          list[k] = list[k].replaceAll(":", "");
        }
      }
      if (list[k] == "") {
        list.removeAt(k);
      }
    }
    if(cleanUnique) {
      list = list.toSet().toList();
    }
    return list;
  }

  //please don't forget to add (await) before the call of each function.


  //Users Apis

  static Future<String> verifyUser({required User user}) async {
    late String result;                                                                              //"failed" for fail state for bad connection.
    await DioHelper.verifyUser(query:{                                                               //"success" for success state.
      "username":user.userName,                                                                      //"wrong" for wrong name or password.
      "password":user.password}).then((value) {                                                      //please check if it returns null just in case.
      if (value.data.length == 0) {
        result  = "failed";
      } else {
        result= "success";
      }
    }).catchError((onError) {
        result= "wrong";
    });
    return result;
  }


  static Future<String> createUser({required User user}) async {
    late String result;                                                                       //"failed" for fail state for bad connection.
    await DioHelper.setUser(query: {                                                          //"success" for success state.
      "username": user.userName,                                                              //please check if it returns null just in case.
      "password": user.password,
      "dep": user.dep
    }).then((value) {
      result= "success";
    }).catchError((e) {
      result  = "failed";
    });
    return result;
  }

  static Future<ListOfUser> getUsers() async {
    late ListOfUser listOfUser;                                                                //[] is for no users in database
    List<User> usersList=[];                                                                  //return of userList means success and these are the users data
    await DioHelper.getAllUser().then((value) {                                               //["no connection"] for fail state for bad connection.
      if (value.data.length == 0 ) {
        listOfUser= ListOfUser(users: []);
      } else {
        for (int i = 0; i < value.data.length; i++) {
          usersList.add(User.fromJson(value.data[i]));
        }
        listOfUser=ListOfUser(users: [User(userName:"no connection",password:"no connection",dep:"no connection")]);
      }

      // ListOfUser x= await ApiCalls.getUsers();                                           //Use this in the same manner
      // for(int i=0;i<x.users.length;i++){
      //   print(x.users[i].userName);
      //   print(x.users[i].password);
      //   print(x.users[i].dep);
      //
      // }

    }).catchError((e) {
      listOfUser=ListOfUser(users: []);
    });
    return listOfUser;
  }


  static Future<String> deleteUserWithPassword({required User user}) async {
    late String result;                                                                             //noUser is for no user with such data.
    await DioHelper.deleteUserWithPassword(query: {                                                 //success for successful deleting.
      "username":user.userName,"password":user.password                                             //failed for connection failure.
    }).then((value) {
      if (value.data["affectedRows"] == 0) {
        result="noUser";
      } else {
        result="success";
      }
    }).catchError((e) {
      result="failed";
    });
    return result;
  }

  static Future<String> deleteUserWithoutPassword({required String userName}) async {
    late String result;
    await DioHelper.deleteUserWithoutPassword(query: {                              //noUser is for no user with such data.
      "username": userName,                                                         //success for successful deleting.
    }).then((value) {                                                               //failed for connection failure.
      if (value.data["affectedRows"] == 0) {
        //emit no user with such data state
        result="noUser";
      } else {
        //emit the successful state
        result="success";
      }
    }).catchError((e) {
      result="failed";

    });
    return result;
  }

  //Tech apis

  static Future<List<String>> getTechProj() async {                                      //[] means there are no project folders.
    List<String> listProject=[];                                                  // list of projects.
    await DioHelper.getAllTech().then((value) {                                   //["error"] means error in connection.
      if (value.data.length == 0 ) {
        listProject=[];
      } else {
        for (int i = 0; i < value.data.length; i++) {
          listProject.add(value.data[i]["project_Name"]);
        }
        listProject=cleanList(listProject,true,true);
      }

    }).catchError((e) {
      listProject=["error"];
    });
    return listProject;
  }


  static Future<String> createTechProj({required int projectID,required String projectName}) async {
    late String result;                                                                       //success means the project was created
    await DioHelper.createTechProject(                                                        //error means the project needs to have a different name
        query: {"project_ID": projectID, "project_Name": projectName}).then((value) {
      result="success";
    }).catchError((e) {
      result="error";
    });
    return result;
  }


  static Future<String> addSubHeader({required int projectId,required String projectName,required String folderName}) async {    //careful to add whole route to the subHeader.
    late String result;                                                                                                   //fileExists is for file existing in the folder
    await DioHelper.addSubHeader(query: {                                                                                 //success is for the successful state
      "project_ID": projectId,
      "project_Name": projectName,
      "Sub_Header": folderName+":"
    }).then((value) {
      if(value.data.length==1){
        result ="fileExists";
      }else {
        result="success";
      }
    }).catchError((e) {
      result="error";

    });
    return result;
  }





  static Future<String> addMultiMedia({required int projectId,required String projectName,required String folderFullRoute}) async {

    late String resultMessage;                                                                //"fileExists" for exisitng files state
    FilePickerResult? result = await FilePicker.platform.pickFiles();                         //"success" for successful state
    if (result != null) {                                                                     //error for connection error state
      var formData = FormData.fromMap({
        "project_ID": projectId,
        "Sub_Header": folderFullRoute+":",
        //  When you want to add a certain sub-header inside a sub-header use this(sub-header=first_sub-header:Second sub-header)
        "multi_media": await MultipartFile.fromFile(result.files.single.path!,
            filename: result.names[0]),
        "project_Name": projectName,
      });

      await DioHelper.addMultiMedia(query: formData).then((value) {
        if(value.data.length==1){
          resultMessage="fileExists";
        }else {
          resultMessage="success";
        }
      }).catchError((e) {
        resultMessage="error";
      });
    } else {
        resultMessage="noFile";
    }
    return resultMessage;
  }



  static Future<FolderData> getSubHeader({required projectID,required String projectName,required String folderName,required String fullRoute}) async {  //folder name for current folder name
    late FolderData folderData;                                                                                                                  //folder data object will contain the current folders and multimedia
    List<String> multiMediaPaths = [];                                                                                                           //for error folderData will have a project name of "error"
    List<String> folders = [];                                                                                                                    //clean the lists of any "" just incase
    late int chosenTitleIndex;
    await DioHelper.getSubHeader(query: {
      "project_ID": projectID,
      "project_Name": projectName,
      "Sub_Header": fullRoute+":"
    }).then((value) {
      if (value.data.length == 1 && value.data[0]["multi_media"] == "") {
        folderData=FolderData(projectID: projectID, projectName: projectName, subHeaders: [], multiMediaPaths: []);
      } else {
        for (int i = 0; i < value.data.length; i++) {
          List<String> subHeaderList = value.data[i]["sub_header"].split(":");
          subHeaderList = cleanList(subHeaderList,false,true);
          if (subHeaderList.length == 1) {
            multiMediaPaths.add(value.data[i]["multi_media"]);
          } else {
            for (int j = 0; j < subHeaderList.length; j++) {
              if (subHeaderList[j] == folderName) {
                chosenTitleIndex = j;
                break;
              }
            }
            if (chosenTitleIndex != subHeaderList.length - 1) {
              folders.add(subHeaderList[chosenTitleIndex + 1]);

            }else{
              multiMediaPaths.add(value.data[i]["multi_media"]);
            }
          }
        }
        multiMediaPaths = cleanList(multiMediaPaths,true,false);
        folders = cleanList(folders,true,true);
        folderData = FolderData(projectID: projectID,
            projectName: projectName,
            subHeaders: folders,
            multiMediaPaths: multiMediaPaths);
      }
    }).catchError((e) {
        folderData=FolderData(projectID: 000, projectName: "error", subHeaders: [], multiMediaPaths: []);
    });
    return folderData;
  }



  static Future<List<String>> getProjectSubHeaders({required projectId,projectName}) async {

    List<String> listSubHeadersProject=[];                                                                    //listSubHeader array will contain all folders
    await DioHelper.getProjectSubHeader(query: {                                                              //[] for empty
      "project_ID":projectId,                                                                                 //["error"] for bad connection
      "project_Name":projectName,
    }).then((value) {
      if (value.data.length == 0 ) {
        listSubHeadersProject=[];
      } else {
        for (int i = 0; i < value.data.length; i++) {
          List<String> subHeaderList = value.data[i]["sub_header"].split(":");
          subHeaderList = cleanList(subHeaderList,false,true);
          if (subHeaderList.length == 1) {
              listSubHeadersProject.add(value.data[i]["sub_header"]);
          }else{
            listSubHeadersProject.add(subHeaderList[0]);
          }
        }
      }
      listSubHeadersProject=cleanList(listSubHeadersProject,true,true);

    }).catchError((e) {
      listSubHeadersProject=["error"];

    });
    return listSubHeadersProject;
  }


  static Future<String> deleteSubHeaders({required projectId,projectName,fullRoute}) async {
  late String result;
  await DioHelper.deleteSubHeader(query: {                                                   //FileDoesNotExist is meant when no folder exists
    "project_ID":projectId,                                                                  //success is for success state
    "project_Name":projectName,                                                              //error for fail state
    "Sub_Header":fullRoute+":"
  }).then((value) {
  if (value.data["affectedRows"] == 0) {
    result="FileDoesNotExist";
  } else {

  result="success";
  }
  }).catchError((e) {
  result="error";
  });
  return result;
  }


  static Future<String> deleteMultiMedia({required projectId,projectName,fullRoute,multiMediaLink}) async {
    late String result;
    await DioHelper.deleteMultiMedia(query: {                                           //FileDoesNotExist is meant when no folder exists
      "project_ID":projectId,                                                           //success is for success state
      "project_Name":projectName,                                                       //error for fail state
      "Sub_Header":fullRoute+":",
      "multi_media":multiMediaLink
    }).then((value) {
      if (value.data["affectedRows"] == 0) {
        result="FileDoesNotExist";
      } else {
        result="success";
      }
    }).catchError((e) {
      result="error";
    });
      return result;
  }


  static Future<String> deleteProject({required projectId,projectName}) async {
    late String result;
    await DioHelper.deleteProject(query: {
      "project_ID":projectId,
      "project_Name":projectName,
    }).then((value) {

      if (value.data["affectedRows"] == 0) {
        result="FileDoesNotExist";
      } else {
        result="success";
      }
    }).catchError((e) {
      result="error";
    });
    return result;

  }



  //HR api calls


  static Future<List<String>> getHrProj() async {


    List<String> listHrProject=[];
    await DioHelper.getAllHr().then((value) {
      if (value.data.length == 0 ) {
        listHrProject=[];
      } else {
        for (int i = 0; i < value.data.length; i++) {
          listHrProject.add(value.data[i]["project_Name"]);
        }
        listHrProject=cleanList(listHrProject,true,true);
      }

    }).catchError((e) {
      listHrProject=["error"];
    });
    return listHrProject;
  }




  static Future<String> createHrProj({required int projectID,required String projectName}) async {
    late String result;
    await DioHelper.createHrProject(
        query: {"project_ID": projectID, "project_Name": projectName}).then((value) {
      result="success";
    }).catchError((e) {
      result="error";
    });
    return result;
  }


  static Future<String> addSubHeaderHr({required int projectId,required String projectName,required String folderName}) async {
    late String result;
    await DioHelper.addSubHeaderHr(query: {
      "project_ID": projectId,
      "project_Name": projectName,
      "Sub_Header": folderName+":"
    }).then((value) {
      if(value.data.length==1){
        result ="fileExists";
      }else {
        result="success";
      }
    }).catchError((e) {
      result="error";

    });
    return result;
  }






  static Future<String> addMultiMediaHr({required int projectId,required String projectName,required String folderFullRoute}) async {

    late String resultMessage;
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {                                                                     //error for connection error state
      var formData = FormData.fromMap({
        "project_ID": projectId,
        "Sub_Header": folderFullRoute+":",
        //  When you want to add a certain sub-header inside a sub-header use this(sub-header=first_sub-header:Second sub-header)
        "multi_media": await MultipartFile.fromFile(result.files.single.path!,
            filename: result.names[0]),
        "project_Name": projectName,
      });

      await DioHelper.addMultiMediaHr(query: formData).then((value) {
        if(value.data.length==1){
          resultMessage="fileExists";
        }else {
          resultMessage="success";
        }
      }).catchError((e) {
        resultMessage="error";
      });
    } else {
      resultMessage="noFile";
    }
    return resultMessage;
  }




  static Future<FolderData> getSubHeaderHr({required projectID,required String projectName,required String folderName,required String fullRoute}) async {
    late FolderData folderData;
    List<String> multiMediaPaths = [];
    List<String> folders = [];
    late int chosenTitleIndex;
    await DioHelper.getSubHeaderHr(query: {
      "project_ID": projectID,
      "project_Name": projectName,
      "Sub_Header": fullRoute
    }).then((value) {

      if (value.data.length == 1 && value.data[0]["multi_media"] == "") {
        folderData=FolderData(projectID: projectID, projectName: projectName, subHeaders: [], multiMediaPaths: []);
      } else {
        for (int i = 0; i < value.data.length; i++) {
          List<String> subHeaderList = value.data[i]["Sub_Headers"].split(":");
          subHeaderList = cleanList(subHeaderList,false,true);
          if (subHeaderList.length == 1) {
            multiMediaPaths.add(value.data[i]["multi_media"]);
          } else {
            for (int j = 0; j < subHeaderList.length; j++) {
              if (subHeaderList[j] == folderName) {
                chosenTitleIndex = j;
                break;
              }
            }
            if (chosenTitleIndex != subHeaderList.length - 1) {
              folders.add(subHeaderList[chosenTitleIndex + 1]);
            }else{
              multiMediaPaths.add(value.data[i]["multi_media"]);
            }
          }
        }
        multiMediaPaths = cleanList(multiMediaPaths,true,false);
        folders = cleanList(folders,true,true);
        folderData = FolderData(projectID: projectID,
            projectName: projectName,
            subHeaders: folders,
            multiMediaPaths: multiMediaPaths);
      }
    }).catchError((e) {
      folderData=FolderData(projectID: 000, projectName: "error", subHeaders: [], multiMediaPaths: []);
    });
    return folderData;
  }


  static Future<List<String>> getProjectSubHeadersHr({required projectId,projectName}) async {

    List<String> listSubHeadersProject=[];
    await DioHelper.getProjectSubHeaderHr(query: {
      "project_ID":projectId,
      "project_Name":projectName,
    }).then((value) {
      if (value.data.length == 0 ) {
        listSubHeadersProject=[];
      } else {
        for (int i = 0; i < value.data.length; i++) {
          List<String> subHeaderList = value.data[i]["Sub_Headers"].split(":");
          subHeaderList = cleanList(subHeaderList,false,true);
          if (subHeaderList.length == 1) {
            listSubHeadersProject.add(subHeaderList[0]);
          }else{
            listSubHeadersProject.add(subHeaderList[0]);
          }
        }
      }
      listSubHeadersProject=cleanList(listSubHeadersProject,true,true);

    }).catchError((e) {
      print("error");
      listSubHeadersProject=["error"];
    });

    return listSubHeadersProject;
  }

  static Future<String> deleteSubHeadersHr({required projectId,projectName,fullRoute}) async {
    late String result;
    await DioHelper.deleteSubHeaderHr(query: {
      "project_ID":projectId,
      "project_Name":projectName,
      "Sub_Header":fullRoute+":"
    }).then((value) {
      print(value.data);
      if (value.data["affectedRows"] == 0) {
        //emit no subHeader with such data state
        result="FileDoesNotExist";
      } else {

        result="success";
      }
    }).catchError((e) {
      result="error";
    });
    return result;
  }


  static Future<String> deleteMultiMediaHr({required projectId,projectName,fullRoute,multiMediaLink}) async {
    late String result;
    await DioHelper.deleteMultiMediaHr(query: {
      "project_ID":projectId,
      "project_Name":projectName,
      "Sub_Header":fullRoute+":",
      "multi_media":multiMediaLink
    }).then((value) {
      if (value.data["affectedRows"] == 0) {
        result="FileDoesNotExist";
      } else {
        result="success";
      }
    }).catchError((e) {
      result="error";
    });
    return result;
  }


  static Future<String> deleteProjectHr({required projectId,projectName}) async {
    late String result;
    await DioHelper.deleteProjectHr(query: {
      "project_ID":projectId,
      "project_Name":projectName,
    }).then((value) {

      if (value.data["affectedRows"] == 0) {
        result="FileDoesNotExist";
      } else {
        result="success";
      }
    }).catchError((e) {
      result="error";
    });
    return result;

  }

  //Acc api here

  static dynamic getAccProj() {


    //emit loading state
    List<String> listAccProject=[];
    DioHelper.getAllAcc().then((value) {
      if (value.data.length == 0 ) {
        print("this folder is empty"); //This means the folder has no files.
      } else {
        for (int i = 0; i < value.data.length; i++) {

          listAccProject.add(value.data[i]["project_Name"]);

        }
      }
      listAccProject=cleanList(listAccProject,true,true);

      print(listAccProject);              //this is the list of all the names of the folders of the project
      //emit the successful state
      print("successful");
    }).catchError((e) {
      print("error");
      //emit error
      if (e.response != null) {
        print(e.response?.data);
        print(e.response?.headers);
        print(e.response?.requestOptions);
      } else {
        print(e.requestOptions);
        print(e.message);
      }
    });

  }



  static dynamic createAccProj() {
    //emit loading state
    DioHelper.createAccProject(
        query: {"project_ID": 100, "project_Name": "apple"}).then((value) {
      //emit the successful state
      print("created successfully");
    }).catchError((e) {
      print("Please enter different name for project");
      //emit repeated name state
      if (e.response != null) {
        print(e.response?.data);
        print(e.response?.headers);
        print(e.response?.requestOptions);
      } else {
        print(e.requestOptions);
        print(e.message);
      }
    });
  }


  static dynamic addSubHeaderAcc() async {
    //emit loading state
    DioHelper.addSubHeaderAcc(query: {
      "project_ID": 100,
      "project_Name": "apple",
      "Sub_Header": "test"+":"
    }).then((value) {
      if(value.data.length==1){
        print("file already exists");
        //emit file exists.
      }else {
        //emit the successful state
        print("created successfully");
      }
    }).catchError((e) {
      print("error");
      //emit error
      if (e.response != null) {
        print(e.response?.data);
        print(e.response?.headers);
        print(e.response?.requestOptions);
      } else {
        print(e.requestOptions);
        print(e.message);
      }
    });
  }





  static dynamic addMultiMediaAcc() async {
    //emit loading state

    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      print(result.files.single.path!);
      print(result.names[0]);
      var formData = FormData.fromMap({
        "project_ID": 100,
        "Sub_Header": "test"+":",
        //  When you want to add a certain sub-header inside a sub-header use this(sub-header=first_sub-header:Second sub-header)
        "multi_media": await MultipartFile.fromFile(result.files.single.path!,
            filename: result.names[0]),
        "project_Name": "apple",
      });

      DioHelper.addMultiMediaAcc(query: formData).then((value) {
        if(value.data.length==1){
          print("file already exists");
          //emit file exists.
        }else {
          //emit the successful state
          print("created successfully");
        }
      }).catchError((e) {
        print("error");
        //emit repeated name state
        if (e.response != null) {
          print(e.response?.data);
          print(e.response?.headers);
          print(e.response?.requestOptions);
        } else {
          print(e.requestOptions);
          print(e.message);
        }
      });
    } else {
      print("no file");
    }
  }



  static dynamic getSubHeaderAcc() async {
    //emit loading state
    List<String> multiMediaPaths = [];
    List<String> folders = [];
    int projectID=100;
    String projectName="apple";
    String folderName = "test";               //For the current folder name
    String fullRoute ="test"+":";          //This is meant for the entire route for the project
    late int chosenTitleIndex; //This is meant to check the index of the chosen title out of the scheme
    DioHelper.getSubHeaderAcc(query: {
      "project_ID": projectID,
      "project_Name": projectName,
      "Sub_Header": fullRoute
    }).then((value) {
      if (value.data.length == 1 && value.data[0]["multi_media"] == "") {
        print("this folder is empty"); //This means the folder has no files.
      } else {
        print(value.data.length);
        for (int i = 0; i < value.data.length; i++) {
          List<String> subHeaderList = value.data[i]["sub_header"].split(":");
          subHeaderList = cleanList(subHeaderList,false,true);
          if (subHeaderList.length == 1) {
            multiMediaPaths.add(value.data[i]["multi_media"]);
          } else {
            print(subHeaderList);
            print(folderName);
            for (int j = 0; j < subHeaderList.length; j++) {
              if (subHeaderList[j] == folderName) {
                chosenTitleIndex = j;
                break;
              }
            }
            if (chosenTitleIndex != subHeaderList.length - 1) {
              folders.add(subHeaderList[chosenTitleIndex + 1]);
            }else{
              multiMediaPaths.add(value.data[i]["multi_media"]);
            }
          }
        }
        multiMediaPaths = cleanList(multiMediaPaths,true,false);
        folders = cleanList(folders,true,true);
        FolderData folder = FolderData(projectID: projectID,
            projectName: projectName,
            subHeaders: folders,
            multiMediaPaths: multiMediaPaths);

        print(folder.subHeaders);
        print(folder.multiMediaPaths);
      }
      //emit the successful state
      print("created successfully");
    }).catchError((e) {
      print(e);
      //emit error
      if (e.response != null) {
        print(e.response?.data);
        print(e.response?.headers);
        print(e.response?.requestOptions);
      } else {
        print(e.requestOptions);
        print(e.message);
      }
    });
  }


  static dynamic getProjectSubHeadersAcc() async {
    //emit loading state
    List<String> listSubHeadersProject=[];
    DioHelper.getProjectSubHeaderAcc(query: {
      "project_ID":100,
      "project_Name":"apple",
    }).then((value) {
      if (value.data.length == 0 ) {
        print("this folder is empty"); //This means the folder has no files.
      } else {
        for (int i = 0; i < value.data.length; i++) {
          List<String> subHeaderList = value.data[i]["sub_header"].split(":");
          subHeaderList = cleanList(subHeaderList,false,true);
          if (subHeaderList.length == 1) {
            listSubHeadersProject.add(subHeaderList[0]);
          }else{
            listSubHeadersProject.add(subHeaderList[0]);
          }
        }
      }
      listSubHeadersProject=cleanList(listSubHeadersProject,true,true);

      print(listSubHeadersProject);              //this is the list of all the names of the folders of the project
      //emit the successful state
      print("successful");
    }).catchError((e) {
      print("error");
      //emit error
      if (e.response != null) {
        print(e.response?.data);
        print(e.response?.headers);
        print(e.response?.requestOptions);
      } else {
        print(e.requestOptions);
        print(e.message);
      }
    });
  }

  static dynamic deleteSubHeadersAcc() async {
    //emit loading state
    DioHelper.deleteSubHeaderAcc(query: {
      "project_ID":100,
      "project_Name":"apple",
      "Sub_Header":"test"+":"
    }).then((value) {
      print(value.data);
      if (value.data["affectedRows"] == 0) {
        //emit no subHeader with such data state
        print("no user with such data");
      } else {
        //emit the successful state
        print("deleted successfully");
      }
    }).catchError((e) {
      print("error");
      //emit failed error
      if (e.response != null) {
        print(e.response?.data);
        print(e.response?.headers);
        print(e.response?.requestOptions);
      } else {
        print(e.requestOptions);
        print(e.message);
      }
    });

  }


  static dynamic deleteMultiMediaAcc() async {
    //emit loading state
    DioHelper.deleteMultiMediaAcc(query: {
      "project_ID":100,
      "project_Name":"apple",
      "Sub_Header":"test"+":",
      "multi_media":"http://192.168.1.11/EL_EMAN/server/multi_media/acc/100apple/test/s.png"
    }).then((value) {
      print(value.data);
      if (value.data["affectedRows"] == 0) {
        //emit no subHeader with such data state
        print("no user with such data");
      } else {
        //emit the successful state
        print("deleted successfully");
      }
    }).catchError((e) {
      print("error");
      //emit failed error
      if (e.response != null) {
        print(e.response?.data);
        print(e.response?.headers);
        print(e.response?.requestOptions);
      } else {
        print(e.requestOptions);
        print(e.message);
      }
    });

  }


  static dynamic deleteProjectAcc() async {
    //emit loading state
    DioHelper.deleteProjectAcc(query: {
      "project_ID":100,
      "project_Name":"apple",
    }).then((value) {
      print(value.data);
      if (value.data["affectedRows"] == 0) {
        //emit no subHeader with such data state
        print("no project with such data");
      } else {
        //emit the successful state
        print("deleted successfully");
      }
    }).catchError((e) {
      print("error");
      //emit failed error
      if (e.response != null) {
        print(e.response?.data);
        print(e.response?.headers);
        print(e.response?.requestOptions);
      } else {
        print(e.requestOptions);
        print(e.message);
      }
    });

  }

}




