import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GoNamedBackButtonTesting extends StatelessWidget implements PreferredSizeWidget {
  final String name;

  const GoNamedBackButtonTesting({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {

    void goBack() {
      context.goNamed(name);
    }

    return AppBar(
      leading: BackButton(
        onPressed: goBack,
      ),
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}