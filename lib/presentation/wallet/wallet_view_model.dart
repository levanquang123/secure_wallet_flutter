import 'package:flutter/cupertino.dart';
import 'package:secure_wallet_flutter/domain/wallet/get_wallet_useCase.dart';
import 'package:secure_wallet_flutter/presentation/wallet/wallet_state.dart';

class WalletViewModel extends ChangeNotifier {
  final GetWalletUseCase getWalletUseCase;

  WalletViewModel(this.getWalletUseCase);

  late WalletState _state = const WalletInitial();

  WalletState get state => _state;

  void _setState(WalletState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> loadWallet() async {
    _setState(const WalletLoading());
    try {
      final balance = await getWalletUseCase.getBalance();
      _setState(WalletLoaded(balance));
    } catch (e) {
      _setState(WalletError(e.toString()));
    }
  }
}
