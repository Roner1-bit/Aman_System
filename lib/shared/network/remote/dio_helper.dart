import 'package:aman_system/shared/components/constants.dart';
import 'package:aman_system/shared/network/remote/api_constants.dart';
import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://192.168.56.1:3000/D/',
        receiveDataWhenStatusError: true,
      ),
    );
  }


  //Users apis
  static Future<Response> verifyUser({
    required Map<String, dynamic> query,
  }) async {
    return await dio.post(
      verifyUserEndPoint,
      data: query,
    );
  }

  static dynamic getAllUser() async {
      return await dio.get(
        getAllUsersEndPoint,
      );

  }

  static setUser({required Map<String, dynamic> query}) async {
    return await dio.post(
      setUsers,
      data: query,
    );
  }

  static deleteUserWithPassword({required Map<String, dynamic> query}) async {
    return await dio.delete(
      deleteUsersWithPassword,
      data: query,
    );
  }

  static deleteUserWithoutPassword({required Map<String, dynamic> query}) async {
    return await dio.delete(
      deleteUsersWithoutPassword,
      data: query,
    );
  }


  //Tech apis
static getAllTech() async{
  return await dio.get(
    getAllTechTable,
  );
}

  static createTechProject({required Map<String, dynamic> query}) async {
    return await dio.post(
      createTechProject_,
      data: query,
    );
  }

  static addMultiMedia({required FormData query}) async {
    return await dio.post(
      addMultiMedia_,
      data: query,
    );
  }

  static addSubHeader({required Map<String, dynamic> query}) async {
    return await dio.post(
      addSubHeader_,
      data: query,
    );
  }


  static getSubHeader({required Map<String, dynamic> query}) async {
    return await dio.post(
      getSubHeader_,
      data: query,
    );
  }


  static getProjectSubHeader({required Map<String, dynamic> query}) async {
    return await dio.post(
      getProjectSubHeader_,
      data: query,
    );
  }

  static deleteSubHeader({required Map<String, dynamic> query}) async {
    return await dio.delete(
      deleteSubHeader_,
      data: query,
    );
  }


  static deleteMultiMedia({required Map<String, dynamic> query}) async {
    return await dio.delete(
      deleteMultiMedia_,
      data: query,
    );
  }

  static deleteProject({required Map<String, dynamic> query}) async {
    return await dio.delete(
      deleteProject_,
      data: query,
    );

  }

  //hr apis


  static getAllHr() async{
    return await dio.get(
      getAllHrTable,
    );

  }

  static createHrProject({required Map<String, dynamic> query}) async {
    return await dio.post(
      createHrProject_,
      data: query,
    );
  }

  static addMultiMediaHr({required FormData query}) async {
    return await dio.post(
      addMultiMediaHr_,
      data: query,
    );
  }

  static addSubHeaderHr({required Map<String, dynamic> query}) async {
    return await dio.post(
      addSubHeaderHr_,
      data: query,
    );
  }


  static getSubHeaderHr({required Map<String, dynamic> query}) async {
    return await dio.post(
      getSubHeaderHr_,
      data: query,
    );
  }


  static getProjectSubHeaderHr({required Map<String, dynamic> query}) async {
    return await dio.post(
      getProjectSubHeaderHr_,
      data: query,
    );
  }

  static deleteSubHeaderHr({required Map<String, dynamic> query}) async {
    return await dio.delete(
      deleteSubHeaderHr_,
      data: query,
    );
  }


  static deleteMultiMediaHr({required Map<String, dynamic> query}) async {
    return await dio.delete(
      deleteMultiMediaHr_,
      data: query,
    );
  }

  static deleteProjectHr({required Map<String, dynamic> query}) async {
    return await dio.delete(
      deleteProjectHr_,
      data: query,
    );

  }


  //acc api



  static getAllAcc() async{
    return await dio.get(
      getAllAccTable,
    );

  }

  static createAccProject({required Map<String, dynamic> query}) async {
    return await dio.post(
      createAccProject_,
      data: query,
    );
  }

  static addMultiMediaAcc({required FormData query}) async {
    return await dio.post(
      addMultiMediaAcc_,
      data: query,
    );
  }

  static addSubHeaderAcc({required Map<String, dynamic> query}) async {
    return await dio.post(
      addSubHeaderAcc_,
      data: query,
    );
  }


  static getSubHeaderAcc({required Map<String, dynamic> query}) async {
    return await dio.post(
      getSubHeaderAcc_,
      data: query,
    );
  }


  static getProjectSubHeaderAcc({required Map<String, dynamic> query}) async {
    return await dio.post(
      getProjectSubHeaderAcc_,
      data: query,
    );
  }

  static deleteSubHeaderAcc({required Map<String, dynamic> query}) async {
    return await dio.delete(
      deleteSubHeaderAcc_,
      data: query,
    );
  }


  static deleteMultiMediaAcc({required Map<String, dynamic> query}) async {
    return await dio.delete(
      deleteMultiMediaAcc_,
      data: query,
    );
  }

  static deleteProjectAcc({required Map<String, dynamic> query}) async {
    return await dio.delete(
      deleteProjectAcc_,
      data: query,
    );

  }



}


    // try {
    //   return await dio.post(
    //     setUsers,
    //     data: query,
    //   );
    // } on DioError catch (e) {
    //
    //   if (e.response != null) {
    //     print(e.response?.data);
    //     print(e.response?.headers);
    //     print(e.response?.requestOptions);
    //     return false;
    //   } else {
    //     print(e.requestOptions);
    //     print(e.message);
    //   }
    //   return false;
    // }


