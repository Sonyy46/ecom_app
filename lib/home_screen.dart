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
          Row(
            children: [
              PopupMenuButton(
                onSelected: (item) {},
                itemBuilder: (BuildContext context) => [
                  const PopupMenuItem(
                    height: 40,
                    value: 3,
                    child: Row(children: [Text('New Group')]),
                  ),
                  const PopupMenuItem(
                    height: 40,
                    value: 3,
                    child: Row(children: [Text('Starred Messages')]),
                  ),
                  const PopupMenuItem(
                    height: 40,
                    value: 3,
                    child: Row(children: [Text('New Chat')]),
                  ),
                  const PopupMenuItem(
                    height: 40,
                    value: 3,
                    child: Row(children: [Text('Mark as Read')]),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                  onPressed: () async {
                    // if (context.mounted) {
                    //   Navigator.of(context).pushAndRemoveUntil(
                    //     MaterialPageRoute(builder: (context) => const Firstpage()),
                    //     (route) => false,
                    //   );
                    // }
                  },
                  icon: const Icon(Icons.message_outlined),
                ),
              ),
            ],
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              style: const TextStyle(fontSize: 14),
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
              ),
            ),
          ),
        ),
      ),
      body: Column(children: [
          
        ],
      ),
    );
  }
}
