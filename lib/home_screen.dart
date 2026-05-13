import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ChitChat',
          style: GoogleFonts.lemonada(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        actions: [
          // IconButton(
          //   onPressed: () async {
          //     await ref.read(authControllerProvider.notifier).signOut();
          //     if (context.mounted) {
          //       Navigator.of(context).pushAndRemoveUntil(
          //         MaterialPageRoute(builder: (context) => const Firstpage()),
          //         (route) => false,
          //       );
          //     }
          //   },
          //   icon: const Icon(Icons.logout),
          // ),
        ],
      ),
      body: Column(children: [
          
        ],
      ),
    );
  }
}
