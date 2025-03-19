import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/pages/cart_page.dart';
import 'package:shop/pages/product_detail_page.dart';
import 'package:shop/pages/products_overview_page.dart';
import 'package:shop/utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductList(),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Lato',
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF5B7867),
            brightness: Brightness.light,
          ).copyWith(
            primary: const Color(0xFF5B7867), // Verde acinzentado
            onPrimary: Colors.white, // Texto em cima do primary
            secondary: const Color(0xFF888888), // Cinza Médio
            onSecondary: Colors.white, // Texto em cima do secondary
            background: const Color(0xFFF2F2F2), // Cinza Claro
            onBackground: const Color(0xFF333333), // Texto em fundos claros
            surface: Colors.white, // Branco para fundos principais
            onSurface: const Color(0xFF333333), 
          ),
        ),
        home: ProductsOverviewPage(),
        routes: {
          AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetailPage(),
          AppRoutes.CART: (ctx) => CartPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
