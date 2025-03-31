import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart/provider/cart_provider.dart';
import 'package:shop/models/order/provider/order_provider.dart';

class CartButton extends StatefulWidget {
  const CartButton({
    super.key,
    required this.cart,
  });

  final Cart cart;

  @override
  State<CartButton> createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? CircularProgressIndicator()
        : ElevatedButton(
            onPressed: widget.cart.intemsCount == 0
                ? null
                : () async {
                    setState(() => _isLoading = true);

                    await Provider.of<OrderList>(
                      context,
                      listen: false,
                    ).addOrder(widget.cart);

                    setState(() => _isLoading = false);
                    widget.cart.clear();
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              elevation: 2, // Leve sombra
            ),
            child: const Text(
              'Comprar',
              style: TextStyle(fontSize: 16),
            ),
          );
  }
}
