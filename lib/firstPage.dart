import 'package:ecom_app/forgetPage.dart';
import 'package:ecom_app/home_screen.dart';
import 'package:ecom_app/riverpod/auth_provider.dart';
import 'package:ecom_app/signupPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Firstpage extends ConsumerStatefulWidget {
  const Firstpage({super.key});

  @override
  ConsumerState<Firstpage> createState() => _FirstpageState();
}

class _FirstpageState extends ConsumerState<Firstpage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      await ref
          .read(authControllerProvider.notifier)
          .signIn(
            _emailController.text.trim(),
            _passwordController.text.trim(),
          );

      // Check for errors after attempt
      final authState = ref.read(authControllerProvider);
      if (authState.hasError && mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(authState.error.toString())));
      } else if (!authState.isLoading && !authState.hasError && mounted) {
        // Verify if user is actually logged in
        if (ref.read(authServiceProvider).currentUser != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Login Successful!")));

          if (mounted) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const HomeScreen()),
              (route) => false,
            );
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    return Scaffold(
      body: SingleChildScrollView(
        // Added scroll view to avoid overflow
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 80),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    "Welcome MATE!",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  // const SizedBox(height: 16),
                  // Image.asset('assets/images/logo.png', height: 60, width: 120),
                  const SizedBox(height: 16),
                  const Text(
                    "Connect, chat, and stay close with your friends anytime.",
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                // Added Form widget
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ListTile(title: Text("Email")),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 8),
                      child: TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          isDense: true,
                          label: const Text("Email"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    const ListTile(title: Text("Password")),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 8),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: true, // Hide password
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          isDense: true,
                          label: const Text("Password"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    // Forget Password Link
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 4,
                      ),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const Forgetpassword(),
                              ),
                            );
                          },
                          child: const Text(
                            "Forget Password",
                            style: TextStyle(
                              // fontWeight: FontWeight.bold,
                              fontSize: 12,
                              //decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          authState.isLoading
                              ? const CircularProgressIndicator()
                              : FilledButton(
                                  onPressed: _handleLogin,
                                  child: const Text("Sign in "),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: GestureDetector(
                onTap: () {
                  // Navigate to Signup
                  // Since I don't have named routes, I'll use direct navigation
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const Signup(),
                    ), // Placeholder, need to import if not available
                  );
                },
                child: RichText(
                  text: const TextSpan(
                    text: "Don't have an account? ",
                    style: TextStyle(color: Colors.white),
                    children: [
                      TextSpan(
                        text: "Sign up",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
