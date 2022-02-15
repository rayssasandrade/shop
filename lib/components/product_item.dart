import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/models/cart.dart';
import 'package:shopapp/models/product.dart';
import 'package:shopapp/utils/app_routes.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(
      context,
      listen: false,
    );
    final cart = Provider.of<Cart>(
      context,
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: GridTile(
          child: GestureDetector(
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
            onTap: () {
              Navigator.of(context).pushNamed(
                AppRoutes.PRODUCT_DETAIL,
                arguments: product,
              );
            },
          ),
          footer: GridTileBar(
            backgroundColor: Colors.white38,
            title: Text(
              product.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
            trailing: Row(
              children: [
                Consumer<Product>(
                  child: Column(
                    children: const [Text('Algo que nunca muda!')],
                  ),
                  builder: (ctx, product, child) => IconButton(
                    onPressed: () {
                      product.toggleFavorite();
                    },
                    icon: Icon(product.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border),
                    color: Theme.of(context).accentColor,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    cart.addItem(product);
                  },
                  icon: const Icon(Icons.shopping_cart),
                  color: Theme.of(context).accentColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
