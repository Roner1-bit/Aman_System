abstract class AppStates {}

class AppInitialState extends AppStates {}

class LoginInitialState extends AppStates {}

class LoginLoadingState extends AppStates {}

class LoginErrorState extends AppStates {}

class FromLoginToHr extends AppStates {}

class FromLoginToSto extends AppStates {}

class AppDisplayNewFolder extends AppStates {}