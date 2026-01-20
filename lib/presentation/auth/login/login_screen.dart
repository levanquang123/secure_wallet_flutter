import 'package:flutter/material.dart';
import 'package:secure_wallet_flutter/domain/auth/auth_repository.dart';

import '../../wallet/wallet_screen.dart';
import 'login_view_model.dart';
import 'login_state.dart';
import '../../../domain/auth/login_useCase.dart';
import '../../../data/auth/auth_repository_impl.dart';

class SecureWalletApp extends StatelessWidget {
  const SecureWalletApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SecureWalletApp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final LoginViewModel viewModel;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    viewModel = LoginViewModel(
      LoginUseCase(AuthRepositoryImpl() as AuthRepository),
    );

    viewModel.addListener(() {
      final state = viewModel.state;

      if (state is LoginSuccess) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const WalletScreen()),
        );
      } else {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    viewModel.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = viewModel.state;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Card sẽ co dãn theo nội dung
                children: [
                  const Icon(Icons.lock_outline, size: 64, color: Colors.blue),
                  const SizedBox(height: 16),
                  const Text(
                    'Chào mừng trở lại',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Vui lòng đăng nhập để tiếp tục',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 32),

                  // Email Field
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: const Icon(Icons.email_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Password Field
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Mật khẩu',
                      prefixIcon: const Icon(Icons.lock_open_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  if (state is LoginLoading)
                    const Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: CircularProgressIndicator(),
                    ),

                  if (state is LoginError)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.red[50],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        state.message,
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    ),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      onPressed: state is LoginLoading
                          ? null
                          : () {
                              viewModel.login(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            },
                      child: const Text(
                        'ĐĂNG NHẬP',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
