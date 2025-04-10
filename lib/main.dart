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
          create: (_) => ProductList(),
          update: (ctx, auth, previous) {
            return ProductList(
              auth.token ?? '',
              previous?.items ?? [],
              auth.userId ?? '',
            );
          },
        ),
        ChangeNotifierProxyProvider<Auth, OrderList>(
          create: (_) => OrderList(),
          update: (ctx, auth, previous) {
            return OrderList(
              auth.token ?? '',
              previous?.items ?? [],
              auth.userId ?? '',
            );
          },
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
            seedColor: const Color(0xFF3A6351), // Verde escuro elegante
            brightness: Brightness.light,
          ).copyWith(
            primary: const Color(0xFF3A6351),
            onPrimary: Colors.white,
            secondary: const Color(0xFF8AB6A5),
            onSecondary: Colors.black,
            surface: const Color(0xFFF8F8F8),
            background: const Color(0xFFF1F1F1),
            error: Colors.redAccent,
          ),
          scaffoldBackgroundColor: const Color(0xFFF1F1F1),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF3A6351),
            foregroundColor: Colors.white,
            elevation: 2,
            centerTitle: true,
          ),
          snackBarTheme: const SnackBarThemeData(
            backgroundColor: Colors.black87,
            contentTextStyle: TextStyle(color: Colors.white),
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
