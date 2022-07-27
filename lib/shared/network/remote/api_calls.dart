import 'dart:convert';

import 'package:aman_system/models/FolderData.dart';
import 'package:aman_system/models/Users.dart';
import 'package:aman_system/shared/network/remote/dio_helper.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

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


  //Users Apis

  static dynamic verifyUser() {
    // emit loading state

    DioHelper.verifyUser(query: {
      "username": "Dany1", //change what was on the right side.
      "password": "qweasds123",
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

  static dynamic createUser() {
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
    List<User> usersList=[];
    DioHelper.getAllUser().then((value) {
      //emit the successful state
      if (value.data.length == 0 ) {
        print("this folder is empty"); //This means the folder has no files.
      } else {
        for (int i = 0; i < value.data.length; i++) {
          usersList.add(User.fromJson(value.data[i]));
        }
      }

      for(int i=0;i<usersList.length;i++){
        print(usersList[i].userName);
        print(usersList[i].password);
        print(usersList[i].dep);

      }
      print(usersList);  //This is the list of all users
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


  static dynamic deleteUserWithPassword() async {
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

  static dynamic deleteUserWithoutPassword() async {
    //emit loading state
    DioHelper.deleteUserWithoutPassword(query: {
      "username": "Dany1", //change what was on the right side.
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

  static dynamic getTechProj() {


    //emit loading state
    List<String> listProject=[];
    DioHelper.getAllTech().then((value) {
      if (value.data.length == 0 ) {
        print("this folder is empty"); //This means the folder has no files.
      } else {
        for (int i = 0; i < value.data.length; i++) {
         // List<Map<String, dynamic>> names = jsonDecode(value.data.toString());
          //List<dynamic> names = value.data;
          //print(names[0]);
          //var x = names[0];
          //print(x["project_Name"]);
          listProject.add(value.data[i]["project_Name"]);

        }
      }
      listProject=cleanList(listProject,true,true);

      print(listProject);              //this is the list of all the names of the folders of the project
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


  static dynamic createTechProj() {
    //emit loading state
    DioHelper.createTechProject(
        query: {"project_ID": 113, "project_Name": "manga"}).then((value) {
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


  static dynamic addSubHeader() async {
    //emit loading state
    DioHelper.addSubHeader(query: {
      "project_ID": 113,
      "project_Name": "manga",
      "Sub_Header": "test"+":"
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





  static dynamic addMultiMedia() async {
//emit loading state

    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      print(result.files.single.path!);
      print(result.names[0]);
      var formData = FormData.fromMap({
        "project_ID": 113,
        "Sub_Header": "test"+":",
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



  static dynamic getSubHeader() async {
    //emit loading state
    List<String> multiMediaPaths = [];
    List<String> folders = [];
    String folderName = "test";               //For the current folder name
    String fullRoute ="test"+":";          //This is meant for the entire route for the project
    late int chosenTitleIndex; //This is meant to check the index of the chosen title out of the scheme
    DioHelper.getSubHeader(query: {
      "project_ID": 113,
      "project_Name": "manga",
      "Sub_Header": fullRoute
    }).then((value) {
      if (value.data.length == 1 && value.data[0]["multi_media"] == "") {
        print("this folder is empty"); //This means the folder has no files.
      } else {
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



  static dynamic getProjectSubHeaders() async {
    //emit loading state
    List<String> listSubHeadersProject=[];
    DioHelper.getProjectSubHeader(query: {
      "project_ID":113,
      "project_Name":"manga",
    }).then((value) {
      if (value.data.length == 0 ) {
        print("this folder is empty"); //This means the folder has no files.
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

  static dynamic deleteSubHeaders() async {
  //emit loading state
  DioHelper.deleteSubHeader(query: {
    "project_ID":113,
    "project_Name":"manga",
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


  static dynamic deleteMultiMedia() async {
    //emit loading state
    DioHelper.deleteMultiMedia(query: {
      "project_ID":113,
      "project_Name":"manga",
      "Sub_Header":"test"+":",
      "multi_media":"http://192.168.1.11/EL_EMAN/server/multi_media/tech/113manga/test/s.png"
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


  static dynamic deleteProject() async {
    //emit loading state
    DioHelper.deleteProject(query: {
      "project_ID":113,
      "project_Name":"manga",
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



  //HR api calls


  static dynamic getHrProj() {


    //emit loading state
    List<String> listHrProject=[];
    DioHelper.getAllHr().then((value) {
      if (value.data.length == 0 ) {
        print("this folder is empty"); //This means the folder has no files.
      } else {
        for (int i = 0; i < value.data.length; i++) {

          listHrProject.add(value.data[i]["project_Name"]);

        }
      }
      listHrProject=cleanList(listHrProject,true,true);

      print(listHrProject);              //this is the list of all the names of the folders of the project
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



  static dynamic createHrProj() {
    //emit loading state
    DioHelper.createHrProject(
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


  static dynamic addSubHeaderHr() async {
    //emit loading state
    DioHelper.addSubHeaderHr(query: {
      "project_ID": 1123,
      "project_Name": "manga",
      "Sub_Header": "test"+":"
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





  static dynamic addMultiMediaHr() async {
//emit loading state

    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      print(result.files.single.path!);
      print(result.names[0]);
      var formData = FormData.fromMap({
        "project_ID": 1123,
        "Sub_Header": "test"+":",
        //  When you want to add a certain sub-header inside a sub-header use this(sub-header=first_sub-header:Second sub-header)
        "multi_media": await MultipartFile.fromFile(result.files.single.path!,
            filename: result.names[0]),
        "project_Name": "manga",
      });

      DioHelper.addMultiMediaHr(query: formData).then((value) {
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



  static dynamic getSubHeaderHr() async {
    //emit loading state
    List<String> multiMediaPaths = [];
    List<String> folders = [];
    String folderName = "test";               //For the current folder name
    String fullRoute ="test"+":";          //This is meant for the entire route for the project
    late int chosenTitleIndex; //This is meant to check the index of the chosen title out of the scheme
    DioHelper.getSubHeaderHr(query: {
      "project_ID": 1123,
      "project_Name": "manga",
      "Sub_Header": fullRoute
    }).then((value) {

      if (value.data.length == 1 && value.data[0]["multi_media"] == "") {
        print("this folder is empty"); //This means the folder has no files.
      } else {
        print(value.data.length);
        for (int i = 0; i < value.data.length; i++) {
          List<String> subHeaderList = value.data[i]["Sub_Headers"].split(":");
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
        FolderData folder = FolderData(projectID: 113,
            projectName: "manga",
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


  static dynamic getProjectSubHeadersHr() async {
    //emit loading state
    List<String> listSubHeadersProject=[];
    DioHelper.getProjectSubHeaderHr(query: {
      "project_ID":1123,
      "project_Name":"manga",
    }).then((value) {
      if (value.data.length == 0 ) {
        print("this folder is empty"); //This means the folder has no files.
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

  static dynamic deleteSubHeadersHr() async {
    //emit loading state
    DioHelper.deleteSubHeaderHr(query: {
      "project_ID":1222,
      "project_Name":"mangso",
      "Sub_Header":"booty"+":"
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


  static dynamic deleteMultiMediaHr() async {
    //emit loading state
    DioHelper.deleteMultiMediaHr(query: {
      "project_ID":1123,
      "project_Name":"manga",
      "Sub_Header":"test"+":",
      "multi_media":"http://192.168.1.11/EL_EMAN/server/multi_media/HR/1123manga/test/result.png"
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


  static dynamic deleteProjectHr() async {
    //emit loading state
    DioHelper.deleteProjectHr(query: {
      "project_ID":1123,
      "project_Name":"manga",
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




