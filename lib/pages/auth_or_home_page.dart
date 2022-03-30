import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/components/auth_form.dart';
import 'package:shopapp/models/auth.dart';
import 'package:shopapp/pages/auth_page.dart';
import 'package:shopapp/pages/products_overview_page.dart';

class AuthOrHomePage extends StatelessWidget {
  const AuthOrHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of(context);
    return FutureBuilder(
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.error != null) {
          return const Center(
            child: Text('Ocorreu um erro!'),
          );
        } else {
          return auth.isAuth ? ProductsOverviewPage() : AuthPage();
        }
      },
      future: auth.tryAutoLogin(),
    );
  }
}
