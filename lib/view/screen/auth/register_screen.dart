import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../viewmodel/auth_viewmodel.dart';
import '../../widget/auth_textfield.dart';
import '../../widget/shadow_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<RegisterScreen> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthViewModel(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.transparent,
          ),
        ),
        backgroundColor: Colors.white,
        body: Consumer<AuthViewModel>(
          builder: (context, viewModel, child) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/lingo.png',
                          height: 200,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "Hadi üye olalım!",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      overflow: TextOverflow.ellipsis
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Bilgilerinle kolaylıkla üye olabilirsin.",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 40),

                  AuthTextField(
                    controller: _usernameController,
                    hintText: "Kullanıcı Adı",
                    icon: Icons.person_outlined,
                  ),
                  AuthTextField(
                    controller: _emailController,
                    hintText: "E-posta Adresi",
                    icon: Icons.email_outlined,
                  ),
                  AuthTextField(
                    controller: _passwordController,
                    hintText: "Şifre",
                    icon: Icons.lock_outline,
                    isPassword: true,
                  ),

                  const SizedBox(height: 20),

                  Divider(color: Colors.grey.shade300),

                  const SizedBox(height: 20),

                  ShadowButton(
                    text: "Kayıt Ol",
                    isLoading: viewModel.isLoading,
                    onPressed: () {
                      viewModel.register(
                        context,
                        _usernameController.text.trim(),
                        _emailController.text.trim(),
                        _passwordController.text.trim(),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}