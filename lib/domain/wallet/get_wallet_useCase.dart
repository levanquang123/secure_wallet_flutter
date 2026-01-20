import 'wallet_repository.dart';

class GetWalletUseCase {
  final WalletRepository walletRepository;

  GetWalletUseCase(this.walletRepository);

  Future<double> getBalance() async {

    return await walletRepository.getBalance();
  }
}
