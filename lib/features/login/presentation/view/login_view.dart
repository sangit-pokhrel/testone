import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghar_sewa/features/login/presentation/view_model/login_event.dart';
import 'package:ghar_sewa/features/login/presentation/view_model/login_state.dart';
import 'package:ghar_sewa/features/login/presentation/view_model/login_view_model.dart';
import 'package:ghar_sewa/view/main_navbar_page.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    context.read<LoginViewModel>().add(
      CheckLoginEvent(email: email, password: password),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginViewModel, LoginState>(
      listener: (context, state) {
        if (state.isFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage ?? 'Login failed')),
          );
        }

        if (state.isSuccess && state.loginMatched == true) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Login Successful!")));

          Future.delayed(const Duration(milliseconds: 500), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const MainNavbarPage()),
            );
          });
        }

        if (state.isSuccess && state.loginMatched == false) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Invalid credentials")));
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFF9F9FB),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Center(
                    child: Image.asset(
                      'assets/logo/removed-blacklogo.jpg',
                      height: 100,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Welcome Back!",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Login to continue using GharSewa.",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 30),

                  // Email Field
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Email address",
                      prefixIcon: const Icon(Icons.email_outlined),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Password Field
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      hintText: "Password",
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(color: Color(0xFF8648DA)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: state.isLoading ? null : _handleLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8648DA),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child:
                          state.isLoading
                              ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                              : const Text(
                                "Sign In",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                    ),
                  ),

                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("New here? "),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/register'),
                        child: const Text(
                          "Create Account",
                          style: TextStyle(
                            color: Color(0xFF8648DA),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
