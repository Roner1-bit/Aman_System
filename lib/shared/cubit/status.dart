abstract class AppStates {}

class AppInitialState extends AppStates {}

class LoginInitialState extends AppStates {}

class LoginLoadingState extends AppStates {}

class LoginErrorState extends AppStates {}

class FromLoginToHr extends AppStates {}

class FromLoginToTec extends AppStates {}

class FromLoginToSto extends AppStates {}

class AppDisplayTechProjects extends AppStates {}

class AppCreateProjectTech extends AppStates {}

class AppCreateProjectHr extends AppStates {}

class AppAddSubHeaderTech extends AppStates {}

class AppAddMultiMediaTech extends AppStates {}

class AppGetFoldersTech extends AppStates {}

class AppGetFilesTech extends AppStates {}

class AppAddSubHeaderHr extends AppStates {}

class AppAddMultiMediaHr extends AppStates {}

class AppGetFoldersHr extends AppStates {}

class AppGetFilesHr extends AppStates {}