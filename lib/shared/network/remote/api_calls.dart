import 'dart:convert';

import 'package:aman_system/models/FolderData.dart';
import 'package:aman_system/shared/network/remote/dio_helper.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class ApiCalls {
  //Users Apis

  static dynamic verifyUser({required Map<String, dynamic> query}) {
    // emit loading state

    DioHelper.verifyUser(query: {
      "username": "Ahmed_Tamer", //change what was on the right side.
      "password": "Zxc102030",
    }).then((value) {
      if (value.data.length == 0) {
        //emit login failed
        print("Login failed");
      } else {
        print("Login successfully");
        //emit login successful
      }
    }).catchError((onError) {
      print("Error on failed");
      //emit failure state error
    });
  }

  static dynamic createUser({required Map<String, dynamic> query}) {
    // emit loading state

    DioHelper.setUser(query: {
      "username": "Sha3r", //change what was on the right side.
      "password": "bxcjhfsh1",
      "dep": "Tech"
    }).then((value) {
      //emit the successful state
      print("created successfully");
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

  static dynamic getUsers() {
    //emit the loading state
    DioHelper.getAllUser().then((value) {
      //emit the successful state
      print("created successfully");
      //add any thing about fetching the api (call me when you want to use it).
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

  static dynamic deleteUserWithPassword(
      {required Map<String, dynamic> query}) async {
    //emit loading state
    DioHelper.deleteUserWithPassword(query: {
      "username": "Sha3r", //change what was on the right side.
      "password": "bxcjhfsh1",
    }).then((value) {
      if (value.data["affectedRows"] == 0) {
        //emit no user with such data state
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

  static dynamic deleteUserWithoutPassword(
      {required Map<String, dynamic> query}) async {
    //emit loading state
    DioHelper.deleteUserWithoutPassword(query: {
      "username": "sha3r", //change what was on the right side.
    }).then((value) {
      print(value.data);
      if (value.data["affectedRows"] == 0) {
        //emit no user with such data state
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

  //Tech apis
  static dynamic createTechProj() {
    //emit loading state
    DioHelper.createTechProject(
        query: {"project_ID": 112, "project_Name": "3rd"}).then((value) {
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

  static dynamic addMultiMedia() async {
//emit loading state

    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      print(result.files.single.path!);
      print(result.names[0]);
      var formData = FormData.fromMap({
        "project_ID": 1123,
        "Sub_Header": "pops",
        //  When you want to add a certain sub-header inside a sub-header use this(sub-header=first_sub-header:Second sub-header)
        "multi_media": await MultipartFile.fromFile(result.files.single.path!,
            filename: result.names[0]),
        "project_Name": "manga",
      });

      DioHelper.addMultiMedia(query: formData).then((value) {
        //emit the successful state
        print("created successfully");
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

  static dynamic addSubHeader() async {
    //emit loading state
    DioHelper.addSubHeader(query: {
      "project_ID": 1123,
      "project_Name": "manga",
      "Sub_Header": "loopo"
    }).then((value) {
      //emit the successful state
      print("created successfully");
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


  static dynamic getSubHeader() async {
    //emit loading state
    List<String> multiMediaPaths = [];
    List<String> folders = [];
    String subHeader = "zeb";
    late int chosenTitleIndex; //This is meant to check the index of the chosen title out of the scheme
    DioHelper.getSubHeader(query: {
      "project_ID": 1123,
      "project_Name": "manga",
      "Sub_Header": subHeader
    }).then((value) {
      if (value.data.length == 1 && value.data[0]["multi_media"] == "") {
        print("this folder is empty"); //This means the folder has no files.
      } else {
        for (int i = 0; i < value.data.length; i++) {
          List<String> subHeaderList = value.data[i]["sub_header"].split(":");
          subHeaderList = cleanList(subHeaderList);
          if (subHeaderList.length == 1) {
            multiMediaPaths.add(value.data[i]["multi_media"]);
          } else {
            for (int j = 0; j < subHeaderList.length; j++) {
              if (subHeaderList[j] == subHeader) {
                chosenTitleIndex = j;
                break;
              }
            }
            if (chosenTitleIndex != subHeaderList.length - 1) {
              folders.add(subHeaderList[chosenTitleIndex + 1]);
            }
          }
        }
        multiMediaPaths = cleanList(multiMediaPaths);
        folders = cleanList(folders);
        folders = folders.toSet().toList();
        FolderData folder = FolderData(projectID: 1123,
            projectName: "manga",
            subHeaders: folders,
            multiMediaPaths: multiMediaPaths);
        print(folder.subHeaders);
        print(folder.multiMediaPaths);
      }
      //emit the successful state
      print("created successfully");
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

  static List<String> cleanList(List<String> list) {
    for (int k = 0; k < list.length; k++) {
      if (list[k] == "") {
        list.removeAt(k);
      }
    }

    return list;
  }


  static dynamic getProjectSubHeaders() async {
    //emit loading state
    List<String> listSubHeadersProject=[];
    DioHelper.getProjectSubHeader(query: {
      "project_ID": 1123,
      "project_Name": "manga",
    }).then((value) {
      if (value.data.length == 0 ) {
        print("this folder is empty"); //This means the folder has no files.
      } else {
        for (int i = 0; i < value.data.length; i++) {
          List<String> subHeaderList = value.data[i]["sub_header"].split(":");
          subHeaderList = cleanList(subHeaderList);
          if (subHeaderList.length == 1) {
              listSubHeadersProject.add(value.data[i]["sub_header"]);
          }else{
            listSubHeadersProject.add(subHeaderList[0]);
          }
        }
      }
      listSubHeadersProject=listSubHeadersProject.toSet().toList();
      print(listSubHeadersProject);              //this is the list of all the names of the folders of the project
      //emit the successful state
      print("created successfully");
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

  static dynamic deleteSubHeaders() async {
  //emit loading state
  DioHelper.deleteSubHeader(query: {
    "project_ID":1123,
    "project_Name":"manga",
    "Sub_Header":"pops"
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
}




