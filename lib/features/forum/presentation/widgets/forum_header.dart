import 'package:flutter/material.dart';

class ForumHeader extends StatelessWidget implements PreferredSizeWidget {
  const ForumHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Forum'),
      backgroundColor: Colors.blue,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
