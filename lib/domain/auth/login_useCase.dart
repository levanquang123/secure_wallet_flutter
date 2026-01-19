import 'package:secure_wallet_flutter/domain/auth/auth_repository.dart';

class LoginUseCase {
  final AuthRepository authRepository;

  LoginUseCase(this.authRepository);

  Future<void> login({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Email and password must not be empty');
    }
    await authRepository.login(email: email, password: password);
  }
}
