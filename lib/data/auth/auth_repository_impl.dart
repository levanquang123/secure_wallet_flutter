import 'package:secure_wallet_flutter/domain/auth/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<void> login({required String email, required String password}) async {
    await Future.delayed(const Duration(seconds: 2));

    if (email == 'test@gmail.com' && password == '123456') {
      return;
    } else {
      throw Exception('Invalid email or password');
    }
  }
}
