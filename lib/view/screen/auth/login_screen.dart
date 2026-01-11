import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internship_project_template/view/screen/auth/register_screen.dart';
import 'package:provider/provider.dart';
import '../../../constant/application_colors.dart';
import '../../../viewmodel/auth_viewmodel.dart';
import '../../widget/auth_textfield.dart';
import '../../widget/shadow_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  bool _isObscure = true;

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
                    "hilingo macerana hoşgeldin!",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      overflow: TextOverflow.ellipsis
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Kaldığın yerden devam et.",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 40),

                  AuthTextField(
                    controller: _emailController,
                    hintText: "E-posta Adresi",
                    icon: Icons.email_outlined,
                  ),
                  AuthTextField(
                    controller: _passwordController,
                    hintText: "Parola",
                    icon: Icons.lock_outline,
                    isPassword: true,
                    obscureText: _isObscure,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscure ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    ),
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Şifreni mi unuttun?",
                        style: TextStyle(color: ApplicationColors.accent, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  ShadowButton(
                    text: "Giriş Yap",
                    isLoading: viewModel.isLoading,
                    onPressed: () {
                      viewModel.login(
                        context,
                        _emailController.text.trim(),
                        _passwordController.text.trim(),
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(child: Divider(color: Colors.grey.shade300)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text("veya", style: TextStyle(color: Colors.grey.shade500)),
                      ),
                      Expanded(child: Divider(color: Colors.grey.shade300)),
                    ],
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: OutlinedButton.icon(
                      onPressed: () => viewModel.logInWithGoogle(),
                      icon: Image.asset('assets/icons/google_icon.png', height: 24),
                      label: const Text(
                        "Google ile devam et",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        side: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Hesabın yok mu?", style: TextStyle(color: Colors.grey)),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterScreen()));
                        },
                        child: const Text(
                          "Kayıt Ol",
                          style: TextStyle(color: ApplicationColors.accent, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
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