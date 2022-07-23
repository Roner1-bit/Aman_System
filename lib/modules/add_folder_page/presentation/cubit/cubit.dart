import 'package:aman_system/modules/add_folder_page/presentation/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddFolderCubit extends Cubit<AddFolderStates> {
  AddFolderCubit() : super(AddFolderInitialState());


  static AddFolderCubit get(context) => BlocProvider.of<AddFolderCubit>(context);



}