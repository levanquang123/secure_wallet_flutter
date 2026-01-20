abstract class TransactionState {
  const TransactionState();
}

class TransactionInitial extends TransactionState {
  const TransactionInitial();
}

class TransactionLoading extends TransactionState {
  const TransactionLoading();
}

class TransactionSuccess extends TransactionState {
  const TransactionSuccess();
}

class TransactionError extends TransactionState {
  final String message;

  const TransactionError(this.message);
}

class TransactionHistoryLoaded extends TransactionState {
  final List<TransactionModel> transactions;

  const TransactionHistoryLoaded(this.transactions);
}
