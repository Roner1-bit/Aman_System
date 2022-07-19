import 'package:aman_system/layout/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

}

//db.collection("cities").get().then(
//       (res) => print("Successfully completed"),
//       onError: (e) => print("Error completing: $e"),
//     );
