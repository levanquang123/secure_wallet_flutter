abstract class WalletState {
  const WalletState();
}

class WalletInitial extends WalletState {
  const WalletInitial();
}

class WalletLoading extends WalletState {
  const WalletLoading();
}

class WalletLoaded extends WalletState {
  final double balance;

  const WalletLoaded(this.balance);
}

class WalletError extends WalletState {
  final String message;

  const WalletError(this.message);
}
