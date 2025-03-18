import 'package:flutter/material.dart';
import 'package:shop/components/appbar_default.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarDefault(title: 'Carrinho'),
      body: Text('carrinho'),
    );
  }
}