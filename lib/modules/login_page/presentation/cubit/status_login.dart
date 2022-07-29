abstract class LoginStatus {}

class AppInitialState extends LoginStatus {}

class LoginInitialState extends LoginStatus {}

class LoginLoadingState extends LoginStatus {}

class LoginErrorState extends LoginStatus {}

class FromLoginToHr extends LoginStatus {}

class FromLoginToTec extends LoginStatus {}

class FromLoginToSto extends LoginStatus {}
