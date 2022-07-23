import 'package:aman_system/modules/add_folder_file_page/presentation/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddFolderFileCubit extends Cubit<AddFolderFileStates> {
  AddFolderFileCubit() : super(AddFolderFileInitialState());


  static AddFolderFileCubit get(context) => BlocProvider.of<AddFolderFileCubit>(context);



}