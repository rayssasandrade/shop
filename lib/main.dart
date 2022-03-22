import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/models/auth.dart';
import 'package:shopapp/models/cart.dart';
import 'package:shopapp/models/order_list.dart';
import 'package:shopapp/pages/auth_page.dart';
import 'package:shopapp/pages/cart_page.dart';
import 'package:shopapp/pages/orders_page.dart';
import 'package:shopapp/pages/product_detail_page.dart';
import 'package:shopapp/pages/product_form_page.dart';
import 'package:shopapp/pages/products_overview_page.dart';
import 'package:shopapp/pages/products_page.dart';
import 'package:shopapp/utils/app_routes.dart';
import 'models/product_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
        ChangeNotifierProvider(
          create: (_) => OrderList(),
        ),
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          accentColor: Colors.deepOrange.shade400,
          canvasColor: const Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Lato',
        ),
        //home: AuthPage(),
        routes: {
          AppRoutes.AUTH: (ctx) => AuthPage(),
          AppRoutes.HOME: (ctx) => ProductsOverviewPage(),
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
