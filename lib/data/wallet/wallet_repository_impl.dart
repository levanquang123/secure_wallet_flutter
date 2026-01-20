import '../../domain/wallet/wallet_repository.dart';

class WalletRepositoryImpl implements WalletRepository {
  double _mockBalance = 1000000;

  @override
  Future<double> getBalance() async {
    await Future.delayed(const Duration(seconds: 1));

    return _mockBalance;
  }
}
