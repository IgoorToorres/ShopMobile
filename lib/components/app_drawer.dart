import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/features/order/pages/orders_page.dart';
import 'package:shop/models/auth/provider/auth.dart';
import 'package:shop/utils/app_routes.dart';
import 'package:shop/utils/custom_page_transition.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 120,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Bem vindo!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.shop, color: Colors.black87),
            title: const Text('Loja'),
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.AUTH_OR_HOME);
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.payment, color: Colors.black87),
            title: const Text('Pedidos'),
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.ORDERS);
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.edit, color: Colors.black87),
            title: const Text('Gerenciar Produtos'),
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.PRODUCTS);
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app, color: Colors.black87),
            title: const Text('Sair'),
            onTap: () {
              Provider.of<Auth>(context, listen: false).logOut();
              Navigator.of(context)
                  .pushReplacementNamed(AppRoutes.AUTH_OR_HOME);
            },
          ),
        ],
      ),
    );
  }
}
