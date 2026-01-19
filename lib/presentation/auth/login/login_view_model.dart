import 'package:flutter/foundation.dart';
import 'package:secure_wallet_flutter/domain/auth/login_useCase.dart';
import 'package:secure_wallet_flutter/presentation/auth/login/login_state.dart';

class LoginViewModel extends ChangeNotifier {
  final LoginUseCase loginUseCase;

  LoginViewModel(this.loginUseCase);

  LoginState _state = const LoginInitial();

  LoginState get state => _state;

  void _setState(LoginState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> login({required String email, required String password}) async {
    _setState(const LoginLoading());

    try {
      await loginUseCase.login(email: email, password: password);
      _setState(const LoginSuccess());
    } catch (e) {
      _setState(LoginError(e.toString()));
    }
  }
}
