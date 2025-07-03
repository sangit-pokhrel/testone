import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghar_sewa/features/register/presentation/view_model/register_event.dart';
import 'package:ghar_sewa/features/register/presentation/view_model/register_state.dart';
import 'package:ghar_sewa/features/register/presentation/view_model/register_view_model.dart';
import 'package:ghar_sewa/view/login_screen.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;
  bool _agreeTerms = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignup() {
    if (!_agreeTerms) return;

    context.read<RegisterViewModel>().add(
      AddRegisterEvent(
        name: _fullNameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        phone: '', // Pass empty values if backend requires
        country: '',
        province: '',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterViewModel, RegisterState>(
      listener: (context, state) {
        if (state.isSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registration successful!')),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const LoginScreen()),
          );
        }

        if (state.isFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage ?? 'An error occurred')),
          );
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
                    "Create your account",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Sign up with your email and password",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 30),

                  _buildTextField(
                    hint: "Full Name",
                    icon: Icons.person_outline,
                    controller: _fullNameController,
                  ),
                  _buildTextField(
                    hint: "Email",
                    icon: Icons.email_outlined,
                    controller: _emailController,
                    inputType: TextInputType.emailAddress,
                  ),
                  _buildPasswordField(),

                  Row(
                    children: [
                      Checkbox(
                        value: _agreeTerms,
                        onChanged: (value) {
                          setState(() => _agreeTerms = value!);
                        },
                      ),
                      const Expanded(
                        child: Text.rich(
                          TextSpan(
                            text: "I agree to the ",
                            children: [
                              TextSpan(
                                text: "Terms & Conditions",
                                style: TextStyle(
                                  color: Color(0xFF8648DA),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed:
                          _agreeTerms && !state.isLoading
                              ? _handleSignup
                              : null,
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
                                "Sign Up",
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
                      const Text("Already have an account? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Sign In",
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

  Widget _buildTextField({
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    TextInputType inputType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextField(
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextField(
        controller: _passwordController,
        obscureText: _obscureText,
        decoration: InputDecoration(
          hintText: "Password",
          prefixIcon: const Icon(Icons.lock_outline),
          suffixIcon: IconButton(
            icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
            onPressed: () => setState(() => _obscureText = !_obscureText),
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
