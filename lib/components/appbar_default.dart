import 'package:flutter/material.dart';

class AppbarDefault extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const AppbarDefault({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: Builder(
        builder: (context) => IconButton(
          onPressed: () => Scaffold.of(context).openDrawer(),
          icon: Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 25,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
