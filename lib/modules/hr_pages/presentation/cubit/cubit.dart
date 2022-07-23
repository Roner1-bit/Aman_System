import 'package:aman_system/modules/hr_pages/presentation/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HRCubit extends Cubit<HRStates> {
  HRCubit() : super(HRInitialState());


  static HRCubit get(context) => BlocProvider.of<HRCubit>(context);



}