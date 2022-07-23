
import 'package:aman_system/modules/technical_pages/presentation/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TechCubit extends Cubit<TechStates> {
  TechCubit() : super(TechInitialState());


  static TechCubit get(context) => BlocProvider.of<TechCubit>(context);



}