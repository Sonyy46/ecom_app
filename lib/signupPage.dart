import 'package:ecom_app/firstPage.dart';
import 'package:ecom_app/home_screen.dart';
import 'package:ecom_app/riverpod/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Signup extends ConsumerStatefulWidget {
  const Signup({super.key});

  @override
  ConsumerState<Signup> createState() => _SignupState();
}

class _SignupState extends ConsumerState<Signup> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignup() async {
    if (_formKey.currentState!.validate()) {
      await ref
          .read(authControllerProvider.notifier)
          .signUp(
            _emailController.text.trim(),
            _passwordController.text.trim(),
            displayName: _nameController.text.trim(),
          );

      final authState = ref.read(authControllerProvider);

      if (authState.hasError && mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(authState.error.toString())));
      } else if (!authState.isLoading && !authState.hasError && mounted) {
        // Success
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Account Created Successfully!")),
        );

        if (mounted) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (route) => false,
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    return Scaffold(
      body: SingleChildScrollView(
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
                children: const [
                  SizedBox(height: 16),
                  Text(
                    "Create Your Account!",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Sign up for exciting offers and more fashion and electronics!",
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ListTile(title: Text("Full Name")),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 8),
                        child: TextFormField(
                          controller: _nameController,
                          validator: (value) =>
                              value!.isEmpty ? "Enter Name" : null,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: "Enter your name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      const ListTile(title: Text("Mobile Number")),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 8),
                        child: TextFormField(
                          controller: _mobileController,
                          validator: (value) =>
                              value!.isEmpty ? "Enter Mobile" : null,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: "Enter your mobile number",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      const ListTile(title: Text("Email")),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 8),
                        child: TextFormField(
                          controller: _emailController,
                          validator: (value) =>
                              value!.isEmpty ? "Enter Email" : null,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: "Enter your email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      const ListTile(title: Text("Create Password")),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 8),
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          validator: (value) =>
                              value!.length < 6 ? "Password too short" : null,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: "Enter your password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            authState.isLoading
                                ? const CircularProgressIndicator()
                                : FilledButton(
                                    onPressed: _handleSignup,
                                    child: const Text("Register "),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const Firstpage()),
                  );
                },
                child: RichText(
                  text: const TextSpan(
                    text: "Already have an account? ",
                    style: TextStyle(color: Colors.white),
                    children: [
                      TextSpan(
                        text: "Sign In",
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
