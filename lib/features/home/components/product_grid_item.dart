import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/auth/provider/auth.dart';
import 'package:shop/models/cart/provider/cart_provider.dart';
import 'package:shop/utils/app_routes.dart';
import '../../../models/product/product.dart';

class ProductGridItem extends StatelessWidget {
  const ProductGridItem({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Card(
        elevation: 0,
        color: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.PRODUCT_DETAIL,
              arguments: product,
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Imagem com Hero
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: Hero(
                    tag: product.id,
                    child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              // Nome + botão de favorito
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        product.name,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Consumer<Product>(
                      builder: (ctx, productConsumer, _) => IconButton(
                        iconSize: 20,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: Icon(
                          productConsumer.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                        ),
                        color: productConsumer.isFavorite
                            ? Colors.redAccent
                            : Colors.grey,
                        onPressed: () {
                          productConsumer.toggleFavorite(
                            auth.token ?? '',
                            auth.userId ?? '',
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Botão "Adicionar ao carrinho"
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  onPressed: () {
                    cart.addItem(product);
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Produto adicionado ao carrinho!'),
                        duration: const Duration(seconds: 2),
                        action: SnackBarAction(
                          label: 'DESFAZER',
                          textColor: Theme.of(context).colorScheme.secondary,
                          onPressed: () {
                            cart.removeSingleItem(product.id);
                          },
                        ),
                      ),
                    );
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Adicionar ao carrinho', style: TextStyle(fontSize: 15),),
                    ],
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
