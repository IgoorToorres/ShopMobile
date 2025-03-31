import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/appbar_default.dart';
import 'package:shop/features/cart/components/cart_item.dart';
import 'package:shop/models/cart/provider/cart_provider.dart';
import 'package:shop/features/cart/components/cart_button.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final items = cart.items.values.toList();

    return Scaffold(
      appBar: AppbarDefault(title: 'Carrinho'),
      drawer: AppDrawer(),
      body: Container(
        // Exemplo de cor de fundo sutil (opcional)
        color: Colors.grey.shade100,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Cartão de total
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    // Espaçamento entre o texto de total e o botão
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Parte do total
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'R\$${cart.totalAmount.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[700],
                            ),
                          ),
                        ],
                      ),
                      // Botão de compra
                      CartButton(cart: cart),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Lista de itens do carrinho
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (ctx, i) => CartItemWidget(
                    cartItem: items[i],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
