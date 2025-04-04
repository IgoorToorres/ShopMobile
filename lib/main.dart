import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/features/auth/pages/auth_or_home_page.dart';
import 'package:shop/models/auth/provider/auth.dart';
import 'package:shop/models/cart/provider/cart_provider.dart';
import 'package:shop/models/order/provider/order_provider.dart';
import 'package:shop/models/product/provider/product_provider.dart';
import 'package:shop/features/cart/pages/cart_page.dart';
import 'package:shop/features/order/pages/orders_page.dart';
import 'package:shop/features/product_info/pages/product_detail_page.dart';
import 'package:shop/features/products/pages/product_form_page.dart';
import 'package:shop/features/products/pages/products_page.dart';
import 'package:shop/utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, ProductList>(
          create: (_) => ProductList('', []),
          update: (ctx, auth, previous){
            return ProductList(auth.token ?? '', previous?.items ?? []);
          },
          
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderList(),
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
            surface: Colors.white, // Branco para fundos principais
          ),
        ),
        // home: ProductsOverviewPage(),
        routes: {
          AppRoutes.AUTH_OR_HOME: (ctx) => AuthOrHomePage(),
          AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetailPage(),
          AppRoutes.CART: (ctx) => CartPage(),
          AppRoutes.ORDERS: (ctx) => OrdersPage(),
          AppRoutes.PRODUCTS: (ctx) => ProductsPage(),
          AppRoutes.PRODUCT_FORM: (ctx) => ProductFormPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
