import 'package:flutter/material.dart';

import '../../domain/wallet/get_wallet_useCase.dart';
import 'wallet_view_model.dart';
import 'wallet_state.dart';
import '../../data/wallet/wallet_repository_impl.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  late final WalletViewModel viewModel;

  @override
  void initState() {
    super.initState();

    viewModel = WalletViewModel(GetWalletUseCase(WalletRepositoryImpl()));

    viewModel.addListener(() {
      setState(() {});
    });

    viewModel.loadWallet();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = viewModel.state;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              viewModel.loadWallet();
            },
          ),
        ],
      ),
      body: Center(child: _buildBody(state)),
    );
  }

  Widget _buildBody(WalletState state) {
    if (state is WalletLoading) {
      return const CircularProgressIndicator();
    }

    if (state is WalletLoaded) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Current Balance', style: TextStyle(fontSize: 16)),
          const SizedBox(height: 8),
          Text(
            '${state.balance.toStringAsFixed(0)} VND',
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ],
      );
    }

    if (state is WalletError) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(state.message, style: const TextStyle(color: Colors.red)),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              viewModel.loadWallet();
            },
            child: const Text('Retry'),
          ),
        ],
      );
    }

    return const SizedBox.shrink();
  }
}
