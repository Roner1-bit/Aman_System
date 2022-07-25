import 'package:aman_system/shared/components/constants.dart';
import 'package:aman_system/shared/network/remote/api_constants.dart';
import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://192.168.1.11:3000/D/',
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
static getAllTech({required Map<String, dynamic> query}) async{
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


