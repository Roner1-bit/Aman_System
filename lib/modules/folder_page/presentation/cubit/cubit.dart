import 'package:aman_system/modules/folder_page/presentation/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FolderCubit extends Cubit<FolderStates> {
  FolderCubit() : super(FolderInitialState());


  static FolderCubit get(context) => BlocProvider.of<FolderCubit>(context);



}