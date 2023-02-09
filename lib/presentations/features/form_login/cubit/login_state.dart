part of 'login_cubit.dart';

enum LoginStatus { login, loading, noLogin }

@freezed
class LoginState with _$LoginState {
  LoginState._();
  factory LoginState({ required LoginStatus status}) =
      _LoginState;
  factory LoginState.initial() {
    if (LocalStorageHelper.getValue('checkLogin')== false){
          return LoginState( status: LoginStatus.noLogin);
    } else{
          return LoginState( status: LoginStatus.login);
    }
  }
  bool get isLoading =>
      status == LoginStatus.loading;
}
